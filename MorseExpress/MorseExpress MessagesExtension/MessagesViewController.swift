//
//  MessagesViewController.swift
//  MorseExpress MessagesExtension
//
//  Created by Alexandra Isaly on 5/21/19.
//  Copyright © 2019 Alexandra Isaly. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    var currentMessage: MSMessage!
    var currentString = "";
    var active = false;

    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotButton.layer.cornerRadius = 6
        dashButton.layer.cornerRadius = 6
        
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
        currentString = "";
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
    private var idleTimer: Timer?
    private var timeoutInSeconds = 1.0;

    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }

        idleTimer = Timer.scheduledTimer(
            timeInterval: timeoutInSeconds,
            target: self,
            selector: #selector(MessagesViewController.timeHasExceeded),
            userInfo: nil,
            repeats: false
        )
    }

    @objc private func timeHasExceeded() {
        currentString += " "
    }

    @IBAction func dotHandle(_ sender: Any) {
        send(s: ".");
    }
    
    @IBAction func dashHandle(_ sender: Any) {
        send(s: "-");
    }


    private func send(s: String) {
        currentString += s;
        print(currentString);
        // update Timer 
        resetIdleTimer();

        // update bubble text
        let layout = MSMessageTemplateLayout()
        layout.caption = currentString;
        let message = MSMessage();
        message.layout = layout;

        activeConversation?.insert(message, completionHandler: nil);
    }


}
