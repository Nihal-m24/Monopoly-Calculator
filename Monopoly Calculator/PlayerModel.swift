//
//  PlayerModel.swift
//  Monopoly Calculator
//
//  Created by Nihal Memon on 6/12/22.
//

import Foundation

struct PlayerModel : Identifiable, Codable{
    var id = UUID().uuidString
    var name : String
    var token : String
    var balance : Double
    var history : String
    var tag : Int
}

