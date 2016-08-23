//
//  Board.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Board {
    private let cells: [Cell]
    
    var cellsCount: Int {
        return self.cells.count
    }
    
    init(rows: Int, cols: Int) {
        
        var cells: [Cell] = []
        
        for row in 0..<rows {
            for col in 0..<cols {
                let cell = Cell(row: row, col: col)
                cells.append(cell)
            }
        }
        
        self.cells = cells
    }
}