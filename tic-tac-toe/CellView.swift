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
import Result

class CellView: UIView {
    @IBOutlet weak var invisibleButton: UIButton!
    @IBOutlet weak var markerImageView: UIImageView!
    
    private var view: UIView!
    private var tapAction: CocoaAction!
    
    var viewModel: CellViewModel! {
        didSet {
            bindViewModel()
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
}
