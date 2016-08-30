//
//  CellViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation
import ReactiveCocoa

class CellViewModel {
    let position: Position
    let selection: MutableProperty<Selection>
    
    private let cell: Cell
    private let board: Board
    
    // Actions
    lazy var tapAction: Action<Void, Void, NSError> = { [unowned self] in
        return Action { _ in
            if (self.board.isValidMoveAt(self.position)) {
                self.cell.mark(self.board.activeMarker)
                let newSelection = Selection.Marked(self.board.activeMarker)
                self.selection.swap(newSelection)
            }
            return SignalProducer.empty
        }
    }()

    init(cell: Cell) {
        self.position = cell.position
        self.selection = MutableProperty(cell.selection)
        self.cell = cell
        self.board = cell.board
    }
    
    var row: Int {
        return position.row
    }
    
    var col: Int {
        return position.col
    }
}
