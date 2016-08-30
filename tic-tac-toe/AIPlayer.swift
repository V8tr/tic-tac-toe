//
//  AIPlayer.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class AIPlayer: Player {
    func positionToMark(board: Board) -> Position? {
        return Position(row: 0, col: 0)
    }
}
