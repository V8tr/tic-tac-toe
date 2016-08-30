//
//  CommonExtension.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    mutating func removeObject(object: Generator.Element) {
        if let index = indexOf(object) {
            removeAtIndex(index)
        }
    }
}