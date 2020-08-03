//
//  GameSession.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

class GameSession: Codable{
    var questions = [Question]()
    var answerRight: Int = 0{
        didSet(newValue){
            if newValue > questions.count - 1 {answerRight = questions.count - 1}
        }
    }
    var prize = 0
    var rightProcent:Int{ questions.count * answerRight / 100 }
    
    func addQuestion(question: Question) {
        self.questions.append(question)
    }
    
    func setup(){
        questions = DataBase.questionGiver()
    }
    
}
