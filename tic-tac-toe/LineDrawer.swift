//
//  LineDrawer.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/5/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class LineDrawer {
    private let collectionView: UICollectionView
    private let rows: Int
    private let cols: Int
    
    init(collectionView: UICollectionView, rows: Int, cols: Int) {
        self.collectionView = collectionView
        self.rows = rows
        self.cols = cols
    }
    
    func drawLineAnimated(indexPaths: [NSIndexPath], duration: NSTimeInterval, lineColor: UIColor) {
        guard let path = pathForIndexPaths(indexPaths) else { return }
        
        let lineWidth: CGFloat = 8.0
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = 0.0
        shapeLayer.path = path.CGPath
        collectionView.layer.addSublayer(shapeLayer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        shapeLayer.strokeEnd = 1.0
        shapeLayer.addAnimation(animation, forKey: "animatePath")
    }
    
    private func pathForIndexPaths(indexPaths: [NSIndexPath]) -> UIBezierPath? {
        guard indexPaths.count > 0 else { return nil }
        guard let direction = LineDirection(indexPaths: indexPaths, cols: cols) else { return nil }
        
        let positions: [CGPoint] = indexPaths.map { [weak self] indexPath in
            guard let relativePosition = self?.relativeDrawingPositionForIndexPath(indexPath, direction: direction)
                else { return CGPoint.zero }
            guard let attributes = self?.collectionView.layoutAttributesForItemAtIndexPath(indexPath)
                else { return CGPoint.zero }
            
            let origin = attributes.frame.origin
            let size = attributes.frame.size
            let x = relativePosition.x * size.width + origin.x
            let y = relativePosition.y * size.height + origin.y
            let position = CGPoint(x: x, y: y)
            return position
        }
        
        let path = UIBezierPath()
        path.moveToPoint(positions.first!)
        
        for idx in 1..<positions.count {
            path.addLineToPoint(positions[idx])
        }
        
        return path
    }
    
    func relativeDrawingPositionForIndexPath(indexPath: NSIndexPath, direction: LineDirection) -> CGPoint? {
        let row = indexPath.section
        let col = indexPath.row
        
        let isTop = row == 0
        let isBottom = row == rows - 1
        let isLeft = col == 0
        let isRight = col == cols - 1
        let isInner = row > 0 && row < rows - 1 || col > 0 || col < cols - 1
        
        if (isTop && isLeft) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 0.0)
            case .Horizontal: return CGPoint(x: 0.0, y: 0.5)
            case .DiagonalLeft: return CGPoint(x: 0.0, y: 0.0)
            default:
                assert(false)
                return nil
            }
        }
        else if (isTop && isRight) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 0.0)
            case .Horizontal: return CGPoint(x: 1.0, y: 0.5)
            case .DiagonalRight: return CGPoint(x: 1.0, y: 0.0)
            default:
                assert(false)
                return nil
            }
        }
        else if (isBottom && isLeft) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 1.0)
            case .Horizontal: return CGPoint(x: 0.0, y: 0.5)
            case .DiagonalRight: return CGPoint(x: 0.0, y: 1.0)
            default:
                assert(false)
                return nil
            }
        }
        else if (isBottom && isRight) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 1.0)
            case .Horizontal: return CGPoint(x: 1.0, y: 0.5)
            case .DiagonalLeft: return CGPoint(x: 1.0, y: 1.0)
            default:
                assert(false)
                return nil
            }
        }
        else if (isLeft) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 0.5)
            case .Horizontal: return CGPoint(x: 0.0, y: 0.5)
            default:
                assert(false)
                return nil
            }
        }
        else if (isRight) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 0.5)
            case .Horizontal: return CGPoint(x: 1.0, y: 0.5)
            default:
                assert(false)
                return nil
            }
        }
        else if (isTop) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 0.0)
            case .Horizontal: return CGPoint(x: 0.5, y: 0.5)
            default:
                assert(false)
                return nil
            }
        }
        else if (isBottom) {
            switch direction {
            case .Vertical: return CGPoint(x: 0.5, y: 1.0)
            case .Horizontal: return CGPoint(x: 0.5, y: 0.5)
            default:
                assert(false)
                return nil
            }
        }
        else if (isInner) {
            return CGPoint(x: 0.5, y: 0.5)
        }
        
        return CGPoint.zero
    }

}