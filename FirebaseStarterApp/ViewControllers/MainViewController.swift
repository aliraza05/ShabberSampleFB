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

extension UIDevice {
    static var isSimulator: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] != nil
    }
}

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

        #if targetEnvironment(simulator)
        // Simulator
        imagePicker.sourceType = .photoLibrary

        #else
        // Device
        imagePicker.sourceType = .camera

        #endif

        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postImageAction(_ sender: Any) {
        
        
        let content = SharePhotoContent()
        content.photos = [SharePhoto(image: imgView.image!, userGenerated: true)]
        
        let dialog = ShareDialog(
            fromViewController: self,
            content: content,
            delegate: self
        )
        dialog.mode = .automatic
        dialog.show()
        /*
        var hasPermission = AccessToken.current?.hasGranted(permission: "publish_actions")
        hasPermission = true
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
 */
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
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
