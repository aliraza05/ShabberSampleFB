//
//  MainViewController.swift
//  FirebaseStarterApp
//
//  Created by Ali Raza on 26/11/2019.
//  Copyright © 2019 Instamobile. All rights reserved.
//

import UIKit
import FBSDKShareKit
import FBSDKCoreKit

class MainViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,SharingDelegate {
    
    

    @IBOutlet weak var imgView: UIImageView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }


    @IBAction func selectImgAction(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func postImageAction(_ sender: Any) {
        
        let hasPermission = AccessToken.current?.hasGranted(permission: "publish_actions")
        
        if hasPermission!
        {
            let content = SharePhotoContent()
            content.photos = [SharePhoto(image: imgView.image!, userGenerated: true)]
            let share = ShareAPI.init(content: content, delegate: self)
            share.share()
            
        }else
        {
            print("require publish_actions permissions")

        }
    }
    
    // MARK: - ShareAPIDelegate Delegate
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        alertShow(typeStr: "Success sharing")
    }
    
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        alertShow(typeStr: "Unable to post")
    }
    func sharerDidCancel(_ sharer: Sharing) {
        alertShow(typeStr: "Cancel sharing")

    }
    
    func alertShow(typeStr: String) {
        let alertController = UIAlertController(title: "", message: typeStr+" Posted!", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - ImagePicker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.imgView.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.imgView.image = selectedImage!
            picker.dismiss(animated: true, completion: nil)
        }
        
        let photo:SharePhoto = SharePhoto()
        
        photo.image = selectedImage
        photo.isUserGenerated = true
        
        let content:SharePhotoContent = SharePhotoContent()
        content.photos = [photo]
        
        let shareButton = FBShareButton()
        shareButton.center = view.center
        
        
        shareButton.shareContent = content
        
        shareButton.center = self.view.center
        self.view.addSubview(shareButton)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
