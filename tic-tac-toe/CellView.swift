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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
        invisibleButton = UIButton()
        invisibleButton.setTitle("INVISIBLE BUTTON", forState: .Normal)

        super.init(frame: CGRectZero)
        
        addSubview(invisibleButton)
        invisibleButton.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        testSignal()
    }
    
    func testSignal() {
        invisibleButton
            .rac_signalForControlEvents(.TouchUpInside)
            .subscribeNext { _ in ()
        }
    }
}
