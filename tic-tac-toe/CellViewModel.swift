//
//  CellViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class CellViewModel {
    let position: Position
    private let cell: Cell
    private let board: Board

    var selection: Selection {
        didSet {
            switch selection {
            case .Marked(let marker):
                cell.mark(marker)
            case .Empty:
                cell.clearMarker()
            }
        }
    }

    init(cell: Cell) {
        self.position = cell.position
        self.selection = cell.selection
        self.cell = cell
        self.board = cell.board
    }
    
    func markBy(player: Player) {
        if (board.isValidMoveAt(cell.position, player: player)) {
            
        }
    }
    
    var row: Int {
        return position.row
    }
    
    var col: Int {
        return position.col
    }
}
