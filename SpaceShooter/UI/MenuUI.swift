//
//  MenuUI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class MenuUI: SKNode {
    
    var startBtn: SKSpriteNode
    var scoreBtn: SKSpriteNode
    var exitBtn: SKSpriteNode
    
    var spaceText: SKLabelNode = SKLabelNode()
    var shooterText: SKLabelNode = SKLabelNode()
    var titleText: SKSpriteNode = SKSpriteNode()
    
    var startText: SKLabelNode = SKLabelNode()
    var scoreText: SKLabelNode = SKLabelNode()
    var exitText: SKLabelNode = SKLabelNode()
        
    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize
        
        startBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        scoreBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        exitBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        
        super.init()
        
        scale = getScale(viewSize: viewSize)
        
        spaceText = SKLabelNode(text: "SPACE")
        spaceText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        spaceText.position = CGPoint(x: 0, y: 15)
        titleText.addChild(spaceText)
        
        shooterText = SKLabelNode(text: "SHOOTER")
        shooterText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        shooterText.position = CGPoint(x: 0, y: -15)
        titleText.addChild(shooterText)
        
        let titleTextWidth = max(spaceText.frame.width, shooterText.frame.width)
        let titleTextHeight = spaceText.frame.height + shooterText.frame.height
        titleText.size = CGSize(width: titleTextWidth, height: titleTextHeight)
        titleText.anchorPoint = CGPoint(x: 0.5, y: 0.5) // center the anchor point
        titleText.setScale(1.7 * scale)
                
        titleText.position = CGPoint(x: 0, y: (viewSize.size.height / 4))
        startBtn.position = CGPoint(x: 0, y: -25)
        scoreBtn.position = CGPoint(x: 0, y: -175)
        
        startBtn.zPosition = 1
        startBtn.setScale(scale * 1.2)
        scoreBtn.zPosition = 1
        scoreBtn.setScale(scale * 1.2)
        exitBtn.zPosition = 1
        exitBtn.setScale(scale * 1.2)

        startText = SKLabelNode(text: "START GAME")
        startText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        startText.fontSize = CGFloat(30 * scale)
        startText.position = CGPoint(x: 0, y: -12)
        startText.setScale(scale)
        startBtn.addChild(startText)
        
        scoreText = SKLabelNode(text: "SCOREBOARD")
        scoreText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        scoreText.fontSize = CGFloat(30 * scale)
        scoreText.position = CGPoint(x: 0, y: -12)
        scoreText.setScale(scale)
        scoreBtn.addChild(scoreText)

        addChild(titleText)
        addChild(startBtn)
        addChild(scoreBtn)
        
        let scaleUp = SKAction.scale(to: 2 * scale, duration: 1)
        let scaleDown = SKAction.scale(to: 1.7 * scale, duration: 1)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        let repeatScale = SKAction.repeatForever(scaleSequence)
        titleText.run(repeatScale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getScale(viewSize: CGRect) -> CGFloat {
        let screenHeight = max(viewSize.height, viewSize.width)
        return(screenHeight / 1055)
    }
}


