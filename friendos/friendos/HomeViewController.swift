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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UserProfiles.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.UserUsername!.text = "Dan"
        cell.UserBio!.text = "Hey"
        
        return cell
        
    }
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let user = PFUser.current()
        // Get user bio and photo
        let bio = user?["bio"]
        let photo = user?["image"]

        // Find interests
        let query = PFQuery(className: "UserInterests")
        query.includeKey("interest_id")
        query.whereKey("user_id", equalTo: user)

        // String to hold interests
        var interests = [String]()

        // Loop through results and put interests into the array
        // This happens in the background, so need call reload view when complete
        query.findObjectsInBackground(block: { (objects, error) in
            if (error == nil) {
                if let interest_list = objects{
                    for interest in interest_list {
                        let cur_interest = interest["interest_id"] as! PFObject
                        interests.append(cur_interest["interest"] as! String)
                    }

                    print(interests)
                }

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
