//
//  DrawView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/6/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class DrawView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        let crossView = CrossMarkerView(frame: CGRect.zero)
        addSubview(crossView)
        
        crossView.snp_makeConstraints { make in
            make.left.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
            make.height.equalTo(crossView.snp_width)
            make.centerY.equalTo(self)
        }
        
        let circleView = CircleMarkerView(frame: CGRect.zero)
        addSubview(circleView)
        
        circleView.snp_makeConstraints { make in
            make.right.equalTo(self)
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
            make.height.equalTo(circleView.snp_width)
            make.centerY.equalTo(self)
        }
    }
}
