//
//  ConnectionsViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/30/22.
//

import UIKit
import Parse

class ConnectionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, connectionCellDelegate  {
    

    
    
    var connectionRequests = [PFObject]()
    // Holds current background color
    var background_color = UIColor()
    
    @IBOutlet weak var connectionTableView: UITableView!
    
    // Update background colors
    func updateColors() {
        // Setup background color
        if let background_color_string = UserDefaults.standard.string(forKey: "background_color") {
            print(background_color_string)
            self.background_color = UIColor(named: background_color_string)!
            view.backgroundColor = self.background_color
            connectionTableView.backgroundColor = self.background_color
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.connectionRequests.count == 0 {
            return 1
        } else {
            return self.connectionRequests.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell to update
        let cell = connectionTableView.dequeueReusableCell(withIdentifier: "ConnectionCell") as! ConnectionCell
        
        cell.contentView.backgroundColor = self.background_color
        
        // Show message if no friend requests
        if self.connectionRequests.count == 0 {
            cell.usernameLabel.text = "No friend requests right now."
            cell.acceptButton.isHidden = true
            cell.rejectButton.isHidden = true
        } else {
            // Get the result of the query
            let connection = self.connectionRequests[indexPath.row]
            let requestor = connection["requestor"] as! PFUser
            
            cell.acceptButton.isHidden = false
            cell.rejectButton.isHidden = false
            
            cell.usernameLabel.text = requestor["username"] as! String
            cell.request = connection
            cell.delegate = self
        }
      
        return cell
    }
    
    // Handle a click of a button to add / reject friends
    func didTapConnectionButton() {
        print("Tap Worked")
        self.getConnections()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getConnections()
        
        updateColors()

        connectionTableView.dataSource = self
        connectionTableView.delegate = self
    }
    

    func getConnections() {
        // Load any requests for connection
        let user = PFUser.current()
        
          
        // Find connections
        let query = PFQuery(className: "Connections")
        query.includeKey("target_user")
        query.includeKey("requestor")
        
        // Only get requests for this user that are not accepted
        query.whereKey("target_user", equalTo: user!)
        query.whereKeyDoesNotExist("accepted")
        
        
    
        

        // Find the connection requests
        query.findObjectsInBackground(block: { (objects, error) in
            if (error == nil) {
                if let connections = objects {
                    // print(user_object_ids_list)
                    self.connectionRequests = connections
                    print(self.connectionRequests.count)
                    
                    print(self.connectionRequests)
                    
                    self.connectionTableView.reloadData()
     
                    
                }

            } else {
                print("Error")
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateColors()
        connectionTableView.reloadData()
    }

}

protocol connectionCellDelegate: AnyObject {
    func didTapConnectionButton()
}


