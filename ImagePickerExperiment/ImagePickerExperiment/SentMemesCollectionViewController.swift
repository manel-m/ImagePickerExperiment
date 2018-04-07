//
//  SentMemesCollectionViewController.swift
//  ImagePickerExperiment
//
//  Created by Manel matougui on 4/6/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import UIKit
class SentMemesCollectionViewController : UICollectionViewController {
    var memes : [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView?.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        // Set the image
        cell.MemeImageView?.image =  meme.memedImage
        
        return cell
    }
    
    
}
