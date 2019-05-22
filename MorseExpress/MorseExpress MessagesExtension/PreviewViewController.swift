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
    }
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ button inputs ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    @IBOutlet weak var shiftButton: UIButton!
    @IBOutlet weak var CompleteButton: UIButton!
    
    
    @IBAction func shiftHandle(_ sender: Any) {
        print("emoji time!")
    }
    @IBAction func completeHandle(_ sender: Any) {
        print("send it")
    }
    
    private var nc: NotificationCenter = NotificationCenter.default
    
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    @IBAction func dotHandle(_ sender: Any) {
        MessagesViewController.sendDot()
    }
    
    @IBAction func dashHandle(_ sender: Any) {
        MessagesViewController.sendDash()
    }
    
    
    //add a send button here and
        //call sendBubbleMessage from MessageViewController!
        //reset timeout
        //reset strings (call cleanup)
    
    
    //add a "shift" button here, will toggle emojis or text
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ timer handling ~~~~~~~~~~~~~~~~~~~~~~~~~~~
}
