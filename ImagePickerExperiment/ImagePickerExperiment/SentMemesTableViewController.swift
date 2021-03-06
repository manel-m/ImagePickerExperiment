//
//  Sent Memes Table View Controllers.swift
//  ImagePickerExperiment
//
//  Created by Manel matougui on 4/6/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import Foundation
import  UIKit
class SentMemesTableViewController : UITableViewController {

    var memes : [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sent Memes"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the text and image
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailView") as! MemeDetailView
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
        
        
    }
 
    
   
  
    
}
