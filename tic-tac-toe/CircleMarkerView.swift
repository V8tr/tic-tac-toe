//
//  CircleMarkerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/1/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CircleMarkerView: MarkerView {    
    override var path: UIBezierPath {
        let offset: CGFloat = 20
        return UIBezierPath(arcCenter: CGPoint(x: CGRectGetMidX(bounds), y: CGRectGetMidY(bounds)),
                            radius: (bounds.size.width - offset) / 2,
                            startAngle: 0.0,
                            endAngle: CGFloat(M_PI * 2.0),
                            clockwise: true)
    }
    
    override var strokeColor: UIColor {
        return ColorsConfiguration.circleMarker
    }
}
