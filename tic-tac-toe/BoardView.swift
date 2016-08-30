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
    private var collectionView: UICollectionView!
        
    // MARK: - init
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRectZero)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.yellowColor()
        
        collectionView.registerNib(CellCollectionCell.nib, forCellWithReuseIdentifier: CellCollectionCell.ID)
        
        addSubview(collectionView)
        collectionView.snp_makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    // MARK: - drawing
    private func drawBoard() {
        var rowStacks: [UIStackView] = []

        for row in 0..<viewModel.rows {
            var rowCellViews: [CellView] = []
            
            for col in 0..<viewModel.cols {
                rowCellViews.append(createCellViewAtRow(row, col: col))
            }
            
            let rowStack = createRowStackWithCellView(rowCellViews)
            rowStacks.append(rowStack)
        }
        
        let boardStack = createBoardStackWithRowStacks(rowStacks)
        addSubview(boardStack)
        
        boardStack.snp_makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func createCellViewAtRow(row: Int, col: Int) -> CellView {
        let cellView = CellView.fromNib() as CellView
        cellView.viewModel = viewModel.cellViewModelAtRow(row, col: col)
        return cellView
    }
    
    private func createRowStackWithCellView(cellViews: [CellView]) -> UIStackView {
        let rowStack = UIStackView(arrangedSubviews: cellViews)
        rowStack.distribution  = .FillEqually
        rowStack.axis = .Horizontal
        rowStack.alignment = .Fill
        return rowStack
    }
    
    private func createBoardStackWithRowStacks(rowStacks: [UIStackView]) -> UIStackView {
        let boardStack = UIStackView(arrangedSubviews: rowStacks)
        boardStack.distribution  = .FillEqually
        boardStack.axis = .Vertical
        boardStack.alignment = .Fill
        return boardStack
    }
}

extension BoardView: UICollectionViewDelegate {
    
}

extension BoardView: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.rows
    }
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.cols
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellCollectionCell.ID,
                                                                         forIndexPath: indexPath) as! CellCollectionCell
        cell.viewModel = viewModel.cellViewModelAtRow(indexPath.section, col: indexPath.item)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: bounds.size.width / CGFloat(viewModel.cols),
                      height: bounds.size.height / CGFloat(viewModel.rows))
    }
}