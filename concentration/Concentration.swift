//
//  Concentration.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var score = 0
    private(set) var flips = 0
    
    private(set) var cards = [Card]()
    
    private var indexOfFaceUpCard: Int? {
        get {
            let faceUpIndices = cards.indices.filter({cards[$0].isFaceUp})
            return faceUpIndices.count == 1 ? faceUpIndices.first : nil
            
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): You must have at least one pair of cards")
        startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    mutating func startNewGame(numberOfPairsOfCards: Int) {
        cards = [Card]()
        indexOfFaceUpCard = nil
        score = 0
        flips = 0
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index is out of bounds")
        flips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                // second card up
                if cards[matchIndex] == cards[index] {
                    // match!
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                else if cards[matchIndex].seenBefore || cards[index].seenBefore {
                    score -= 1
                }
                cards[index].isFaceUp = true
                cards[index].seenBefore = true
                cards[matchIndex].seenBefore = true
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = index
            }
        }
    }
}

extension Collection {
    var onAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
