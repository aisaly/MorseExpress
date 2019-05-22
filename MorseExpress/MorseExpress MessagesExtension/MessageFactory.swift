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
    
    private var buffer: String = ""
    private var currentString: String = ""
    private var timeoutInSeconds: Double = 1.0
    private var currentMessage: MSMessage = MSMessage()

    @objc private func timeHasExceeded(isMorse: Bool) {
        onPause(isMorse: isMorse)
    }

    func onDot(isMorse: Bool){
        insertText(text: ".", isMorse: isMorse)
    }

    func onDash(isMorse: Bool){
        insertText(text: "-", isMorse: isMorse)
    }

    // Logic for message creation

    func onPause(isMorse: Bool) {
        buffer += " "
        currentString += decode(morseCode: buffer, isMorse: isMorse)
    }

    private func insertText(text: String, isMorse: Bool) {
        //print(currentString)
        buffer += text
        currentString += decode(morseCode: buffer, isMorse: isMorse)
    }
/*
    private func updateBubbleMessage(isMorse: Bool){
        let decodedString = decode(morseCode: currentString, isMorse: isMorse)
        let layout = MSMessageTemplateLayout()
        layout.caption = decodedString
        currentMessage = MSMessage()
        currentMessage.layout = layout
    }
    */
    /*
    func getMessage(isMorse: Bool) -> MSMessage {
        updateBubbleMessage(isMorse: isMorse)
        return self.currentMessage
    }
 */
    

    private func decode(morseCode: String, isMorse: Bool) -> String {
        let pattern = "\\w*([\\.\\-]+)\\ "
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let matches = regex.matches(in:buffer, range:NSMakeRange(0, buffer.utf16.count))
        if (matches == []) {
            return ""
        }
        var decodedString = ""
        var textChar: String = ""
        matches.forEach { match in
            let range = match.range(at:1)
            let swiftRange = Range(range, in: buffer)
            let morseChar = buffer[swiftRange!]
            textChar = isMorse ?
                decodeCharacter(morseCode: String(morseChar))
                : morse2emoji(code: String(morseChar))
            print("decoded", textChar)
            decodedString += textChar
        }
        buffer = ""
        //currentString += decodedString;
        return decodedString
    }
    
    func cleanup(){
        currentString = ""
        buffer = ""
        MessagesViewController.isMorse = true
    }
    
    func getText() -> String {
        print("currentstring", currentString)
        print("buffer", buffer)
        //getMessage(isMorse: true)
        //TODO turn . .- - into eat
        print(self.currentString)
        return self.currentString
    }
}

