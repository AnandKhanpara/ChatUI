//
//  MessageModel.swift
//  ChatUI
//
//  Created by Anand Khanpara on 01/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MessageModel {
    var textMessage:String?
    var senderId:String
    
    init(textMessage:String? = nil, senderId:String) {
        self.textMessage = textMessage
        self.senderId = senderId
    }
}
