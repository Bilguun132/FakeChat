//
//  ChatMessageCell.swift
//  FakeChat
//
//  Created by Bilguun Batbold on 23/3/19.
//  Copyright © 2019 Bilguun. All rights reserved.
//

import Foundation
import UIKit

class ChatMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    let messageBgView = UIView()
    
    
    // change background view colour accordingly
    var isIncoming: Bool = false {
        didSet {
            messageBgView.backgroundColor = isIncoming ? UIColor.white : #colorLiteral(red: 0.8823529412, green: 0.968627451, blue: 0.7921568627, alpha: 1)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(messageBgView)
        addSubview(messageLabel)
        messageBgView.translatesAutoresizingMaskIntoConstraints = false
        messageBgView.layer.cornerRadius = 7
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // set constraints for the message and the background view
        let constraints = [
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            
            messageBgView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messageBgView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messageBgView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            messageBgView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
        ]
        
        
        NSLayoutConstraint.activate(constraints)

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // what we will call from our tableview method
    func configure(with model: MessageModel) {
        isIncoming = model.isIncoming
        if isIncoming {
            guard let sender = model.sender else {return}
            // align to the left
            let nameAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.orange,
                NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)
                ] as [NSAttributedString.Key : Any]
            // sender name at top, message at the next line
            let senderName = NSMutableAttributedString(string: sender + "\n", attributes: nameAttributes)
            let message = NSMutableAttributedString(string: model.message)
            senderName.append(message)
            messageLabel.attributedText = senderName
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = false
        }
        else {
            // align to the right
            messageLabel.text = model.message
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = false
        }
    }
}

// message struct

struct MessageModel {
    let message: String
    let sender: String?
    let isIncoming: Bool
}
