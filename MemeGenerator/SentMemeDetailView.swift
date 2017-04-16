//
//  SentMemeDetailView.swift
//  MemeGenerator
//
//  Created by Chandak, Vishal on 31/01/17.
//  Copyright © 2017 Chandak, Vishal. All rights reserved.
//

import Foundation
import UIKit

class SentMemeDetailView: UIViewController {
    
    // MARK: Properties
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
