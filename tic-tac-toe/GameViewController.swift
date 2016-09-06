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
    @IBOutlet weak var playerLabel: UILabel!
    
    private let viewModel: GameViewModel
    private var boardView: BoardView!
    private let animator = ScaleAnimator()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "GameViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = ColorsConfiguration.gameBackground
        
        boardView = BoardView(viewModel: viewModel.boardViewModel)
        boardView.delegate = self
        boardContainerView.backgroundColor = UIColor.clearColor()
        boardContainerView.addSubview(boardView)
        
        boardView.snp_makeConstraints { (make) in
            make.edges.equalTo(boardContainerView)
        }
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.gameOverSignal
            .observeOn(UIScheduler())
            .observeNext { [weak self] indexPaths in
                guard let strongSelf = self else { return }
                
                strongSelf.boardView.drawLineAnimated(indexPaths,
                    duration: GameViewModel.gameOverAnimationDuration,
                    lineColor: strongSelf.viewModel.activePlayerColor)
                
                strongSelf.openGameResultScreenAfterDelay(GameViewModel.gameOverAnimationDuration)
        }
        
        viewModel.move.producer
            .observeOn(UIScheduler())
            .delay(GameViewModel.delayBetweenMoves, onScheduler: QueueScheduler.mainQueueScheduler)
            .skip(1)
            .startWithNext { [weak self] move in
                self?.viewModel.nextTurn()
        }
        
        viewModel.isWaitingForUserInteraction
            .producer
            .observeOn(UIScheduler())
            .startWithNext { [weak self] isWaitingForUserInteraction in
                self?.boardView.userInteractionEnabled = isWaitingForUserInteraction
        }
        
        DynamicProperty(object: playerLabel, keyPath: "text") <~ viewModel.activePlayerName
    }
    
    private func openGameResultScreenAfterDelay(delay: NSTimeInterval) {
        let gameResultViewModel = viewModel.createGameResultViewModel()
        let gameResultVC = GameResultViewController(viewModel: gameResultViewModel)
        gameResultVC.transitioningDelegate = self
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime, dispatch_get_main_queue()) { [weak self] in
            self?.presentViewController(gameResultVC, animated: true, completion: nil)
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
    }
}

extension GameViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(
        presented: UIViewController,
        presentingController presenting: UIViewController,
                             sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            animator.originalFrame = self.view.frame
            animator.duration = GameViewModel.gameOverAnimationDuration
            return animator
    }
}
