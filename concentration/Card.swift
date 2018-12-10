//
//  Card.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    var seenBefore = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    var hashValue: Int {return identifier }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
