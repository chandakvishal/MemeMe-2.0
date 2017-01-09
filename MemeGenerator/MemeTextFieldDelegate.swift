//
//  MemeTextFieldDelegate.swift
//  MemeGenerator
//
//  Created by Chandak, Vishal on 26/12/16.
//  Copyright © 2016 Chandak, Vishal. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var tempValue: NSString = ""
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tempValue = textField.text! as NSString
        if tempValue == Constants.defaultTextTop || tempValue == Constants.defaultTextBottom {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let currentText = textField.text! as NSString
        if currentText.length == 0 {
            textField.text = tempValue as String
        }
    }
}
