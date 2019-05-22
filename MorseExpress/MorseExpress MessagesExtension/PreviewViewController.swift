//
//  PreviewViewController.swift
//  MorseExpress MessagesExtension
//
//  Created by Alexandra Isaly on 5/21/19.
//  Copyright © 2019 Alexandra Isaly. All rights reserved.
//


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



import UIKit
import Messages
import Foundation
import NotificationCenter

class PreviewViewController: MSMessagesAppViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotButton.layer.cornerRadius = 6
        dashButton.layer.cornerRadius = 6
        shiftButton.setImage(UIImage(named : "emojiIcon"), for: UIControl.State.normal)
        shiftButton.setImage(UIImage(named : "selectedEmoji"), for: UIControl.State.selected)
    }
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ button inputs ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    @IBOutlet weak var shiftButton: UIButton!
    @IBOutlet weak var CompleteButton: UIButton!
    
    @IBAction func shiftHandle(_ sender: Any) {
        MessagesViewController.toggleEmoji()
        shiftButton.isSelected = !MessagesViewController.isMorse
        /*
        if (MessagesViewController.isMorse) {
            print("morse time!")
            shiftButton.isSelected = false
        }
        else {
            print("emoji time!")
            shiftButton.isSelected = true
        }
 */
    }
    @IBAction func completeHandle(_ sender: Any) {
        PreviewViewController.sendText(text: msgPreview.text!)
        msgPreview.text = ""
        MessagesViewController.messageFactory.cleanup()
        shiftButton.isSelected = false
    }
    
    
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    @IBAction func dotHandle(_ sender: Any) {
        sendDot()
        msgPreview.text = MessagesViewController.messageFactory.getText()
    }
    
    @IBAction func dashHandle(_ sender: Any) {
        sendDash()
        msgPreview.text = MessagesViewController.messageFactory.getText()
    }
    
    
    @IBOutlet weak var msgPreview: UILabel!
    
    
    @objc func timeHasExceeded() {
        MessagesViewController.messageFactory.onPause(isMorse: MessagesViewController.isMorse) // when timeout has happened, reflect that in the text
        //MessagesViewController.singleton?.activeConversation?.insert(messageFactory.getMessage(isMorse: MessagesViewController.isMorse))
        MessagesViewController.messageFactory.onPause(isMorse: MessagesViewController.isMorse)
        msgPreview.text = MessagesViewController.messageFactory.getText()
    }
    
    
     func sendDot() {
        MessagesViewController.messageFactory.onDot(isMorse: MessagesViewController.isMorse)
        resetIdleTimer()
    }
    
     func sendDash() {
        MessagesViewController.messageFactory.onDash(isMorse: MessagesViewController.isMorse)
        resetIdleTimer()
    }
    
     var idleTimer: Timer?
     var timeoutInSeconds: Double = 1.0
    
     func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(
            timeInterval: timeoutInSeconds,
            target: self,
            selector: #selector(timeHasExceeded),
            userInfo: nil,
            repeats: false
        )
    }
    
    
    static func sendText(text: String) {
        let message = MSMessage()
        let layout = MSMessageTemplateLayout()
        layout.caption = text
        message.layout = layout
        MessagesViewController.singleton?.activeConversation?.insert(message)
    }
}
