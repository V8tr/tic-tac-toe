//
//  BoardViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Result

class BoardViewModel {
    let rows: Int
    let cols: Int
    let selectionChangesSignal: Signal<NSIndexPath, NoError>
    
    private var cellsViewModels: [CellViewModel]!
    
    private let selectionChangesObserver: Observer<NSIndexPath, NoError>

    init(_ board: Board) {
        self.rows = board.rows
        self.cols = board.cols
        
        let (selectionSignal, selectionObserver) = Signal<NSIndexPath, NoError>.pipe()
        self.selectionChangesSignal = selectionSignal
        self.selectionChangesObserver = selectionObserver
        
        var cellsViewModels: [CellViewModel] = []
        for row in 0..<board.rows {
            for col in 0..<board.cols {
                let cell = board.cellAtRow(row, col: col)
                cellsViewModels.append(CellViewModel(cell: cell))
            }
        }
        self.cellsViewModels = cellsViewModels
    }
    
    func markPosition(position: Position, marker: Marker) {
        let cellViewModel = cellViewModelAtPosition(position)
        cellViewModel.mark(marker)
        selectionChangesObserver.sendNext(position.toIndexPath())
    }
    
    func cellViewModelAtIndexPath(indexPath: NSIndexPath) -> CellViewModel {
        let position = Position(indexPath: indexPath)
        return cellViewModelAtPosition(position)
    }
    
    private func cellViewModelAtPosition(position: Position) -> CellViewModel {
        let idx = position.row * self.cols + position.col
        assert(idx >= 0 && idx < self.cellsViewModels.count);
        return self.cellsViewModels[idx]
    }
}