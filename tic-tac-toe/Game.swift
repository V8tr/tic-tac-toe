//
//  Game.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Game {
    let players: [Player]
    var activePlayer: Player!
    var board: Board!
    
    init(players: [Player], board: Board) {
        self.players = players
        self.board = board
        self.board.game = self
    }
}