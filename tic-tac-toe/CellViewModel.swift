//
//  CellViewModel.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class CellViewModel {
    let row: Int
    let col: Int
    
    init(cell: Cell) {
        self.row = cell.row
        self.col = cell.col
    }
}
