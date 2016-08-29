//
//  GameResult+Equatable.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/29/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

extension GameResult: Equatable {
    
}

func == (lhs: GameResult, rhs: GameResult) -> Bool {
    switch (lhs, rhs) {
    case (.InProgress, .InProgress):
        return true
    case (.Draw, .Draw):
        return true
    case (.Win(let p1), .Win(let p2)):
        return p1.marker == p2.marker
    default:
        return false
    }
}