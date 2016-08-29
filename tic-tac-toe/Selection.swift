//
//  Selection.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum Selection {
    case Empty
    case Marked(Marker)
    
    func imageName() -> String? {
        switch self {
        case .Marked(let mark): return mark.imageName()
        case .Empty: return nil
        }
    }
}