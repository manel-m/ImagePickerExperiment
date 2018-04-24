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
    @IBOutlet weak var flawLayout: UICollectionViewFlowLayout!
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        collectionView?.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sent Memes"
        //flowLayout
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        flawLayout.minimumInteritemSpacing = space
        flawLayout.minimumLineSpacing = space
        flawLayout.itemSize = CGSize(width: dimension, height: dimension)
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailView") as! MemeDetailView
        
        //Populate view controller with data from the selected item
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Present the view controller using navigation
        navigationController!.pushViewController(detailController, animated: true)
    }
    
    
}
