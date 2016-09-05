//
//  Game.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum GameResult {
    case InProgress
    case Draw
    case Win(Player, [Position])
}

class Game {
    let players: [Player]
    var board: Board!
    
    init(players: [Player], board: Board) {
        self.players = players
        self.board = board
        self.board.game = self
    }
    
    func gameResult() -> GameResult {
        return board.gameResult()
    }
}