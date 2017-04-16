//
//  MemeCollectionViewController.swift
//  MemeGenerator
//
//  Created by Chandak, Vishal on 30/01/17.
//  Copyright © 2017 Chandak, Vishal. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let cellWidth = (view.frame.size.width - (5 * space)) / 3.0
        let height1 = (view.frame.size.height - (5 * space)) / 3.0
        flowlayout.minimumInteritemSpacing = space
        flowlayout.itemSize = CGSize(width:cellWidth,height:height1)
    }
    
    var memes : [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCollectionViewCell", for: indexPath) as! SentMemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.memeView?.image = meme.memedImage
        cell.memeLabel?.text = memes[indexPath.row].topText + "..." + memes[indexPath.row].bottomText
        
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier:
            "SentMemeDetailView") as! SentMemeDetailView
        detailController.meme = memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
