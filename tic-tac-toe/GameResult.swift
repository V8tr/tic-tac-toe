//
//  GameResult.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/5/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum GameResult {
    case InProgress
    case Draw
    case Win(Player, [Position])
}

extension GameResult: Equatable {
    
}

func == (lhs: GameResult, rhs: GameResult) -> Bool {
    switch (lhs, rhs) {
    case (.InProgress, .InProgress):
        return true
    case (.Draw, .Draw):
        return true
    case (.Win(let p1, _), .Win(let p2, _)):
        return p1.marker == p2.marker
    default:
        return false
    }
}