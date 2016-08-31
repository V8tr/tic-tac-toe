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
    let gameOverSignal: Signal<GameResult, NoError>
    var activePlayer: MutableProperty<Player>
    var move: MutableProperty<Int>
    
    lazy var markAction: Action<NSIndexPath, Void, NoError> = { [unowned self] in
        return Action({ indexPath in
            return SignalProducer<Void, NoError> { observer, _ in
                let marker = self.activePlayer.value.marker
                let position = Position(indexPath: indexPath)
                self.boardViewModel.markPosition(position, marker: marker)
                observer.sendCompleted()
            }
        })
    }()
    
    private let game: Game

    private let gameOverObserver: Observer<GameResult, NoError>

    lazy var boardViewModel: BoardViewModel = { [unowned self] in
        let boardViewModel = BoardViewModel(self.game.board)
        
        boardViewModel.selectionChangesSignal
            .observeOn(UIScheduler())
            .observeNext { position in
                if (self.isGameOver()) {
                    self.gameOverObserver.sendNext(self.game.gameResult())
                }
                
                self.move.swap(self.move.value + 1)
        }
        
        return boardViewModel
    }()
    
    init(game: Game, activePlayer: Player) {
        self.game = game
        self.activePlayer = MutableProperty(activePlayer)
        move = MutableProperty(0)
        
        let (gameOverSignal, gameOverObserver) = Signal<GameResult, NoError>.pipe()
        self.gameOverSignal = gameOverSignal
        self.gameOverObserver = gameOverObserver
        
        move.producer
            .observeOn(UIScheduler())
            .startWithNext { [unowned self] move in
                let nextPlayer = self.nextPlayer()
                self.activePlayer.swap(nextPlayer)
        }
    }

    private func isGameOver() -> Bool {
        return game.gameResult() != .InProgress
    }
    
    private func nextPlayer() -> Player {
        let players = game.players
        let idx = self.move.value % players.count
        return players[idx]
    }
}