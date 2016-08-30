//
//  UICollectionViewCell+Additions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/30/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    class var nib: UINib {
        return UINib(nibName: String(self), bundle: NSBundle(forClass: self))
    }
    
    class var ID: String {
        return String(self)
    }
}