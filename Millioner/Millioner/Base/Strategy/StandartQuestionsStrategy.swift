//
//  StandartQuestionsStrategy.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 05.08.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

final class StandartQuestionsStrategy: GameSessionStrategy {
    static func questionGiver()->[Question]{
        let difficult:[QuestionDifficult] = [.easy,.normal,.hard]
        var questionArray = [Question]()
        if let questionBase = DataBase.instance.getBase(){
            for value in difficult{
                switch value {
                case .easy:
                    questionArray.append(contentsOf: getQuest(array: questionBase.easy))
                case .normal:
                    questionArray.append(contentsOf: getQuest(array: questionBase.normal))
                case .hard:
                    questionArray.append(contentsOf: getQuest(array: questionBase.hard))
                }
            }
        }
        
        return questionArray
    }
    
    private static func getQuest(array: [Question]) -> [Question] {
        var questionArray = [Question]()
        for _ in 0..<2{
            guard let quest = array.randomElement() else {return []}
            var flag = true
            questionArray.forEach{
                if quest.answer == $0.answer{
                    flag = false
                }
            }
            if flag{
                questionArray.append(quest)
            }
        }
        return questionArray
    }
}
