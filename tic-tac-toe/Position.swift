//
//  Position.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/5/16.
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