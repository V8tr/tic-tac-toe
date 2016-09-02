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
    @IBOutlet weak var customContentView: UIView!
    
    private var markerView: MarkerView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for borderView in [leftBorderView, topBorderView, rightBorderView, bottomBorderView] {
            borderView.hidden = true
            borderView.backgroundColor = UIColor.blackColor()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for borderView in [leftBorderView, topBorderView, rightBorderView, bottomBorderView] {
            borderView.hidden = true
            borderView.backgroundColor = UIColor.blackColor()
        }
        if markerView != nil {
            self.markerView!.removeFromSuperview()
            self.markerView = nil
        }
    }
    
    var viewModel: CellViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        updateBorders(viewModel.borders)
        
        markerView = MarkerViewFactory.markerViewForSelection(viewModel.selection)
        
        customContentView.addSubview(markerView!)
        markerView!.snp_makeConstraints { make in
            make.edges.equalTo(customContentView)
        }
        
        markerView!.setNeedsLayout()
        markerView!.layoutIfNeeded()
        
        if (viewModel.canAnimate) {
            markerView!.animate(CellViewModel.animationDuration,
                                completion: { [weak self] in
                                    self?.viewModel.canAnimate = false
                })
        }
        else {
            markerView!.draw()
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
