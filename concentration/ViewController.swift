//
//  ViewController.swift
//  concentration
//
//  Created by Samantha Bull on 30/11/2018.
//  Copyright © 2018 Samantha Bull. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var backgroundColour = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) {
        didSet {
            self.view.backgroundColor = backgroundColour
            newGameButton.setTitleColor(backgroundColour, for: .normal)
        }
    }
    var cardColour = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            gameTitleLabel.textColor = cardColour
            flipCountLabel.textColor = cardColour
            scoreLabel.textColor = cardColour
            newGameButton.backgroundColor = cardColour
        }
    }
    
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
    
    lazy var emojiChoices: String = getRandomTheme()
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Card not in cardButton")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newGame()
    }
    
    func updateViewFromModel() {
        flipCount = game.flips
        score = game.score
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = backgroundColour
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardColour
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
    
    private let colorThemes = [
        [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)],
        [#colorLiteral(red: 0.001419739613, green: 0.5, blue: 0.002202855277, alpha: 1), #colorLiteral(red: 0.7496827411, green: 0.1121456492, blue: 0.006477096593, alpha: 1)],
        [#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)],
        [#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 1, green: 0.9755425587, blue: 0.3735585, alpha: 1)],
        [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)],
        [#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
    ]
    
    private func getRandomTheme() -> String {
        let random = emojiThemes.count.arc4random
        backgroundColour = colorThemes[random][0]
        cardColour = colorThemes[random][1]
        return emojiThemes[random]
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
