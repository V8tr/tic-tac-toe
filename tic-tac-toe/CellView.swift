//
//  CellView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class CellView: UIView {
    @IBOutlet weak var invisibleButton: UIButton!
    @IBOutlet weak var markerImageView: UIImageView!
    
    // hidden in nib
    @IBOutlet weak var leftBorderView: UIView!
    @IBOutlet weak var topBorderView: UIView!
    @IBOutlet weak var rightBorderView: UIView!
    @IBOutlet weak var bottomBorderView: UIView!
    
    private var tapAction: CocoaAction!
    
    var viewModel: CellViewModel! {
        didSet {
            bindViewModel()
            setupUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        for borderView in [leftBorderView, topBorderView, rightBorderView, bottomBorderView] {
            borderView.hidden = true
            borderView.backgroundColor = UIColor.blackColor()
        }
    }
    
    private func bindViewModel() {
        tapAction = CocoaAction(viewModel.tapAction, { _ in () })

        invisibleButton.addTarget(tapAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        
        viewModel.selection.producer
            .observeOn(UIScheduler())
            .startWithNext { [weak self] selection in
                var image: UIImage? = nil
                if let imageName = selection.imageName() {
                    image = UIImage(named: imageName)
                }
                self?.markerImageView.image = image
        }
    }
    
    private func setupUI() {        
        for border in viewModel.borders {
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
