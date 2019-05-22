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

class PreviewViewController: MSMessagesAppViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotButton.layer.cornerRadius = 6
        dashButton.layer.cornerRadius = 6
    }
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ button inputs ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    @IBAction func dotHandle(_ sender: Any) {
        insertText(text: ".")
        resetIdleTimer()
    }
    @IBAction func dashHandle(_ sender: Any) {
        insertText(text: "-")
        resetIdleTimer()
    }
    
    
    
    
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
        activeConversation?.insert(self.getMessage())
    }
    
    
    
    
    //~~~~~~~~~~~~~~~~~~~~~~~~~~~ textual input handling ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    private var currentMessage: MSMessage = MSMessage()
    var currentStringDecoded = "" //current readable string (morse2this)
    var currentString = "" //current morse string
    var active = false
    
    
    
    func getMessage() -> MSMessage {
        updateBubbleMessage()
        return self.currentMessage
    }
    
    
    private func insertText(text: String) {
        currentString += text
        updateBubbleMessage()
    }
    
    private func updateBubbleMessage() //called everytime youre adding new characters
    {
        currentStringDecoded = decode(morseCode: currentString) //should only return one character
        //        let layout = MSMessageTemplateLayout() //not working rn
        //        layout.caption = decodedString         //ditto
        //        currentMessage = MSMessage()
        //        currentMessage.layout = layout
    }
    
    private func decode(morseCode: String) -> String {
        let pattern = "\\w*([\\.\\-]+)\\ "
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in:currentString, range:NSMakeRange(0, currentString.utf16.count))
        if (matches == []) {
            return ""
        }
        var decodedString = ""
        matches.forEach { match in
            let range = match.range(at:1)
            let swiftRange = Range(range, in: currentString)
            let morseChar = currentString[swiftRange!]
            let textChar = decodeCharacter(morseCode:String(morseChar) )
            //morse2emoji(code: String(morseChar)) if u want emojis,
            decodedString += textChar
        }
        print(currentString + " > " + decodedString)
        return decodedString
    }
    
    
    private func onPause(){
        currentString += " "
        updateBubbleMessage()
    }
    
    func cleanup(){
        currentString = ""
    }
    
    
}
