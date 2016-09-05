//
//  Marker.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum Marker: Equatable {
    case Circle
    case Cross
    
    func imageName() -> String {
        switch self {
        case .Cross: return "cross"
        case .Circle: return "circle"
        }
    }
    
    func toString() -> String {
        switch self {
        case .Cross: return "╳"
        case .Circle: return "◯"
        }
    }
}