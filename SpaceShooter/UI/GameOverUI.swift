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
    
    var gameOverText: SKLabelNode = SKLabelNode()
    var completedText: SKLabelNode = SKLabelNode()
    var timeText: SKLabelNode = SKLabelNode()
    var restartText: SKLabelNode = SKLabelNode()

    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize
        
        restartBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        
        super.init()
        
        scale = getScale(viewSize: viewSize)
        
        gameOverText = SKLabelNode(text: "GAME OVER")
        gameOverText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        gameOverText.position = CGPoint(x: 0, y: 0)
        gameOverText.setScale(scale)
                
        completedText = SKLabelNode(text: "You completed the challenge in")
        completedText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        completedText.position = CGPoint(x: 0, y: 0)
        completedText.setScale(scale)
        
        timeText = SKLabelNode(text: "")
        timeText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        timeText.position = CGPoint(x: 0, y: 0)
        timeText.setScale(scale)
        
        restartText = SKLabelNode(text: "RESTART")
        restartText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        restartText.fontSize = CGFloat(30 * scale)
        restartText.position = CGPoint(x: 0, y: -12)
        restartText.setScale(scale)
        restartBtn.addChild(restartText)
        
        restartBtn.setScale(scale * 1.2)
        restartBtn.zPosition = 1

        addChild(gameOverText)
        addChild(completedText)
        addChild(timeText)
        addChild(restartBtn)
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


