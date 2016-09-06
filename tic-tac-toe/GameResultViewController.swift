//
//  GameResultViewController.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import ReactiveCocoa

class GameResultViewController: UIViewController {
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var winnerViewContainer: UIView!
    
    var restartAction: CocoaAction!
    private let viewModel: GameResultViewModel

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: GameResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "GameResultViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartButton.setTitle("game-result.button.restart".localized, forState: .Normal)

        winnerViewContainer.backgroundColor = UIColor.clearColor()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        restartAction = CocoaAction(viewModel.restartAction) { _ in () }
        restartButton.addTarget(restartAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        
        let winnerView = viewModel.createWinnerView()
        winnerViewContainer.addSubview(winnerView)
        
        winnerView.snp_makeConstraints { make in
            make.edges.equalTo(winnerViewContainer)
        }
    }
}
