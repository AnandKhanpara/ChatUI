//
//  MainVC.swift
//  ChatUI
//
//  Created by Anand Khanpara on 01/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    
    //MARK:- Outlet
    
    @IBOutlet weak var constraintTXTViewMessageHeight:NSLayoutConstraint!
    @IBOutlet weak var txtFieldMessage:UITextView!
    @IBOutlet weak var tvChat:UITableView!
    @IBOutlet weak var btnSendMessage:UIButton!
    
    //MARK:- Variable
    
    var userId = "1"
    
    var isSender = true
    
    var arrMessage:[MessageModel] = [
        MessageModel(textMessage: "Hiiii", senderId: "1"),
        MessageModel(textMessage: "Hello", senderId: "2")
        ] {
        didSet {
            OperationQueue.main.addOperation { [weak self] in
                guard let self = self else { return }
                self.tableViewReload()
            }
        }
    }
    
    //MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        tableViewChatScrollToBottom(isAnimated: false)
        isActiveSendMessage()
    }
    
    //MARK:- Navigation
    
    
    //MARK:- Action
    
    @IBAction func btnSendMessage_touchUpInside(sender:UIButton) {
        sendMessage()
    }
    
    
    //MARK:- Function
    
    func setUI() {
        btnSendMessage.isEnabled = false
    }
    
    func sendMessage() {
        let text = txtFieldMessage.text.trimmingCharacters(in: .whitespacesAndNewlines)
        txtFieldMessage.text = nil
        updateTxtViewHeight()
        let message = MessageModel(textMessage: text, senderId: isSender == true ? "1" : "2")
        arrMessage.append(message)
        isSender.toggle()
    }
    
    func tableViewReload() {
        self.tvChat.reloadData()
        self.tableViewChatScrollToBottom()
        self.isActiveSendMessage()
    }
    
    //MARK:- Web Service
    
    
}

//MARK:- Extension

extension MainVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = arrMessage[indexPath.row]
        if message.senderId == userId {
            return sendingMessageTVCell(message, indexPath: indexPath)
        }else if message.senderId != userId {
            return receivingMessageTVCell(message, indexPath: indexPath)
        }
        return UITableViewCell()
    }
    
    func sendingMessageTVCell(_ message:MessageModel, indexPath:IndexPath) -> UITableViewCell {
        guard let cell = tvChat.dequeueReusableCell(withIdentifier: "SendingMessageTVCell", for: indexPath) as? SendingMessageTVCell else {
            return UITableViewCell()
        }
        cell.setDetails(message: message)
        return cell
    }
    
    func receivingMessageTVCell(_ message:MessageModel, indexPath:IndexPath) -> UITableViewCell {
        guard let cell = tvChat.dequeueReusableCell(withIdentifier: "ReceivingMessageTVCell", for: indexPath) as? ReceivingMessageTVCell else {
            return UITableViewCell()
        }
        cell.setDetails(message: message)
        return cell
    }
    
    func tableViewChatScrollToBottom(isAnimated:Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            let lastCount = self.arrMessage.count - 1
            let indexPath = IndexPath(row: lastCount, section: 0)
            self.tvChat.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
        }
    }
}

extension MainVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updateTxtViewHeight()
        isActiveSendMessage()
    }
    
    func isActiveSendMessage() {
        let text = txtFieldMessage.text.trimmingCharacters(in: .whitespacesAndNewlines)
        btnSendMessage.isEnabled = 0 < text.count
    }
    
    func updateTxtViewHeight() {
        let frame = CGSize(width: txtFieldMessage.frame.size.width, height: .infinity)
        let updateHeight = txtFieldMessage.sizeThatFits(frame)
        if updateHeight.height < 40 {
            constraintTXTViewMessageHeight.constant = 40
        }else if 40 < updateHeight.height && updateHeight.height < 150 {
            constraintTXTViewMessageHeight.constant = updateHeight.height
        }else {
            constraintTXTViewMessageHeight.constant = 150
        }
    }
    
}
