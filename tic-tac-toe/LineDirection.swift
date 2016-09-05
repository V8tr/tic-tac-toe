//
//  LineDirection.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/5/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum LineDirection {
    case Vertical
    case Horizontal
    case DiagonalLeft
    case DiagonalRight
    
    init?(indexPaths: [NSIndexPath], cols: Int) {
        guard indexPaths.count > 0 else { return nil }
        
        typealias Filter = (NSIndexPath) -> Bool
        
        let verticalFilter: Filter = { return $0.row == indexPaths.first!.row }
        let horizontalFilter: Filter = { return $0.section == indexPaths.first!.section }
        let leftDiagonalFilter: Filter = { return $0.section == $0.row }
        let rightDiagonalFilter: Filter = { return $0.section == cols - $0.row - 1 }
        
        let filters: [LineDirection: Filter] = [.Vertical: verticalFilter,
                                                .Horizontal: horizontalFilter,
                                                .DiagonalLeft: leftDiagonalFilter,
                                                .DiagonalRight: rightDiagonalFilter]
        
        print(filters)
        
        for (direction, filter) in filters {
            if indexPaths.count == indexPaths.filter(filter).count {
                self = direction
                return
            }
        }
        
        return nil
    }
}