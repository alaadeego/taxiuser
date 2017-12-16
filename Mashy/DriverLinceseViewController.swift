//
//  DriverLinceseViewController.swift
//  Mashy
//
//  Created by Amal Khaled on 11/9/17.
//  Copyright © 2017 amany. All rights reserved.
//

import UIKit

class DriverLinceseViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet var uploadedImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,action: #selector(imageTapped))
        uploadedImage.isUserInteractionEnabled = true
        uploadedImage.addGestureRecognizer(tapGestureRecognizer)

     
        
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imageTapped(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        uploadedImage.image = image
         AppDelegate.currentDriver.lincese = "done"
        AppDelegate.uploadedImages.append(image)
        let data:Data = UIImageJPEGRepresentation(uploadedImage.image! , 0.5)!
        let base64String:String = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//        var imageData = UIImageJPEGRepresentation(uploadedImage.image!, 0.6)
//        var compressedJPGImage = UIImage(data: imageData!)
//        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
//
        let imageStr:String = base64String.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        AppDelegate.currentDriver.lincese = imageStr

        
        dismiss(animated:true, completion: nil)

    }

    
    @IBAction func nextButtonClicked(_ sender: Any) {
        if AppDelegate.currentDriver.lincese != ""{
            Services.services.DriverLogin(uiViewController: self)
//            performSegue(withIdentifier: "id_image", sender: self)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
