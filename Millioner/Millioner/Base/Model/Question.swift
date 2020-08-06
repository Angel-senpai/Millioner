//
//  Question.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 29.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

struct Question: Codable{
    let answer: String
    let answerOptions:[String:Bool]
    let helpOptions:[String:String]?
}

struct QuestionData:Codable {
    let answers:[Question]
}
