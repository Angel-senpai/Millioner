//
//  GameSessionDelegate.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 31.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

class GameSessionDelegate: GameSessionProtocol {
    var prize: Int = 0{
        didSet{
            Game.instance.gameSession?.prize = prize
        }
    }
    var rightAnswers = Observable<Int>(0)
    
    var rAnswer: Int = 0{
        didSet{
            rightAnswers.value = rAnswer
            Game.instance.gameSession?.answerRight = rAnswer
        }
    }
    
    var questCounter = Observable<Int>(0)
    
    var rightProcent:Double{
        guard let session = Game.instance.gameSession else {return 0}
        return session.rightProcent
    }
    func endGame(){
        guard let session = Game.instance.gameSession else {return}
        session.answerRight = self.rightAnswers.value
        Game.instance.endGame(session: session)
    }
    init() {}
}
