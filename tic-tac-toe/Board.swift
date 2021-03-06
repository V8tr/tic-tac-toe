//
//  Board.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Board {
    var game: Game!
    let rows: Int
    let cols: Int
    
    private var cells: [Cell]!
    private var analyzer: BoardAnalyzer!
    
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
        
        self.analyzer = BoardAnalyzer(board: self, sequenceLength: 3)
    }
    
    func cellAtRow(row: Int, col: Int) -> Cell {
        let idx = row * self.cols + col
        assert(idx >= 0 && idx < self.cellsCount);
        return self.cells[idx]
    }
    
    var cellsCount: Int {
        return self.cells.count
    }
    
    var players: [Player] {
        return game.players
    }
    
    func isValidMoveAt(position: Position) -> Bool {
        let cell = cellAtRow(position.row, col: position.col)
        return cell.isEmpty
    }
    
    func gameResult() -> GameResult {
        return analyzer.gameResultForCells(cells)
    }
}