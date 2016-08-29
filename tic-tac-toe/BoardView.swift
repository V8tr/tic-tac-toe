//
//  BoardView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class BoardView : UIView {
    private let viewModel: BoardViewModel!
        
    // MARK: - init
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRectZero)
        
        drawBoard()
    }
    
    // MARK: - drawing
    private func drawBoard() {
        var rowStacks: [UIStackView] = []

        for row in 0..<viewModel.rows {
            
            var rowCellViews: [CellView] = []
            
            for col in 0..<viewModel.cols {
                rowCellViews.append(createCellViewAtRow(row, col: col))
            }

            let rowStack = rowStackWithCellView(rowCellViews)
            rowStacks.append(rowStack)
        }
        
        let boardStack = boardStackWithRowStacks(rowStacks)
        addSubview(boardStack)
        
        boardStack.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    private func createCellViewAtRow(row: Int, col: Int) -> CellView {
        let cellViewModel = viewModel.cellViewModelAtRow(row, col: col)
        let cellView = CellView(viewModel: cellViewModel)
        
//        cellView.tapSignal
//            .observeOn(UIScheduler())
//            .observeNext { position in
//            <#code#>
//        }
        
        cellView.backgroundColor = UIColor(red: CGFloat.random, green: CGFloat.random, blue: CGFloat.random, alpha: 1.0)
        return cellView
    }
    
    private func rowStackWithCellView(cellViews: [CellView]) -> UIStackView {
        let rowStack = UIStackView(arrangedSubviews: cellViews)
        rowStack.distribution  = .FillEqually
        rowStack.axis = .Horizontal
        rowStack.alignment = .Fill
        return rowStack
    }
    
    private func boardStackWithRowStacks(rowStacks: [UIStackView]) -> UIStackView {
        let boardStack = UIStackView(arrangedSubviews: rowStacks)
        boardStack.distribution  = .FillEqually
        boardStack.axis = .Vertical
        boardStack.alignment = .Fill
        return boardStack
    }
}