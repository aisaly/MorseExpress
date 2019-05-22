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
        if (MessagesViewController.isMorse) {
            print("morse time!")
            shiftButton.isSelected = false
        }
        else {
            print("emoji time!")
            shiftButton.isSelected = true
        }
    }
    @IBAction func completeHandle(_ sender: Any) {
        MessagesViewController.sendText(text: msgPreview.text!)
        msgPreview.text = ""
    }
    
    
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    @IBAction func dotHandle(_ sender: Any) {
        MessagesViewController.sendDot()
        msgPreview.text = MessagesViewController.getText()
    }
    
    @IBAction func dashHandle(_ sender: Any) {
        MessagesViewController.sendDash()
        msgPreview.text = MessagesViewController.getText()
    }
    
    
    @IBOutlet weak var msgPreview: UILabel!
}
