//
//  CrossMarkerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/2/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CrossMarkerView: MarkerView {
    override var strokeColor: UIColor {
        return UIColor.yellowColor()
    }
    
    override var path: UIBezierPath {
        let path = UIBezierPath()
        
        path.moveToPoint(CGPoint(x: bounds.maxX, y: 0.0))
        path.addLineToPoint(CGPoint(x: 0.0, y: bounds.maxY))
        
        path.moveToPoint(CGPoint.zero)
        path.addLineToPoint(CGPoint(x: bounds.maxX, y: bounds.maxY))
        
        return path
    }
}
