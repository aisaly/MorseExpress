//
//  PreviewViewController.swift
//  MorseExpress MessagesExtension
//
//  Created by Alexandra Isaly on 5/21/19.
//  Copyright © 2019 Alexandra Isaly. All rights reserved.
//

import UIKit
import Messages
import Foundation

class PreviewViewController: MSMessagesAppViewController {

    var standardMorseDict = [
        ".-":       "a",
        "-...":     "b",
        "-.-.":     "c",
        "-..":      "d",
        ".":        "e",
        "..-.":     "f",
        "--.":      "g",
        "....":     "h",
        "..":       "i",
        ".---":     "j",
        "-.-":      "k",
        ".-..":     "l",
        "--":       "m",
        "-.":       "n",
        "---":      "o",
        ".--.":     "p",
        "--.-":     "q",
        ".-.":      "r",
        "...":      "s",
        "-":        "t",
        "..-":      "u",
        "...-":     "v",
        ".--":      "w",
        "-..-":     "x",
        "-.--":     "y",
        "--..":     "z",
        "-----":    "0",
        ".----":    "1",
        "..---":    "2",
        "...--":    "3",
        "....-":    "4",
        ".....":    "5",
        "-....":    "6",
        "--...":    "7",
        "---..":    "8",
        "----.":    "9",
    ]
    
    func decodeCharacter(morseCode: String) -> String {
        return standardMorseDict[morseCode]!
    }
   
    
    var currentMessage: MSMessage!
    var currentStringDecoded = ""
    var currentString = ""
    var active = false
    
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var dashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dotButton.layer.cornerRadius = 6
        dashButton.layer.cornerRadius = 6
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private var idleTimer: Timer?
    private var timeoutInSeconds = 1.0
    
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
    
    private func onPause(){
        currentString += " "
        decode()
        updateBubbleMessage()
    }
    
    private func insertText(text: String) {
        currentString += text
        print(currentString)
        resetIdleTimer()
        updateBubbleMessage()
    }
    
    private func decode() {
        let pattern = "\\w*([\\.\\-]+)\\ "
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in:currentString, range:NSMakeRange(0, currentString.utf16.count))
        if (matches == []) {
            return
        }
        var decodedString = ""
        matches.forEach { match in
            let range = match.range(at:1)
            let swiftRange = Range(range, in: currentString)
            let morseChar = currentString[swiftRange!]
            let textChar = decodeCharacter(morseCode: String(morseChar))
            decodedString += textChar
        }
        currentStringDecoded = decodedString
        print(currentString + " -> " + currentStringDecoded)
    }
    
    private func updateBubbleMessage(){
        let layout = MSMessageTemplateLayout()
        layout.caption = currentStringDecoded
        let message = MSMessage()
        message.layout = layout
        activeConversation?.insert(message, completionHandler: nil)
    }
    
    
    
    @objc private func timeHasExceeded() {
        onPause()
    }
    
    

    @IBAction func dotHandle(_ sender: Any) {
        insertText(text: ".")
    }
    @IBAction func dashHandle(_ sender: Any) {
        insertText(text: "-")
    }
    
}
