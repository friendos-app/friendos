//
//  ProfileViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/16/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhotoView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userBio: UILabel!
    
    
    // user_list will just be a list with a single dictioary.
    var user_list = [PFObject]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // User is set to current logged in user.
        let user = PFUser.current()
        print("user here = ", user)
        print(user!["username"])

        
        // Get the objectId of the current user.
        let cur_user_object_id = user?["objectId"]
        print("cur_user_object_id = ", cur_user_object_id)
        
        
        // Set up query.
        let query = PFUser.query()
        print("cur_query = ", query)
    
        
        query!.whereKey("username", equalTo: user!["username"])

        query!.findObjectsInBackground(block: { [self] (objects, error) in
            if (error == nil) {
                if let cur_user_object = objects {
                    self.user_list = cur_user_object
                    print("AHAHA = ", self.user_list)
                    
                    usernameLabel.text = user_list[0]["username"] as? String
                    userBio.text = user_list[0]["bio"] as? String
                    
                    if let imageFile = user?["image"] as? PFFileObject {
                        let urlString = imageFile.url!
                        let url = URL(string: urlString)!
                        profilePhotoView.af.setImage(withURL: url)
                    }
//                    let urlString = imageFile.url!
//                    let url = URL(string: urlString)!
//
//                    cell.photoView.af.setImage(withURL: url)
                    
                    
                }
            }
            
            else {
                print("error here")
            }
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //self.viewDidLoad()
        
        // User is set to current logged in user.
        let user = PFUser.current()
        print("user here = ", user)
        print(user!["username"])

        
        // Get the objectId of the current user.
        let cur_user_object_id = user?["objectId"]
        print("cur_user_object_id = ", cur_user_object_id)
        
        
        // Set up query.
        let query = PFUser.query()
        print("cur_query = ", query)
    
        
        query!.whereKey("username", equalTo: user!["username"])

        query!.findObjectsInBackground(block: { [self] (objects, error) in
            if (error == nil) {
                if let cur_user_object = objects {
                    self.user_list = cur_user_object
                    print("AHAHA = ", self.user_list)
                    
                    usernameLabel.text = user_list[0]["username"] as? String
                    userBio.text = user_list[0]["bio"] as? String
                    
                    if let imageFile = user?["image"] as? PFFileObject {
                        let urlString = imageFile.url!
                        let url = URL(string: urlString)!
                        profilePhotoView.af.setImage(withURL: url)
                    }
                   
                    
//                    let urlString = imageFile.url!
//                    let url = URL(string: urlString)!
//
//                    cell.photoView.af.setImage(withURL: url)
                    
                    
                }
            }
            
            else {
                print("error here")
            }
        })
        
        
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
