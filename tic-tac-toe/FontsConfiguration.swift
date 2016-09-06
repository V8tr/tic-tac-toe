//
//  FontsConfiguration.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 9/6/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

struct FontsConfiguration {
    typealias FontBuilder = (CGFloat) -> UIFont

    static let appFontOfSize: FontBuilder = { size in
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    static let gameResultFont = appFontOfSize(40)
    static let gameResultGameOverFont = appFontOfSize(25)
    static let gameResultRestartButtonFont = appFontOfSize(25)
    static let activePlayerFont = appFontOfSize(20)
}
