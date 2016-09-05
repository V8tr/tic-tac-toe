//
//  Extensions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

/// Remove object
extension RangeReplaceableCollectionType where Generator.Element : Equatable {
    mutating func removeObject(object: Generator.Element) {
        if let index = indexOf(object) {
            removeAtIndex(index)
        }
    }
}

/// Random element
extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

/// Loading from nib
extension UICollectionViewCell {
    class var nib: UINib {
        return UINib(nibName: String(self), bundle: NSBundle(forClass: self))
    }
    
    class var ID: String {
        return String(self)
    }
}

/// Localization
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}