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
    
    static func markerViewForMarker(marker: Marker) -> MarkerView {
        switch marker {
        case .Circle: return CircleMarkerView(frame: CGRectZero)
        case .Cross: return CrossMarkerView(frame: CGRectZero)
        }
    }
}

class MarkerView: UIView {
    var shapeLayer: CAShapeLayer!
    
    var path: UIBezierPath {
        return UIBezierPath()
    }
    
    private var animationDuration: NSTimeInterval {
        return 0.4
    }
    
    var strokeColor: UIColor {
        return UIColor.blackColor()
    }
    
    var lineWidth: CGFloat {
        return 1.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = strokeColor.CGColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = 1.0
        layer.addSublayer(shapeLayer)
    }
    
    func animate(completion: () -> ()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            completion()
        })
        
        shapeLayer.removeAllAnimations()
        
        shapeLayer.path = path.CGPath
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = animationDuration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.addAnimation(animation, forKey: "animatePath")
        
        CATransaction.commit()
    }
    
    func draw() {
        shapeLayer.path = path.CGPath
        shapeLayer.strokeEnd = 1.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = path.CGPath
    }
}
