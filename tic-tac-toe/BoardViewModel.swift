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
    let selectionChangesSignal: Signal<Position, NoError>
    
    private var cellsViewModels: [CellViewModel]!
    
    private let selectionChangesObserver: Observer<Position, NoError>

    init(_ board: Board) {
        self.rows = board.rows
        self.cols = board.cols
        
        let (selectionSignal, selectionObserver) = Signal<Position, NoError>.pipe()
        self.selectionChangesSignal = selectionSignal
        self.selectionChangesObserver = selectionObserver
        
        var cellsViewModels: [CellViewModel] = []
        for row in 0..<board.rows {
            for col in 0..<board.cols {
                let cell = board.cellAtRow(row, col: col)
                cellsViewModels.append(createCellViewModel(cell))
            }
        }
        self.cellsViewModels = cellsViewModels
    }
    
    func markPosition(position: Position, marker: Marker) {
        let cellViewModel = cellViewModelAtRow(position.row, col: position.col)
        cellViewModel.mark(marker)
    }
    
    private func createCellViewModel(cell: Cell) -> CellViewModel {
        let cellViewModel = CellViewModel(cell: cell)
        
        cellViewModel.selection.producer
            .observeOn(UIScheduler())
            .skip(1)
            .startWithNext { [unowned self] _ in
                self.selectionChangesObserver.sendNext(cellViewModel.position)
        }
        
        return cellViewModel
    }
    
    func cellViewModelAtRow(row: Int, col: Int) -> CellViewModel {
        let idx = row * self.cols + col
        assert(idx >= 0 && idx < self.cellsViewModels.count);
        return self.cellsViewModels[idx]
    }
}