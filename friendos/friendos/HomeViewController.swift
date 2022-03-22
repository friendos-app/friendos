//
//  HomeViewController.swift
//  friendos
//
//  Created by John Cheshire on 3/16/22.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    
    var users = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        
        // API call
        let url = URL(string: "https://parseapi.back4app.com")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 // Get the array of users
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 // Store the users in a property to use elsewhere
                 self.users = dataDictionary["results"] as! [[String:Any]]
                 // Reload your table view data
                 self.tableView.reloadData()
                 
             }
        }
        task.resume()
    }
    
    //Function to return cells with Users a given number of times (--I assume this will be the number of people who are disgnated as 'friendos' by the account holder)
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    //Function to populate a cell with the name, picture, and bio of given friendo.
    //TODO: I'm trying to make the function relevent to our backend, but I'm still not comfortable with APIs so there's alot of tweaking to do.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        
        //TODO: We need to check everything here when calling the API
        let user = users[indexPath.row]
        let name = user["name"] as! String
        let bio = user["bio"] as! String
        
        cell.nameLabel.text = name
        cell.bioLabel.text = bio
        
        //TODO: Need to check back4app to pull the user photos
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = user["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        return cell
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
