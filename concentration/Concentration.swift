//
//  Concentration.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int) {
        startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    func startNewGame(numberOfPairsOfCards: Int) {
        cards = [Card]()
        indexOfFaceUpCard = nil
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    // match!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfFaceUpCard = nil
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
