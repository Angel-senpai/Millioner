//
//  Game.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation

class Game: NSObject{
    static let instance = Game()
    
    private(set) var sessions: [GameSession]{
        didSet{
            sessionsCaretaker.save(sessions: self.sessions)
        }
    }
    private let sessionsCaretaker = GameSessionsCaretaker()
    var gameSession: GameSession?{
        didSet{
            gameSession?.setup()
        }
    }
    private override init() {
       sessions = sessionsCaretaker.retriveSessions()
    }
    
    func setGameSession(session: GameSession) {
        self.gameSession = session
    }
    func endGame(session: GameSession) {
        sessions.append(session)
        gameSession = nil
    }
}
