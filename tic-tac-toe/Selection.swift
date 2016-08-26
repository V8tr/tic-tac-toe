//
//  Selection.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

enum Selection: Equatable {
    case Empty
    case Marked(Marker)
}

func == (lhs: Selection, rhs: Selection) -> Bool {
    switch (lhs, rhs) {
    case (.Empty, .Empty):
        return true
    case (.Marked(let m1), .Marked(let m2)):
        return m1 == m2
    default:
        return false
    }
}