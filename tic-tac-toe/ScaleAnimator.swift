//
//  ScaleAnimator.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/6/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class ScaleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration = 1.0
    var originalFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let gameResultsView = transitionContext.viewForKey(UITransitionContextToViewKey)!

        containerView.addSubview(gameResultsView)
        containerView.bringSubviewToFront(gameResultsView)
        
        gameResultsView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        gameResultsView.alpha = 0.0
        
        UIView.animateWithDuration(
            duration,
            animations: {
                gameResultsView.transform = CGAffineTransformIdentity
                gameResultsView.alpha = 1.0
            },
            completion: { _ in
                transitionContext.completeTransition(true)
        })
    }
}
