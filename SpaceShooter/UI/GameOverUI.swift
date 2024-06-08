//
//  GameOverUI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class GameOverUI: SKNode {
    
    var restartBtn: SKSpriteNode
    var exitBtn: SKSpriteNode
    
    var gameOverText: SKLabelNode = SKLabelNode()
    var completedText: SKLabelNode = SKLabelNode()
    var timeText: SKLabelNode = SKLabelNode()
    var restartText: SKLabelNode = SKLabelNode()
    var exitText: SKLabelNode = SKLabelNode()

    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize
        
        restartBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        exitBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        
        super.init()
        
        scale = getScale(viewSize: viewSize)
        
        gameOverText = SKLabelNode(text: "GAME OVER")
        gameOverText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        gameOverText.fontSize = CGFloat(50 * scale)
        gameOverText.position = CGPoint(x: 0, y: (viewSize.size.height / 4))
        gameOverText.setScale(scale)
                
        completedText = SKLabelNode(text: "You completed the challenge in")
        completedText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        completedText.fontSize = CGFloat(30 * scale)
        completedText.position = CGPoint(x: 0, y: (viewSize.size.height / 8))
        completedText.setScale(scale)
        
        timeText = SKLabelNode(text: "fsrsfs")
        timeText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        timeText.position = CGPoint(x: 0, y: 15)
        timeText.setScale(scale)
        
        restartText = SKLabelNode(text: "RESTART")
        restartText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        restartText.fontSize = CGFloat(30 * scale)
        restartText.position = CGPoint(x: 0, y: -12)
        restartText.setScale(scale)
        restartBtn.addChild(restartText)
        
        restartBtn.position = CGPoint(x: 0, y: -(viewSize.size.height / 6))
        restartBtn.setScale(scale * 1.2)
        restartBtn.zPosition = 1
        
        exitText = SKLabelNode(text: "EXIT")
        exitText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        exitText.fontSize = CGFloat(30 * scale)
        exitText.position = CGPoint(x: 0, y: -12)
        exitText.setScale(scale)
        exitBtn.addChild(exitText)
        
        exitBtn.position = CGPoint(x: 0, y: -(viewSize.size.height / 3))
        exitBtn.setScale(scale * 1.2)
        exitBtn.zPosition = 1
        
        addChild(gameOverText)
        addChild(completedText)
        addChild(timeText)
        addChild(restartBtn)
        addChild(exitBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getScale(viewSize: CGRect) -> CGFloat {
        let screenHeight = max(viewSize.height, viewSize.width)
        return(screenHeight / 1055)
    }
    
    func setTime(score: String) {
        timeText.text = score
    }
}


