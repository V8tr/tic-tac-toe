//
//  CellCollectionCell.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import ReactiveCocoa

class CellCollectionCell: UICollectionViewCell {    
    @IBOutlet weak var markerImageView: UIImageView!
    @IBOutlet weak var leftBorderView: UIView!
    @IBOutlet weak var topBorderView: UIView!
    @IBOutlet weak var rightBorderView: UIView!
    @IBOutlet weak var bottomBorderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for borderView in [leftBorderView, topBorderView, rightBorderView, bottomBorderView] {
            borderView.hidden = true
            borderView.backgroundColor = UIColor.blackColor()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var viewModel: CellViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        updateBorders(viewModel.borders)
        
        viewModel.selection.producer
            .observeOn(UIScheduler())
            .startWithNext { [weak self] selection in
                if let imageName = selection.imageName() {
                    self?.markerImageView.image = UIImage(named: imageName)
                }
                else {
                    self?.markerImageView.image = nil
                }
        }
    }

    private func updateBorders(borders: [CellBorder]) {
        for border in borders {
            switch border {
            case .Left:
                leftBorderView.hidden = false
            case .Right:
                rightBorderView.hidden = false
            case .Top:
                topBorderView.hidden = false
            case .Bottom:
                bottomBorderView.hidden = false
            }
        }
    }
}
