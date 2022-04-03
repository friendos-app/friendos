//
//  EditProfileViewController.swift
//  friendos
//
//  Created by Daniel Ruiz on 3/21/22.
//

import UIKit
import AlamofireImage
import Parse
import MultiSelectSegmentedControl

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var interestSelector: MultiSelectSegmentedControl!
    
    // Variable to hold interest
    var interests_list: [String] = [String]()
    var interest_objs: [PFObject] = [PFObject]()

    
    // Update background colors
    func updateColors() {
        // Setup background color
        if let background_color_string = UserDefaults.standard.string(forKey: "background_color") {
            print(background_color_string)
            let background_color = UIColor(named: background_color_string)!
            view.backgroundColor = background_color
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateColors()
        
        // Set up placeholder text color
        bioField.attributedPlaceholder = NSAttributedString(string: "Enter new bio here...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        // Get the list of available interests
        let query = PFQuery(className: "Interests")
        
        
        query.findObjectsInBackground { objects, error in
            if let interests = objects {
                self.interest_objs = interests
                for interest in interests {
                    self.interests_list.append(interest["interest"] as! String)
                    
                }
                self.interestSelector.isVertical = true
                self.interestSelector.items = self.interests_list
            }
        }

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
        
        // Remove all current interests
        let del_query = PFQuery(className: "UserInterests")
        del_query.whereKey("user_id", equalTo: PFUser.current())
        
        del_query.findObjectsInBackground { objects, error in
            if (error == nil) {
                PFObject.deleteAll(inBackground: objects)
                
                // Save updated interests
                let selectedIndices: IndexSet = self.interestSelector.selectedSegmentIndexes
                for index in selectedIndices {
                    var new_interest = PFObject(className: "UserInterests")
                    new_interest["user_id"] = PFUser.current()
                    new_interest["interest_id"] = self.interest_objs[index]
                    new_interest.saveInBackground()
                }
                
            }
        }
        

        
        
        
        
        

            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateColors()
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
