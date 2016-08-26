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
    let tapSignal: Signal<Position, NoError>
    
    private let viewModel: CellViewModel!
    private let invisibleButton: UIButton
    private let tapObserver: Observer<Position, NoError>

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: CellViewModel) {
        self.viewModel = viewModel
        invisibleButton = UIButton()
        invisibleButton.setTitle("INVISIBLE BUTTON", forState: .Normal)
        
        let (signal, observer) = Signal<Position, NoError>.pipe()
        self.tapSignal = signal
        self.tapObserver = observer
        
        super.init(frame: CGRectZero)
        
        addSubview(invisibleButton)
        invisibleButton.addTarget(self, action: #selector(didTap), forControlEvents: .TouchUpInside)

        invisibleButton.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    func didTap(button: UIButton!) {
        self.tapObserver.sendNext(viewModel.position)
    }
}
