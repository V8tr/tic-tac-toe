//
//  Board.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Board {
    private var cells: [Cell]!
    let rows: Int
    let cols: Int
    
    var cellsCount: Int {
        return self.cells.count
    }
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        var cells: [Cell] = []

        for row in 0..<rows {
            for col in 0..<cols {
                let position = Position(row: row, col: col)
                let cell = Cell(position: position, board: self)
                cells.append(cell)
            }
        }
        
        self.cells = cells
    }
    
    func cellAtRow(row: Int, col: Int) -> Cell {
        let idx = row * self.cols + col
        assert(idx >= 0 && idx < self.cellsCount);
        return self.cells[idx]
    }
}