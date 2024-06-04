//
//  Background.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit

class Background: SKNode {
    
    let bg1: SKSpriteNode!
    let bg2: SKSpriteNode!
    
    override init() {
        let texture = SKTexture(imageNamed: "background")
        bg1 = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        bg1.position = CGPoint(x: 0, y: 0)
        
        bg2 = SKSpriteNode(texture: texture, color: .white, size: texture.size())
        
        bg1.zPosition = -1
        bg2.zPosition = -1
        
        super.init()
        
        addChild(bg1)
        addChild(bg2)
    }
    
    func scaleToSceneSize() {
        if let scene = scene {
            let scaleX = scene.size.width / bg1.size.width
            let scaleY = scene.size.height / bg1.size.height
            bg1.setScale(max(scaleX, scaleY))
            bg2.setScale(max(scaleX, scaleY))

            // Position the second background node just above the first one
            bg2.position = CGPoint(x: 0, y: bg1.size.height)
        }
    }

    func updateBackground() {
        bg1.position.y -= 1
        bg2.position.y -= 1
    
        if (bg1.position.y <= -bg1.size.height) {
            bg1.position.y = bg1.size.height - 5
        } else if (bg2.position.y <= -bg2.size.height) {
            bg2.position.y = bg1.size.height - 5
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
