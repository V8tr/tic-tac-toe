//
//  Cell.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

struct Position {
    let row: Int
    let col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    init(indexPath: NSIndexPath) {
        row = indexPath.section
        col = indexPath.row
    }
    
    func toIndexPath() -> NSIndexPath {
        return NSIndexPath(forRow: col, inSection: row)
    }
}

class Cell {
    var selection: Selection
    let position: Position
    let board: Board

    init(position: Position, board: Board) {
        self.position = position
        self.board = board
        self.selection = .Empty
    }
    
    func mark(marker: Marker) {
        selection = .Marked(marker)
    }

    var row: Int {
        return position.row
    }
    
    var col: Int {
        return position.col
    }
    
    var isEmpty: Bool {
        return selection == .Empty
    }
}