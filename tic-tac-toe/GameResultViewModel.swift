//
//  GameResultViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class GameResultViewModel {
    private let players: [Player]
    private let gameResult: GameResult
    
    init(players: [Player], gameResult: GameResult) {
        self.players = players
        self.gameResult = gameResult
    }
}