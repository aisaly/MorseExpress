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
    
    var isMorse = true
    
    
    @IBAction func shiftHandle(_ sender: Any) {
        isMorse = !isMorse
        if (isMorse) {
            print("morse time!")
            shiftButton.isSelected = false
        }
        else {
            print("emoji time!")
            shiftButton.isSelected = true
        }
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
    
    
    @IBOutlet weak var msgPreview: UILabel!
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ timer handling ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    private var idleTimer: Timer?
    private var timeoutInSeconds: Double = 1.0
    
    private func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(
            timeInterval: timeoutInSeconds,
            target: self,
            selector: #selector(PreviewViewController.timeHasExceeded),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc private func timeHasExceeded() {
        onPause() // when timeout has happened, reflect that in the text
        //activeConversation?.insert(self.getMessage())
    }
    
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ textual input handling ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    private var currentMessage: MSMessage = MSMessage()
    var currentStringDecoded = "" //current readable string (morse2this)
    var currentString = "" //current morse string
    var toBeDecoded = ""
    var active = false
    
    
    
    private func insertText(text: String) {
        currentString += text
        toBeDecoded += text
    }
    
    private func updateBubbleMessage() //called everytime youre adding new characters
    {
        //print("tobedecoded " + toBeDecoded)
        currentStringDecoded += decode(morseCode: toBeDecoded)
        print(currentStringDecoded)
        msgPreview.text = currentStringDecoded
    }
    
    private func decode(morseCode: String) -> String {
        let pattern = "\\w*([\\.\\-]+)\\ "
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in:currentString, range:NSMakeRange(0, currentString.utf16.count))
        if (matches == []) {
            return ""
        }
        var char = ""
        //print(toBeDecoded + " to be decoded")
        matches.forEach { match in
            let range = match.range(at:1)
            let swiftRange = Range(range, in: currentString)
            let morseChar = currentString[swiftRange!]
            char = isMorse ?
                 decodeCharacter(morseCode:String(morseChar) ) //if u want morse to text
            :
                morse2emoji(code: String(morseChar)) //if u want morse to emojis
            //print(char + "char")
        }
        return char
    }
    
    
    private func onPause(){ //DOESNT ADD SPACE TO THE DECODED STRING
        currentString += " "
        
        updateBubbleMessage()
        toBeDecoded = ""
    }
    
    
    func cleanup(){
        currentString = ""
        currentStringDecoded = ""
        isMorse = true
        msgPreview.text = "..."
    }

}
