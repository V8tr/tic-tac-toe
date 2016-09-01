//
//  CircleMarkerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CircleMarkerView: MarkerView {
    override func animate(duration: NSTimeInterval) {
        shapeLayer.removeAllAnimations()
        
        let path = UIBezierPath(arcCenter: self.center,
                                radius: (self.frame.size.width - 10) / 2,
                                startAngle: 0.0,
                                endAngle: CGFloat(M_PI * 2.0),
                                clockwise: true)
        shapeLayer.path = path.CGPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.strokeEnd = 1.0
        shapeLayer.addAnimation(animation, forKey: "animateCircle")
    }
}
