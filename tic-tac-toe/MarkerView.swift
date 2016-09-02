//
//  MarkerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

enum MarkerViewFactory {
    static func markerViewForSelection(selection: Selection) -> MarkerView {
        switch selection {
        case .Marked(let marker):
            return marker == .Circle ? CircleMarkerView(frame: CGRectZero) : CrossMarkerView(frame: CGRectZero)
        case .Empty:
            return EmptyMarkerView(frame: CGRectZero)
        }
    }
}

class MarkerView: UIView {
    var shapeLayer: CAShapeLayer!
    
    var strokeColor: UIColor {
        return UIColor.blackColor()
    }
    
    var path: UIBezierPath {
        return UIBezierPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = strokeColor.CGColor
        shapeLayer.lineWidth = 5.0;
        shapeLayer.strokeEnd = 0.0
        layer.addSublayer(shapeLayer)
    }
    
    func animate(duration: NSTimeInterval) {
        shapeLayer.removeAllAnimations()
        
        shapeLayer.path = path.CGPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.strokeEnd = 1.0
        shapeLayer.addAnimation(animation, forKey: "animateCircle")
    }
    
    func draw() {
        shapeLayer.path = path.CGPath
        shapeLayer.strokeEnd = 1.0
    }
}
