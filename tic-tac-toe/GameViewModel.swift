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
    static let gameOverAnimationDuration = 0.5
    static let delayBetweenMoves = 0.5

    let boardViewModel: BoardViewModel
    
    let move: MutableProperty<Int>
    let activePlayer: MutableProperty<Player>
    
    let restartSignal: Signal<Void, NoError>
    let gameOverSignal: Signal<[NSIndexPath], NoError>

    lazy var markAction: Action<NSIndexPath, Void, NoError> = { [unowned self] in
        return Action({ indexPath in
            return SignalProducer<Void, NoError> { observer, _ in
                let position = Position(indexPath: indexPath)
                self.mark(position)
                observer.sendCompleted()
            }
        })
    }()
    
    private let gameResult: MutableProperty<GameResult>
    private let game: Game
    private var isGameOver: Bool {
        return gameResult.value != .InProgress
    }
    
    private let restartObserver: Observer<Void, NoError>
    private let gameOverObserver: Observer<[NSIndexPath], NoError>

    init(game: Game, activePlayer: Player) {
        self.game = game
        self.activePlayer = MutableProperty(activePlayer)
        boardViewModel = BoardViewModel(self.game.board)
        move = MutableProperty(0)
        gameResult = MutableProperty(self.game.gameResult())
        
        let (restartSignal, restartObserver) = Signal<Void, NoError>.pipe()
        self.restartSignal = restartSignal
        self.restartObserver = restartObserver
        
        let (gameOverSignal, gameOverObserver) = Signal<[NSIndexPath], NoError>.pipe()
        self.gameOverSignal = gameOverSignal
        self.gameOverObserver = gameOverObserver
        
        gameResult.producer
            .observeOn(UIScheduler())
            .startWithNext { [unowned self] gameResult in
                guard self.isGameOver else { return }
                
                var indexPaths: [NSIndexPath] = []
                if case .Win(_, let positions) = gameResult {
                    indexPaths = positions.map { position in return position.toIndexPath() }
                }
                self.gameOverObserver.sendNext(indexPaths)
        }
        
        self.activePlayer <~ move.producer.map { [unowned self] move in
            let players = self.game.players
            return players[move % players.count]
        }
    }
    
    func nextTurn() {
        guard !isGameOver else { return }
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
        let viewModel = GameResultViewModel(gameResult: gameResult.value, restartObserver: restartObserver)
        return viewModel
    }
}