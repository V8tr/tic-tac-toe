//
//  BoardView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class BoardView : UIView {
    private let viewModel: BoardViewModel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRectZero)
        
        drawBoard()
    }
    
    func drawBoard() {        
        for row in 0..<viewModel.rows {
            for col in 0..<viewModel.cols {
                let cellViewModel = self.viewModel.cellViewModelAtRow(row, col: col)
                let cellView = CellView(viewModel: cellViewModel)
                print("draw [\(row), \(col)]")
            }
        }
    }
    
    
}