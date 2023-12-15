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
    
    let sceneSize: CGSize

    init(sceneSize: CGSize) {
        
        self.sceneSize = sceneSize

        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"))
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"))
        
        super.init()
        
        lifeUI.position = CGPoint(x: -(self.sceneSize.width / 2) + 150, y: -(self.sceneSize.height / 2) + 100)
        lifeUI.zPosition = 1
        lifeUI.setScale(1.2)
        
        shieldUI.position = CGPoint(x: -(self.sceneSize.width / 2) + 150, y: -(self.sceneSize.height / 2) + 70)
        shieldUI.zPosition = 1
        shieldUI.setScale(1.2)
                            
        addChild(lifeUI)
        addChild(shieldUI)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
