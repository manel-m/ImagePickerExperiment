//
//  MemeDetailView.swift
//  ImagePickerExperiment
//
//  Created by Manel matougui on 4/24/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
class MemeDetailView : UIViewController {
    var meme : Meme!

    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
    }
    
    
}
