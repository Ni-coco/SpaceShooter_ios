//
//  UI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class DisplayUI: SKNode {
    
    let lifeUI: SKSpriteNode
    let shieldUI: SKSpriteNode
    
    let screenSize = UIScreen.main.bounds
    
    override init() {
                
        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"))
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"))
        
        super.init()
        
        lifeUI.zPosition = 1
        lifeUI.setScale(1.2)
        
        shieldUI.zPosition = 1
        shieldUI.setScale(1.2)
        
        // Calculate position based on the bottom left of the screen
//        lifeUI.position = CGPoint(x: screenSize.minX + lifeUI.size.width / 2, y: screenSize.minY + lifeUI.size.height / 2)
//        shieldUI.position = CGPoint(x: screenSize.minX + shieldUI.size.width / 2, y: screenSize.minY + shieldUI.size.height / 2)
                    
        addChild(lifeUI)
        addChild(shieldUI)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
