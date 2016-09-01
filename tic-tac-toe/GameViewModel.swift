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
    let isGameOver: MutableProperty<Bool>
    let boardViewModel: BoardViewModel

    lazy var markAction: Action<NSIndexPath, Void, NoError> = { [unowned self] in
        return Action({ indexPath in
            return SignalProducer<Void, NoError> { observer, _ in
                let position = Position(indexPath: indexPath)
                self.mark(position)
                observer.sendCompleted()
            }
        })
    }()
    
    private let activePlayer: MutableProperty<Player>
    private let move: MutableProperty<Int>
    private let gameResult: MutableProperty<GameResult>
    private let game: Game
    
    init(game: Game, activePlayer: Player) {
        self.game = game
        self.activePlayer = MutableProperty(activePlayer)
        boardViewModel = BoardViewModel(self.game.board)
        move = MutableProperty(0)
        gameResult = MutableProperty(self.game.gameResult())
        isGameOver = MutableProperty(false)
        
        self.activePlayer <~ move.producer.map { [unowned self] move in
            let players = self.game.players
            return players[move % players.count]
        }
        
        isGameOver <~ gameResult.producer.map { gameResult in return gameResult != .InProgress }
    }
    
    func nextTurn() {
        guard !isGameOver.value else { return }
        guard let player = activePlayer.value as? AIPlayer else { return }
        guard let position = player.positionToMark(self.game.board) else { return }
        mark(position)
    }
    
    private func mark(position: Position) {
        self.boardViewModel.markPosition(position, marker: activePlayer.value.marker)
        self.gameResult.value = self.game.gameResult()
        self.move.value += 1
    }
        
    func createGameResultViewModel() -> GameResultViewModel {
        let viewModel = GameResultViewModel(players: game.players, gameResult: gameResult.value)
        return viewModel
    }
}