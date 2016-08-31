//
//  Array+Additions.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/31/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

extension Array {
    func randomElement() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}