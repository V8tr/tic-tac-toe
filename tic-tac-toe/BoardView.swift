//
//  BoardView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/23/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa

protocol BoardViewDelegate: class {
    func boardView(boardView: BoardView, didTapCellAtIndexPath indexPath: NSIndexPath)
}

enum LineDirection {
    case Vertical
    case Horizontal
    case DiagonalLeft
    case DiagonalRight
    
    init?(indexPaths: [NSIndexPath], cols: Int) {
        guard indexPaths.count > 0 else { return nil }
        
        typealias Filter = (NSIndexPath) -> Bool
        
        let verticalFilter: Filter = { return $0.row == indexPaths.first!.row }
        let horizontalFilter: Filter = { return $0.section == indexPaths.first!.section }
        let leftDiagonalFilter: Filter = { return $0.section == $0.row }
        let rightDiagonalFilter: Filter = { return $0.section == cols - $0.row - 1 }
        
        let filters: [LineDirection: Filter] = [.Vertical: verticalFilter,
                                                .Horizontal: horizontalFilter,
                                                .DiagonalLeft: leftDiagonalFilter,
                                                .DiagonalRight: rightDiagonalFilter]
        
        print(filters)
        
        for (direction, filter) in filters {
            if indexPaths.count == indexPaths.filter(filter).count {
                self = direction
                return
            }
        }
        
        return nil
    }
}

class BoardView : UIView {
    private let viewModel: BoardViewModel!
    private var collectionView: UICollectionView!
    
    weak var delegate: BoardViewDelegate?
    
    // MARK: - init
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    init(viewModel: BoardViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRectZero)
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.yellowColor()
        
        collectionView.registerNib(CellCollectionCell.nib, forCellWithReuseIdentifier: CellCollectionCell.ID)
        
        addSubview(collectionView)
        collectionView.snp_makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    private func bindViewModel() {
        viewModel.selectionChangesSignal
            .observeOn(UIScheduler())
            .observeNext { [weak self] indexPath in
                self?.collectionView.reloadData()
        }
    }
    
    func drawLineAnimated(indexPaths: [NSIndexPath], duration: NSTimeInterval) {
        guard let path = pathForIndexPaths(indexPaths) else { return }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.lineWidth = 5.0;
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
    
    func pathForIndexPaths(indexPaths: [NSIndexPath]) -> UIBezierPath? {
        guard indexPaths.count > 0 else { return nil }
        guard let direction = LineDirection(indexPaths: indexPaths, cols: viewModel.cols) else { return nil }
        
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
        let rows = viewModel.rows
        let cols = viewModel.cols
        
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
            case .Horizontal: return CGPoint(x: 0.5, y: 0.5)
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

extension BoardView: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        delegate?.boardView(self, didTapCellAtIndexPath: indexPath)
    }
}

extension BoardView: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return viewModel.rows
    }
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.cols
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellCollectionCell.ID,
                                                                         forIndexPath: indexPath) as! CellCollectionCell
        cell.viewModel = viewModel.cellViewModelAtIndexPath(indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: bounds.size.width / CGFloat(viewModel.cols),
                      height: bounds.size.height / CGFloat(viewModel.rows))
    }
}