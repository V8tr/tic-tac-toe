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
    
    private let viewModel: GameViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: "GameViewController", bundle: nil)
        
        bindViewModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boardView = BoardView(viewModel: viewModel.boardViewModel)
        boardView.delegate = self
        boardContainerView.addSubview(boardView)
        
        boardView.snp_makeConstraints { (make) in
            make.edges.equalTo(boardContainerView)
        }
    }
    
    private func bindViewModel() {
        viewModel.isGameOver.producer
            .observeOn(UIScheduler())
            .startWithNext { [weak self] isGameOver in
                guard let strongSelf = self else { return }
                guard isGameOver else { return }
                
                let viewModel = strongSelf.viewModel.createGameResultViewModel()
                let gameResultVC = GameResultViewController(viewModel: viewModel)
                strongSelf.presentViewController(gameResultVC, animated: true, completion: nil)
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

extension GameViewController: BoardViewDelegate {
    func boardView(boardView: BoardView, didTapCellAtIndexPath indexPath: NSIndexPath) {
        viewModel.markAction.apply(indexPath).producer.start()
        viewModel.nextTurn()
    }
}
