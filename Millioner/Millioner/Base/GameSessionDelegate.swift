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
    var rightAnswers: Int = 0{
        didSet{
            Game.instance.gameSession?.answerRight = rightAnswers
        }
    }
    init() {}
}
