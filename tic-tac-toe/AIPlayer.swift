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
        var rows: [Int] = Array(0..<board.rows)
        
        while (!rows.isEmpty) {
            let rowToMark = rows.randomElement()
            var cols: [Int] = Array(0..<board.cols)
            
            while (!cols.isEmpty) {
                let colToMark = cols.randomElement()
                let cell = board.cellAtRow(rowToMark, col: colToMark)
                if (cell.isEmpty) {
                    return Position(row: rowToMark, col: colToMark)
                }
                cols.removeObject(colToMark)
            }
            
            rows.removeObject(rowToMark)
        }
        
        return nil
    }
    
}
