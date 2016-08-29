//
//  GameViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/29/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation
import ReactiveCocoa

class GameViewModel {
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    var boardViewModel: BoardViewModel {
        return BoardViewModel(game.board)
    }
}