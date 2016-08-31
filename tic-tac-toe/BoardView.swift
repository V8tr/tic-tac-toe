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

protocol BoardViewDelegate: class {
    func boardView(boardView: BoardView, didTapCellAtIndexPath indexPath: NSIndexPath)
}

class BoardView : UIView {
    private let viewModel: BoardViewModel!
    private var collectionView: UICollectionView!
    
    weak var delegate: BoardViewDelegate?
    
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
}

extension BoardView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.boardView(self, didTapCellAtIndexPath: indexPath)
    }
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
        cell.viewModel = viewModel.cellViewModelAtIndexPath(indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: bounds.size.width / CGFloat(viewModel.cols),
                      height: bounds.size.height / CGFloat(viewModel.rows))
    }
}