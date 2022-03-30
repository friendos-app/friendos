//
//  HomeViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/16/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var UserProfiles: UITableView!
    
    // List of users that are not the current user.
    var user_list = [PFObject]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user_list.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UserProfiles.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        
        print("*****")
        let cur_user = user_list[indexPath.row]
        print(cur_user)
        print("*****")
        
        cell.UserUsername!.text = cur_user["username"] as! String
        
        if cur_user["bio"] != nil {
            cell.UserBio!.text = cur_user["bio"] as! String
        }
        else {
            cell.UserBio!.text = "User has empty bio" 
        }
        
        return cell
        
    }
    
    

  
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("help")
        
        let user = PFUser.current()
        // Get user bio and photo
        //print("user = ", user)
        
  
        let user_object_id = user?["objectId"]
        print("user_object_id = ", user_object_id)
        
        
        // Find interests
        let query = PFUser.query()
        print("query = ", query)
        
        
        //query.includeKey("interest_id")
        query!.whereKey("objectId", notEqualTo: user_object_id)
    
        

        // Loop through results and put interests into the array
        // This happens in the background, so need call reload view when complete
        query!.findObjectsInBackground(block: { (objects, error) in
            if (error == nil) {
                if let user_object_ids_list = objects {
                    // print(user_object_ids_list)
                    self.user_list = user_object_ids_list
                    print(self.user_list.count)
                    
                    self.UserProfiles.reloadData()
     
                    
                }
//                if let interest_list = objects{
//                    for interest in interest_list {
//                        if interest["interest_id"] != nil {
//                            print("")
//                            let cur_interest = interest["interest_id"] as! PFObject
//
//                            interests.append(cur_interest["interest"] as! String)
//                        }
//                        else {
//                            print("Interests is set to nil")
//                        }
//                    }
//
//                    print(interests)
//                }

            } else {
                print("Error")
            }
        })
        
        

        UserProfiles.dataSource = self
        UserProfiles.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
         print("Loading up the userdetails screen")
         let cell = sender as! UITableViewCell
         let indexPath = UserProfiles.indexPath(for: cell)!
         let user = user_list[indexPath.row]
         
//         if let imageFile = user?["image"] as? PFFileObject {
//             let urlString = imageFile.url!
//             let url = URL(string: urlString)!
//             userImage.af.setImage(withURL: url)
//         }
         
         //Send userName as a string from HomeViewController to ProfileViewCOntroller
         let new_username = user["username"] as? String
         let username_dict = ["username":new_username]
         //Send user bio as a string from HomeViewController to ProfileViewCOntroller
         let new_bio = user["bio"] as? String
         let bio_dict = ["bio":new_bio]
         
         // Segue information to UserCellViewController as Strings
         let UserCellViewController = segue.destination as! UserCellViewController
         UserCellViewController.userName = username_dict
         UserCellViewController.user = bio_dict
         print("Sending username to UserCellViewController")
         print("Sending user bio to UserCellViewController")
         
         UserCellViewController.user2 = user
         
         
         
    }
}


