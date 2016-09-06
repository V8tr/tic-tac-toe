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
    let activePlayerName: MutableProperty<String>
    
    let move: MutableProperty<Int>
    
    let restartSignal: Signal<Void, NoError>
    let gameOverSignal: Signal<[NSIndexPath], NoError>
    
    let isWaitingForUserInteraction: MutableProperty<Bool>

    lazy var markAction: Action<NSIndexPath, Void, NoError> = { [unowned self] in
        return Action({ indexPath in
            return SignalProducer<Void, NoError> { observer, _ in
                let position = Position(indexPath: indexPath)

                guard self.game.board.isValidMoveAt(position) else {
                    observer.sendCompleted()
                    return
                }
                
                self.isWaitingForUserInteraction.value = false
                self.mark(position)
                observer.sendCompleted()
            }
        })
    }()
    
    private let gameResult: MutableProperty<GameResult>
    private let activePlayer: MutableProperty<Player>
    private let game: Game
    private var isGameOver: Bool {
        return gameResult.value != .InProgress
    }
    
    private let restartObserver: Observer<Void, NoError>
    private let gameOverObserver: Observer<[NSIndexPath], NoError>

    init(game: Game) {
        self.game = game
        self.activePlayer = MutableProperty(game.players.first!)
        boardViewModel = BoardViewModel(self.game.board)
        move = MutableProperty(0)
        gameResult = MutableProperty(self.game.gameResult())
        isWaitingForUserInteraction = MutableProperty(true)
        activePlayerName = MutableProperty("")
        
        let (restartSignal, restartObserver) = Signal<Void, NoError>.pipe()
        self.restartSignal = restartSignal
        self.restartObserver = restartObserver
        
        let (gameOverSignal, gameOverObserver) = Signal<[NSIndexPath], NoError>.pipe()
        self.gameOverSignal = gameOverSignal
        self.gameOverObserver = gameOverObserver
        
        gameResult.producer
            .observeOn(UIScheduler())
            .delay(self.dynamicType.delayBetweenMoves, onScheduler: QueueScheduler.mainQueueScheduler)
            .startWithNext { [unowned self] gameResult in
                guard self.isGameOver else { return }
                
                var indexPaths: [NSIndexPath] = []
                if case .Win(_, let positions) = gameResult {
                    indexPaths = positions.map { position in return position.toIndexPath() }
                }
                self.gameOverObserver.sendNext(indexPaths)
        }
        
        self.activePlayer <~ move.producer
            .delay(self.dynamicType.delayBetweenMoves, onScheduler: QueueScheduler.mainQueueScheduler)
            .map { [unowned self] move in
                let players = self.game.players
                return players[move % players.count]
        }
        
        activePlayerName <~ self.activePlayer.producer.map { player in
            return player.displayName
        }
    }
    
    func nextTurn() {
        guard !isGameOver else { return }
        
        // make AI move
        if let player = activePlayer.value as? AIPlayer, position = player.positionToMark(game.board) {
            isWaitingForUserInteraction.value = false
            mark(position)
        }
        else {
            isWaitingForUserInteraction.value = true
        }
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