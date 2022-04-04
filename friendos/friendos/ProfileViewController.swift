//
//  ProfileViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/16/22.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let user = PFUser.current()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
            
            cell.usernameLabel.text = user?["username"] as! String
            
            cell.profilePhotoView.layer.borderWidth = 6
            cell.bioView.layer.borderWidth = 6
            cell.bioView.layer.borderColor = UIColor.black.cgColor
            cell.interestView.layer.borderWidth = 6
            cell.interestView.layer.borderColor = UIColor.black.cgColor
            //userBio.layer.borderWidth = 6
            
            print()
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! profileCell
        
        cell.usernameLabel.text = user?["username"] as! String
        
        cell.profilePhotoView.layer.borderWidth = 6
        cell.bioView.layer.borderWidth = 6
        cell.bioView.layer.borderColor = UIColor.black.cgColor
        cell.interestView.layer.borderWidth = 6
        cell.interestView.layer.borderColor = UIColor.black.cgColor
        //userBio.layer.borderWidth = 6
        
        return cell
        
    }
    
    

    
    // user_list will just be a list with a single dictioary.
    var user_list = [PFObject]()
    
    // Update background colors
    func updateColors() {
        // Setup background color
        if let background_color_string = UserDefaults.standard.string(forKey: "background_color") {
            print(background_color_string)
            let background_color = UIColor(named: background_color_string)!
            view.backgroundColor = background_color
        }
    }
    
    func loadData() {
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
                    
//                    usernameLabel.text = user_list[0]["username"] as? String
//                    userBio.text = user_list[0]["bio"] as? String
//
//                    if let imageFile = user?["image"] as? PFFileObject {
//                        let urlString = imageFile.url!
//                        let url = URL(string: urlString)!
//                        profilePhotoView.af.setImage(withURL: url)
//                    }
                    
                }
                
                // Setup query for user interests
                let interest_query = PFQuery(className: "UserInterests")
                interest_query.includeKey("interest_id")
                interest_query.whereKey("user_id", equalTo: user)
                
                // Run query and populate interests section
                interest_query.findObjectsInBackground { objects, error in
                    
                    if let interests = objects {
                        
                        var interest_list = ""
                        for interest in interests {
                            let interest_obj = interest["interest_id"] as! PFObject
                            let interest_str = interest_obj["interest"] as! String
                            interest_list = interest_list + interest_str + ", "
                            
                        }
                        if interest_list == "" {
                            interest_list = "no current interests"
                        }
                        else {
                            interest_list.removeLast(2)
                        }
                        interest_list = "Interests: " + interest_list
                        
                        //interestLabel.text = interest_list
                        
                    }
                }
                
            }
            
            else {
                print("error here")
            }
        })
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        updateColors()
        
      
        
        self.loadData()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        //self.viewDidLoad()
        
        // update colors
        updateColors()
        
        // Reload database data
        self.loadData()
        
        
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
