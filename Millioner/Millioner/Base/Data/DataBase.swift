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
    
    private var base: QuestionData?{
        guard let path = Bundle.main.path(forResource: "DataBase", ofType: "json") else {return nil}
        do{
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            
            let questionData = try JSONDecoder().decode(QuestionData.self,from: data)
            return questionData
        }catch{
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func getBase() -> QuestionData? {
        return base
    }
    
    static let firstGameKey = "firstGame"
    static var firstGame: Int{
        set{
            UserDefaults.standard.set(newValue, forKey: firstGameKey)
        }
        get{
            UserDefaults.standard.integer(forKey: firstGameKey)
        }
    }
    
    static let difficultGameKey = "gameDifficult"
    static var difficultGame: Difficult.RawValue{
        set{
            UserDefaults.standard.set(newValue, forKey: difficultGameKey)
        }
        get{
            UserDefaults.standard.integer(forKey: difficultGameKey)
        }
    }
}
