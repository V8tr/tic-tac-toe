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
    var activePlayer: MutableProperty<Player>
    var move: MutableProperty<Int>
    var gameResult: MutableProperty<GameResult>
    var isAIMakingMove: MutableProperty<Bool>
    let AIMoveSignal: Signal<NSIndexPath, NoError>
    let boardViewModel: BoardViewModel

    lazy var markAction: Action<NSIndexPath, Void, NoError> = { [unowned self] in
        return Action({ indexPath in
            return SignalProducer<Void, NoError> { observer, _ in
                let marker = self.activePlayer.value.marker
                let position = Position(indexPath: indexPath)
                self.boardViewModel.markPosition(position, marker: marker)
                self.gameResult.value = self.game.gameResult()
                self.move.value += 1
                observer.sendCompleted()
            }
        })
    }()
    
    private let game: Game
    
    private let AIMoveObserver: Observer<NSIndexPath, NoError>

    init(game: Game, activePlayer: Player) {
        self.game = game
        self.activePlayer = MutableProperty(activePlayer)
        boardViewModel = BoardViewModel(self.game.board)
        move = MutableProperty(0)
        gameResult = MutableProperty(self.game.gameResult())
        isAIMakingMove = MutableProperty(false)
        
        let (AIMoveSignal, AIMoveObserver) = Signal<NSIndexPath, NoError>.pipe()
        self.AIMoveSignal = AIMoveSignal
        self.AIMoveObserver = AIMoveObserver
        self.AIMoveSignal.delay(1.0, onScheduler: QueueScheduler.mainQueueScheduler).observe(self.AIMoveObserver)
        
        self.activePlayer <~ move.producer.map { [unowned self] move in
            let players = self.game.players
            return players[move % players.count]
        }
        
//        SignalProducer(signal: self.activePlayer.signal)
//            .filter { player in return player is AIPlayer }
//            .on(next: { [unowned self] _ in self.isAIMakingMove.value = true })
//            .flatMap(.Latest, transform: { [unowned self] player in
//                if let player = player as? AIPlayer, position = player.positionToMark(self.game.board) {
//                    self.AIMoveObserver.sendNext(position.toIndexPath())
//                }
//                return SignalProducer(value: [])
//            })
//            .delay(1.0, onScheduler: QueueScheduler.mainQueueScheduler)
//            .on(next: { [unowned self] _ in self.isAIMakingMove.value = false })

    }
    
    func nextTurn() {
        if let player = activePlayer.value as? AIPlayer,
            position = player.positionToMark(self.game.board) {
            self.AIMoveObserver.sendNext(position.toIndexPath())
        }
    }
}