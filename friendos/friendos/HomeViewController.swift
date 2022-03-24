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
    
    

    
    // List of users that are not the current user.
    var user_list = [PFObject]()
    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("help")
        
        let user = PFUser.current()
        // Get user bio and photo
        
  
        let user_object_id = user?["objectId"]
        
        // Find interests
        let query = PFUser.query()
        
        
        //query.includeKey("interest_id")
        query!.whereKey("objectId", notEqualTo: user_object_id)
        
        
        
        

        
//        let user_name = user?["username"]
//
//        // Finds objects whose title is not equal to "No hard feelings"
//        let user_list = query.whereKey("username", notEqualTo: user_name);
//
//        print("okd")
//        print(user_list)
        
        
        

        // Loop through results and put interests into the array
        // This happens in the background, so need call reload view when complete
        query!.findObjectsInBackground(block: { (objects, error) in
            if (error == nil) {
                if let user_object_ids_list = objects {
                    print(user_object_ids_list)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
