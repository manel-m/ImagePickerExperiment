//
//  ViewController.swift
//  ImagePickerExperiment
//
//  Created by Manel matougui on 2/21/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickAnImage(_ sender: Any) {
        let pickController = UIImagePickerController()
        present(pickController, animated: true, completion: nil)
    }
    
    
    
    
}

