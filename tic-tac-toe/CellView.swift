//
//  CellView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CellView: UIView {
    private let viewModel: CellViewModel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRectZero)
    }
}