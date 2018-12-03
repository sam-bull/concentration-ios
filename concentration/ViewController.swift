//
//  ViewController.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var emojiChoices = getRandomTheme()
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Card not in cardButton")
        }
    }
    
    func updateViewFromModel() {
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
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    @IBAction func newGame() {
        flipCount = 0
        emojiChoices = getRandomTheme()
        let numberOfPairsOfCards = (cardButtons.count + 1) / 2
        game.startNewGame(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
    }
    
    let emojiThemes = [
        ["🎃", "👻", "💀", "😈", "🦇", "😱"],
        ["🎅🏾", "⭐️", "⛄️", "🔔", "🎁", "🎄"],
        ["🐣", "🐇", "🥚", "🍫", "🌱", "🧺"],
        ["🍏", "🍊", "🍓", "🍌", "🍇", "🍉"],
        ["🐶", "🐱", "🐭", "🐨", "🐰", "🐼"],
        ["👮‍♀️", "👷‍♀️", "👩‍🌾", "👩‍🏫", "👩‍🍳", "👩‍🔬"]
    ]
    
    func getRandomTheme() -> Array<String> {
        let emojiIndex: Int = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        return emojiThemes[emojiIndex]
    }
}

