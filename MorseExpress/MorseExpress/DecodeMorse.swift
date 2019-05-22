//
//  DecodeMorse.swift
//  MorseExpress MessagesExtension
//
//  Created by Madison Fileman on 5/22/19.
//  Copyright © 2019 Alexandra Isaly. All rights reserved.
//
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


//func decodeString(morseCode: String) -> String {
//    return morseCode
//        .split(separator: " ")
//        .map{ decodeCharacter(morseCode: String($0)) }
//        .joined(separator: "")
//} unnecessary maybe?

var emojiDict = [
    ".....":"😄",
    "....-":"😆",
    "...-.":"😅",
    "...--":"😂",
    "..-..":"😉",
    "..-.-":"🤩",
    "..--.":"🤪",
    "..---":"😋",
    ".-...":"🤑",
    ".-..-":"😑",
    ".-.-.":"🙄",
    ".-.--":"😒",
    ".--..":"😔",
    ".--.-":"🤤",
    ".---.":"😴",
    ".----":"🤮",
    "-....":"🤠",
    "-...-":"😎",
    "-..-.":"🤓",
    "-..--":"🧐",
    "-.-..":"😰",
    "-.-.-":"😱",
    "-.--.":"😭",
    "-.---":"😓",
    "--...":"😩",
    "--..-":"😡",
    "--.-.":"🤬",
    "--.--":"🤡",
    "---..":"😻",
    "---.-":"👏",
    "----.":"🖕",
    "-----":"👀"
]

func morse2emoji(code: String)-> String{
    return emojiDict[code]!
}
