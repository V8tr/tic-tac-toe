//
//  CellViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation
import ReactiveCocoa

enum CellBorder {
    case Left
    case Right
    case Top
    case Bottom
}

class CellViewModel {
    let position: Position
    var selection: Selection
    var canAnimate = false
    
    private let cell: Cell
    private let board: Board

    init(cell: Cell) {
        self.position = cell.position
        self.selection = cell.selection
        self.cell = cell
        self.board = cell.board
    }
    
    func mark(marker: Marker) {
        cell.mark(marker)
        selection = cell.selection
        canAnimate = !cell.isEmpty
    }
    
    var row: Int {
        return position.row
    }
    
    var col: Int {
        return position.col
    }
    
    var borders: [CellBorder] {
        var borders: [CellBorder] = [.Left, .Right, .Top, .Bottom]
        
        let isCorner = row == 0 && col == 0
            || row == 0 && col == board.cols - 1
            || row == board.rows - 1 && col == 0
            || row == board.rows - 1 && col == board.cols - 1
        
        let isInnerTop = row == 0 && !isCorner
        let isInnerBottom = row == board.rows - 1 && !isCorner
        
        let isInnerLeft = col == 0 && !isCorner
        let isInnerRight = col == board.cols - 1 && !isCorner

        if (isCorner) {
            borders.removeAll()
        }
        else if (isInnerTop || isInnerBottom) {
            borders.removeObject(.Top)
            borders.removeObject(.Bottom)
        }
        else if (isInnerLeft || isInnerRight) {
            borders.removeObject(.Left)
            borders.removeObject(.Right)
        }
        
        return borders
    }
}
