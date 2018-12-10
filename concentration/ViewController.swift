//
//  ViewController.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var emojiChoices: String = getRandomTheme()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Card not in cardButton")
        }
    }
    
    func updateViewFromModel() {
        flipCount = game.flips
        score = game.score
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = [Card:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
    
    @IBAction func newGame() {
        flipCount = 0
        score = 0
        emojiChoices = getRandomTheme()
        game.startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    private let emojiThemes = [
        "🎃👻💀😈🦇😱",
        "🎅🏾⭐️⛄️🔔🎁🎄",
        "🐣🐇🥚🍫🌱🧺",
        "🍏🍊🍓🍌🍇🍉",
        "🐶🐱🐭🐨🐰🐼",
        "👮‍♀️👷‍♀️👩‍🌾👩‍🏫👩‍🍳👩‍🔬"
    ]
    
    private func getRandomTheme() -> String {
        return emojiThemes[emojiThemes.count.arc4random]
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
