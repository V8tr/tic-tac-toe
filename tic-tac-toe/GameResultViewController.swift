//
//  GameResultViewController.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class GameResultViewController: UIViewController {
    private let viewModel: GameResultViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: GameResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "GameResultViewController", bundle: nil)
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
