//
//  UI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class UI: SKSpriteNode {
    
    let lifeUI: SKSpriteNode
    let shieldUI: SKSpriteNode
    
    override init() {
                
        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"), color: .white, size: SKTexture(imageNamed: "health4").size())
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"), color: .white, size: SKTexture(imageNamed: "shield4").size())
        
        super.init()
        
        // Access the frame property after the superclass is initialized
        lifeUI.position = CGPoint(x: self.frame.minX + 20, y: self.frame.maxY - 50)
        lifeUI.zPosition = 1
        
        shieldUI.position = CGPoint(x: self.frame.minX + 20, y: self.frame.maxY - 20)
        shieldUI.zPosition = 1
        
        // Add child nodes to the UI
        addChild(lifeUI)
        addChild(shieldUI)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
