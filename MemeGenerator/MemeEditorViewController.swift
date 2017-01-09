//
//  MemeEditorViewController.swift
//  MemeGenerator
//
//  Created by Chandak, Vishal on 26/12/16.
//  Copyright © 2016 Chandak, Vishal. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Outlets
    
    @IBOutlet weak var imageViewer: UIImageView!
    
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var cancelOutlet: UIBarButtonItem!
    @IBOutlet weak var shareOutlet: UIBarButtonItem!
    @IBOutlet weak var topTextFieldEditor: UITextField!
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet private weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomTextFieldEditor: UITextField!
    
    let memeDelegate = MemeTextFieldDelegate()
    var keyboardUtils: KeyboardUtils!
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        keyboardUtils = KeyboardUtils(view: view, bottomTextField: bottomTextFieldEditor)
        keyboardUtils.subscribeToKeyboardNotifications()
        keyboardUtils.subscribeToKeyboardHideNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyboardUtils.unsubscribeFromKeyboardNotifications()
        keyboardUtils.unsubscribeFromKeyboardHideNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setTextFields(textField: topTextFieldEditor)
        setTextFields(textField: bottomTextFieldEditor)
    }
    
    func setTextFields(textField:UITextField){
        
        let memeTextAttributes:[String:Any] = [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2.0]
        
        textField.delegate = memeDelegate
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
    }

    
    @IBAction func imagePicker(_ sender: Any) {
        pick(sourceType: .photoLibrary)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pick(sourceType: .camera)
    }
    
    func pick(sourceType: UIImagePickerControllerSourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func shareButton(_ sender: Any) {
        let memedImage = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                let _ = self.save()
            }
        }
        present(controller, animated: true, completion: nil)
    }

    
    @IBAction func cancelButton(_ sender: Any) {
        resetToDefault()
    }
    
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo: [String : Any]) {
        if let image = didFinishPickingMediaWithInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewer.backgroundColor = UIColor.white
            imageViewer.image = image
            shareOutlet.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    func save() -> Meme{
        
        let meme = Meme(topText: topTextFieldEditor.text!, bottomText: bottomTextFieldEditor.text!, originalImage: imageViewer.image!, memedImage: generateMemedImage())
        return meme
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hide Toolbars
        hideToolbars()
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //Show Toolbars
        showToolbars()
        
        return memedImage
    }
    
    func resetToDefault() {
        shareOutlet.isEnabled = false
        topTextFieldEditor.text = Constants.defaultTextTop as String
        bottomTextFieldEditor.text = Constants.defaultTextBottom as String
        imageViewer.image = nil
        topTextFieldEditor.resignFirstResponder()
        bottomTextFieldEditor.resignFirstResponder()
    }
    
    func hideToolbars() {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
    }
    
    func showToolbars() {
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
    }
}

