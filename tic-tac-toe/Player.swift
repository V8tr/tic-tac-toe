//
//  Player.swift
//  tic-tac-toe
//
//  Created by Vadim Bulavin on 8/26/16.
//  Copyright © 2016 Vadim Bulavin. All rights reserved.
//

import Foundation

class Player {
    let marker: Marker
    let name: String
    
    init(name: String, marker: Marker) {
        self.name = name
        self.marker = marker
    }
    
    var displayName: String {
        return "\(marker.toString())   \(name)"
    }
}