//
//  SendingMessageTVCell.swift
//  ChatUI
//
//  Created by Anand Khanpara on 01/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class SendingMessageTVCell: UITableViewCell {
    
    //MARK:- Outlet
    
    @IBOutlet weak var lblTextMessage:UILabel!
    
    //MARK:- Variable
    
    //MARK:- Method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- Action
    
    //MARK:- Function
    
    func setDetails(message:MessageModel) {
        lblTextMessage.text = message.textMessage
    }
    
}
