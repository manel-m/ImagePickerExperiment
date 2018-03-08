//
//  ViewController.swift
//  ImagePickerExperiment
//
//  Created by Manel matougui on 2/21/18.
//  Copyright © 2018 udacity. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottonTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var navbar: UIToolbar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottonTextField.text = "BOTTOM"
        topTextField.textAlignment = .center
        bottonTextField.textAlignment = .center
        topTextField.delegate = self
        bottonTextField.delegate = self
        shareButton.isEnabled = false
        topTextField.adjustsFontSizeToFitWidth = true
        bottonTextField.adjustsFontSizeToFitWidth = true
      
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
        textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        // Setting font style and color
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
            NSAttributedStringKey.strokeWidth.rawValue: -6.0]
        topTextField.defaultTextAttributes = memeTextAttributes
        bottonTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textColor = UIColor.white
        subscribeToKeyboardNotifications()
        
    }
    // Code for Keyboard Adjustments
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    // move the view up when the keyboard up
    @objc func keyboardWillShow(_ notification:Notification) {
        if bottonTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    // move the view back down when the keyboard is dismissed
    @objc func keyboardWillHide (_ notification:Notification) {
            view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    // Camera button for Picking Image from Camera
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
   // Album button for picking Image from Album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        present(pickController, animated: true, completion: nil)
    }
    // Cancel button: the Meme Editor View returns to its launch state
    @IBAction func cancel(_ sender: Any) {
        topTextField.text = "TOP"
        bottonTextField.text = "BOTTOM"
        topTextField.textAlignment = .center
        bottonTextField.textAlignment = .center
        topTextField.delegate = self
        bottonTextField.delegate = self
        shareButton.isEnabled = false
        imagePickerView.image = nil
    }
    
    // Sharing a Meme using an Activity View
    @IBAction func share(_ sender: Any) {
        let memedImage = generateMemedImage()
        let activityView = UIActivityViewController (activityItems: [memedImage], applicationActivities: nil)
        activityView.completionWithItemsHandler = {
            (activity, success, items, error) in
            if(success && error == nil){
                self.save()
                self.dismiss(animated: true, completion: nil);
            }
            else if (error != nil){
                //log the error
            }
        };
        present(activityView, animated: true, completion: nil)
    }
    // launch Image Picker Controller
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
           // imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
        shareButton.isEnabled = true
    }
    
    // Cancel button of image picker controller
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    // the Meme model
    struct Meme {
        var  topText: String
        var  bottomText: String
        var  originalImage: UIImage
        var  memedImage: UIImage
    }
    
    func generateMemedImage() -> UIImage {
        
        // hide navbar and toolbar
        navbar.isHidden = true
        toolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // show navbar and toolbar
        navbar.isHidden = false
        toolbar.isHidden = false

        return memedImage
    }
    func save() {
        let memedImage = generateMemedImage()
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottonTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
    }
 
}

