//
//  GameViewController.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/25/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

class GameViewController: UIViewController {
    @IBOutlet weak var boardContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let activePlayer = Player(name: "V8tr", marker: .Circle)
        let board = Board(rows: 3, cols: 3)
        let game = Game(players: [activePlayer], board: board)
        game.activePlayer = activePlayer
        
        let boardViewModel = BoardViewModel(board)
        let boardView = BoardView(viewModel: boardViewModel)
        
        boardContainerView.addSubview(boardView)
        boardView.snp_makeConstraints { (make) in
            make.center.equalTo(boardContainerView)
            make.width.equalTo(boardContainerView)
            make.height.equalTo(boardContainerView.snp_width)
        }
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        
    }
}
