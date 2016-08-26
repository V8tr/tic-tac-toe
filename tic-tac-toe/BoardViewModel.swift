//
//  BoardViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class BoardViewModel {
    let rows: Int
    let cols: Int
    private var cellsViewModels: [CellViewModel]!
    
    init(_ board: Board) {
        self.rows = board.rows
        self.cols = board.cols
        
        var cellsViewModels: [CellViewModel] = []
        for row in 0..<board.rows {
            for col in 0..<board.cols {
                let cell = board.cellAtRow(row, col: col)
                let cellViewModel = CellViewModel(cell: cell)
                cellsViewModels.append(cellViewModel)
            }
        }
        self.cellsViewModels = cellsViewModels
    }
    
    func cellViewModelAtRow(row: Int, col: Int) -> CellViewModel {
        let idx = row * self.cols + col
        assert(idx >= 0 && idx < self.cellsViewModels.count);
        return self.cellsViewModels[idx]
    }
}