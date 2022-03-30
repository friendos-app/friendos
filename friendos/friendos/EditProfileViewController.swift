//
//  EditProfileViewController.swift
//  friendos
//
//  Created by Daniel Ruiz on 3/21/22.
//

import UIKit
import AlamofireImage
import Parse

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var bioField: UITextField!
    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitEdit(_ sender: Any) {
        
        let user = PFUser.current()
        
        user?["bio"] = bioField.text
        
        let imageData = imageView.image!.pngData()!
        let file = PFFileObject(name: "profileImage.png", data: imageData)
        
        user?["image"] = file
        
        user?.saveInBackground(block: { success, error in
            if (success) {
                print("Save worK!")
                self.dismiss(animated: true, completion: nil)
            }
            
            else {
                print("Save no work!")
            }
        })
        
        

            
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        
        // Let special built-in view controller for camera picker view.
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
     
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageScaled(to: size)
        
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
