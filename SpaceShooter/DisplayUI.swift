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
    
    let sceneSize: CGRect

    init(sceneSize: CGRect) {
        
        self.sceneSize = sceneSize

        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"))
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"))
        
        super.init()
        
        let initialXPosition = sceneSize.minX + lifeUI.size.width / 2.0 // Adjust if necessary
        let initialYPosition = sceneSize.minY + lifeUI.size.height / 2.0 // Adjust if necessary
        lifeUI.position = CGPoint(x: initialXPosition, y: initialYPosition + 30)
        shieldUI.position = CGPoint(x: initialXPosition, y: initialYPosition)
        
//        lifeUI.position = CGPoint(x: sceneSize.minX + 90, y: sceneSize.minY + 60)
        lifeUI.zPosition = 1
        lifeUI.setScale(1.2)
        
//        shieldUI.position = CGPoint(x: sceneSize.minX + 90, y: sceneSize.minY + 30)
        shieldUI.zPosition = 1
        shieldUI.setScale(1.2)
                            
        addChild(lifeUI)
        addChild(shieldUI)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
