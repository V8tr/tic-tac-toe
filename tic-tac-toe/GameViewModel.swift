//
//  GameViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/29/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

class GameViewModel {
    let gameOverSignal: Signal<Player, NoError>
    var activePlayer: MutableProperty<Player>
    var move: Int = 0
    
    private let game: Game

    private let gameOverObserver: Observer<Player, NoError>

    init(game: Game) {
        self.game = game
        self.activePlayer = MutableProperty(game.activePlayer)
        
        let (gameOverSignal, gameOverObserver) = Signal<Player, NoError>.pipe()
        self.gameOverSignal = gameOverSignal
        self.gameOverObserver = gameOverObserver
    }
    
    var boardViewModel: BoardViewModel {
        let boardViewModel = BoardViewModel(game.board)
        
        boardViewModel.selectionChangesSignal
            .observeOn(UIScheduler())
            .observeNext { [unowned self] position in
                self.move += 1
                
                if (self.isGameOver()) {
                    self.gameOverObserver.sendNext(self.activePlayer.value)
                }
                
                let nextPlayer = self.nextPlayer()
                self.activePlayer.swap(nextPlayer)
                self.game.activePlayer = nextPlayer
        }
        
        return boardViewModel
    }
    
    private func isGameOver() -> Bool {
        return false
    }
    
    private func nextPlayer() -> Player {
        let players = game.players
        let idx = move % players.count
        return players[idx]
    }
}