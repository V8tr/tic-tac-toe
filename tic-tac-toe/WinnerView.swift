//
//  WinnerView.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/6/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

class WinnerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(player: Player) {
        self.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.clearColor()
        
        let markerView = MarkerViewFactory.markerViewForMarker(player.marker)
        addSubview(markerView)
        
        markerView.snp_makeConstraints { make in
            make.width.equalTo(self.snp_width).multipliedBy(0.5)
            make.height.equalTo(markerView.snp_width)
            make.center.equalTo(self)
        }

        let drawLabel = UILabel()
        drawLabel.text = "game-result.label.winner".localized.uppercaseString
        drawLabel.textAlignment = .Center
        drawLabel.font = FontsConfiguration.gameResultFont
        drawLabel.textColor = ColorsConfiguration.gameResultLabel
        addSubview(drawLabel)
        
        drawLabel.snp_makeConstraints { make in
            make.top.equalTo(markerView.snp_bottom).offset(8.0)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
