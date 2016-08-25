//
//  BoardView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import SnapKit

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
        let boardStack = UIStackView()
        boardStack.distribution  = UIStackViewDistribution.EqualSpacing
        var rowStacks: [UIStackView] = []

        for row in 0..<viewModel.rows {
            let rowStack = UIStackView()
            rowStack.distribution  = UIStackViewDistribution.EqualSpacing
            var rowCellViews: [CellView] = []
            for col in 0..<viewModel.cols {
                let cellViewModel = viewModel.cellViewModelAtRow(row, col: col)
                let cellView = CellView(viewModel: cellViewModel)
                cellView.backgroundColor = UIColor(red: CGFloat.random, green: CGFloat.random, blue: CGFloat.random, alpha: 1.0)
                
                rowCellViews.append(cellView)
//                self.addSubview(cellView)
//                cellView.snp_makeConstraints(closure: { (make) in
//                    make.width.equalTo(self).dividedBy(viewModel.cols)
//                    make.height.equalTo(self).dividedBy(viewModel.rows)
//                    make.left.equalTo(self).offset(self.bounds.size.width / CGFloat(col + 1))
//                    make.top.equalTo(self).dividedBy(self.bounds.size.height / CGFloat(row + 1))
//                })
            }

            for cellView in rowCellViews {
                rowStack.addArrangedSubview(cellView)
            }
//            addSubview(rowStack)
            rowStacks.append(rowStack)
        }
        
        for stack in rowStacks {
            boardStack.addArrangedSubview(stack)
        }
        addSubview(boardStack)
        boardStack.snp_makeConstraints { (make) in
            make.size.equalTo(self)
            make.center.equalTo(self)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}