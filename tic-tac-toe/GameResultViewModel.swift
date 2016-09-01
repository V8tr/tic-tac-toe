//
//  GameResultViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import ReactiveCocoa
import Result

class GameResultViewModel {
    private let gameResult: GameResult
    private let restartObserver: Observer<Void, NoError>
    
    lazy var restartAction: Action<Void, Void, NoError> = { [unowned self] in
        return Action { _ in
            return SignalProducer { observer, _ in
                self.restartObserver.sendNext()
                observer.sendCompleted()
            }
        }
    }()
    
    init(gameResult: GameResult, restartObserver: Observer<Void, NoError>) {
        self.gameResult = gameResult
        self.restartObserver = restartObserver
    }
    
    var resultImage: UIImage? {
        switch gameResult {
        case .Win(let player):
            return UIImage(named: player.marker.imageName())
        case .Draw: 
            return UIImage(named: "draw")
        default:
            return nil
        }
    }
}