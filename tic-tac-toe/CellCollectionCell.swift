//
//  CellCollectionCell.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class CellCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var viewModel: CellViewModel! {
        didSet {
            let cellView = CellView.fromNib() as CellView
            cellView.viewModel = viewModel
            addSubview(cellView)
            
            cellView.snp_makeConstraints { (make) in
                make.edges.equalTo(self)
            }
        }
    }
}
