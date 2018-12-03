//
//  Concentration.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import Foundation

class Concentration {
    
    var score = 0
    var flips = 0
    
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    func startNewGame(numberOfPairsOfCards: Int) {
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
    
    func chooseCard(at index: Int) {
        flips += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                // second card up
                if cards[matchIndex].identifier == cards[index].identifier {
                    // match!
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                else if cards[matchIndex].seenBefore || cards[index].seenBefore {
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
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
