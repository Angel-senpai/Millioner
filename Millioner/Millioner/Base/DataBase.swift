//
//  DataBase.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

class DataBase: NSObject {
    static var instance = DataBase()
    private override init() {}
    
    private var base:[Question]{
        guard let path = Bundle.main.path(forResource: "DataBase", ofType: "json") else {return []}
        do{
            print(path)
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let questionData = try JSONDecoder().decode(QuestionData.self,from: data)
            return questionData.answers
        }catch{
            print(error.localizedDescription)
        }
        
        return []
    }
    
    static func questionGiver()->[Question]{
        
        var questionArray = [Question]()
        
        for _ in 0..<5{
            guard let quest = DataBase.instance.base.randomElement() else {return []}
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
