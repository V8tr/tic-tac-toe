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
    
    var viewModel: GameViewModel! {
        didSet {
            bindViewModel()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardView = BoardView(viewModel: viewModel.boardViewModel)
        boardContainerView.addSubview(boardView)
        
        boardView.snp_makeConstraints { (make) in
            make.center.equalTo(boardContainerView)
            make.width.equalTo(boardContainerView)
            make.height.equalTo(boardContainerView.snp_width)
        }
    }
    
    private func bindViewModel() {
        viewModel.gameOverSignal
            .observeOn(UIScheduler())
            .observeNext { [weak self] gameResult in
                guard let strongSelf = self else { return }
                
                switch gameResult {
                case .InProgress:
                    break
                case .Draw:
                    strongSelf.draw()
                case .Win(let player):
                    strongSelf.win(player)
                }
        }
    }
    
    private func draw() {
        showAlertWithTitle(nil, message: "game.alert.draw".localized)
    }
    
    private func win(player: Player) {
        let message = String(format: "game.alert.win-format".localized, player.name)
        showAlertWithTitle(nil, message: message)
    }
}
