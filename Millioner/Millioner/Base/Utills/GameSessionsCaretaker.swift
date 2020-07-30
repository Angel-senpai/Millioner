//
//  GameSessionsCaretaker.swift
//  Millioner
//
//  Created by Даниил Мурыгин on 30.07.2020.
//  Copyright © 2020 AngelSenpai. All rights reserved.
//

import Foundation


final class GameSessionsCaretaker{
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "sessions"
    
    func save(sessions:[GameSession]) {
        do{
            let data = try self.encoder.encode(sessions)
            UserDefaults.standard.set(data,forKey: key)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func retriveSessions() -> [GameSession] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        do{
            return try self.decoder.decode([GameSession].self, from: data)
        }catch{
            print(error.localizedDescription)
            return []
        }
    }
}
