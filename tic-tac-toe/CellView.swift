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
    private let viewModel: CellViewModel!
    private let invisibleButton: UIButton
    private var tapAction: CocoaAction

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
        self.tapAction = CocoaAction(viewModel.tapAction, { _ in () })
        
        invisibleButton = UIButton()
        
        super.init(frame: CGRectZero)
        
        invisibleButton.setTitle("INVISIBLE BUTTON", forState: .Normal)
        invisibleButton.addTarget(tapAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        addSubview(invisibleButton)

        invisibleButton.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}
