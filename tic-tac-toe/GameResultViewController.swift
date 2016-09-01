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
    @IBOutlet weak var winnerView: UIView!
    
    var restartAction: CocoaAction!
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
        restartAction = CocoaAction(viewModel.restartAction) { _ in () }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restartButton.setTitle("game-result.button.restart".localized, forState: .Normal)
        restartButton.addTarget(restartAction, action: CocoaAction.selector, forControlEvents: .TouchUpInside)
        
        winnerView.backgroundColor = UIColor.yellowColor()
        
        let imageView = UIImageView(image: viewModel.resultImage)
        imageView.contentMode = .ScaleAspectFit
        winnerView.addSubview(imageView)
        
        imageView.snp_makeConstraints { make in
            make.edges.equalTo(winnerView)
        }
    }
}
