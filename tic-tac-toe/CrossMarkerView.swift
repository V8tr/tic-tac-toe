//
//  CrossMarkerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/2/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CrossMarkerView: MarkerView {
    override var path: UIBezierPath {
        let path = UIBezierPath()
        
        let offset: CGFloat = bounds.size.width * 0.2
        
        path.moveToPoint(CGPoint(x: bounds.maxX - offset, y: offset))
        path.addLineToPoint(CGPoint(x: offset, y: bounds.maxY - offset))
        
        path.moveToPoint(CGPoint(x: offset, y: offset))
        path.addLineToPoint(CGPoint(x: bounds.maxX - offset, y: bounds.maxY - offset))
        
        return path
    }
    
    override var strokeColor: UIColor {
        return ColorsConfiguration.crossMarker
    }
}
