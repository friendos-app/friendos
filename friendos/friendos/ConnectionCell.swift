//
//  ConnectionCell.swift
//  friendos
//
//  Created by John Cheshire on 3/30/22.
//

import UIKit
import Parse

class ConnectionCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    weak var delegate: connectionCellDelegate?
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    
    var request: PFObject!
    
    @IBAction func onRejectConnection(_ sender: Any) {
        request["accepted"] = false
        request.saveInBackground { success, error in
            if success {
                self.delegate?.didTapConnectionButton()
            }
        }
    }
    @IBAction func onAcceptConnection(_ sender: Any) {
        request["accepted"] = true
        request.saveInBackground { success, error in
            if success {
                self.delegate?.didTapConnectionButton()
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


