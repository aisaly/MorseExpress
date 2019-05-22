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
    
    var viewController: MSMessagesAppViewController
    
    init(controller: MSMessagesAppViewController){
        self.viewController = controller
    }

    private var currentString: String = ""
    private var timeoutInSeconds: Double = 1.0
    private var currentMessage: MSMessage = MSMessage()

    private var idleTimer: Timer?
    private func resetIdleTimer() {
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

    @objc private func timeHasExceeded() {
        onPause()
    }

    func insertDot(){
        insertText(text: ".")
        resetIdleTimer()
    }

    func insertDash(){
        insertText(text: "-")
        resetIdleTimer()
    }

    // Logic for message creation

    private func onPause() {
        currentString += " "
    }

    private func insertText(text: String) {
        print(currentString)
        currentString += text
        updateBubbleMessage()
    }

    private func updateBubbleMessage(){
        let decodedString = decode(morseCode: currentString)
        let layout = MSMessageTemplateLayout()
        layout.caption = decodedString
        currentMessage = MSMessage()
        currentMessage.layout = layout
        self.viewController.activeConversation?.insert(currentMessage, completionHandler: nil)
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
}

