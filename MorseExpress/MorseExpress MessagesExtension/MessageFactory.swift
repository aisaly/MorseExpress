//
//  MessageCreation.swift
//  MorseExpress MessagesExtension
//
//  Created by Aeyzechiah Vasquez on 5/21/19.
//  Copyright © 2019 Alexandra Isaly. All rights reserved.
//

import Foundation
import MessageUI
import Messages

class MessageFactory {
    
    private var currentString: String = ""
    private var timeoutInSeconds: Double = 1.0
    private var currentMessage: MSMessage = MSMessage()

    @objc private func timeHasExceeded() {
        onPause()
    }

    func onDot(){
        insertText(text: ".")
    }

    func onDash(){
        insertText(text: "-")
    }

    // Logic for message creation

    func onPause() {
        currentString += " "
    }

    private func insertText(text: String) {
        print(currentString)
        currentString += text
        //updateBubbleMessage()
    }

    private func updateBubbleMessage(){
        let decodedString = decode(morseCode: currentString)
        let layout = MSMessageTemplateLayout()
        layout.caption = decodedString
        currentMessage = MSMessage()
        currentMessage.layout = layout
    }
    
    func getMessage() -> MSMessage {
        updateBubbleMessage()
        return self.currentMessage
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
            let textChar = decodeCharacter(morseCode: String(morseChar))
            decodedString += textChar
        }
        print(currentString + " -> " + decodedString)
        return decodedString
    }
    
    func cleanup(){
        currentString = ""
    }
}

