//
//  GameModel.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/27/22.
//

import Foundation

struct GameModel : Identifiable, Codable{
    var id : String
    var gameName : String
    var players : [PlayerModel]
}
