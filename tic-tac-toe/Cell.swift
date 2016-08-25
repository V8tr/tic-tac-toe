//
//  Cell.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Cell {
    let row: Int
    let col: Int
    private let board: Board
    
    init(row: Int, col: Int, board: Board) {
        self.row = row
        self.col = col
        self.board = board
    }
}