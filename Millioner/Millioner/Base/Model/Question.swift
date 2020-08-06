//
//  Question.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 29.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

enum QuestionDifficult: String {
    case normal
    case easy
    case hard
}

struct Question: Codable{
    let answer: String
    let answerOptions:[String:Bool]
    let helpOptions:[String:String]?
}

struct QuestionData:Codable {
    let normal:[Question]
    let easy:[Question]
    let hard:[Question]
}
