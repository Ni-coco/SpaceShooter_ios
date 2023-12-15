//
//  Fighter.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Fighter: SKNode, Ship {
    
    let ship: SKSpriteNode!
    let engine: SKSpriteNode!
    let destruction: SKSpriteNode!
    
    let screenSize = UIScreen.main.bounds
    
    override init() {
        ship = SKSpriteNode(texture: SKTexture(imageNamed: "FighterWeapon"), color: .white, size: CGSize(width: 64, height: 64))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "FighterEngine"), color: .white, size: CGSize(width: 64, height: 64))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "FighterDestruction"), color: .white, size: CGSize(width: 64, height: 64))
        
        super.init()
        
        ship.position = CGPoint(x: 0, y: 0)
        ship.zPosition = 2
        ship.setScale(1.8)
        ship.zRotation = .pi
        
        engine.position = CGPoint(x: 0, y: 2)
        engine.zPosition = 1
        engine.setScale(1.8)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: 0, y: 0)
        destruction.zPosition = 2
        destruction.setScale(1.8)
        destruction.isHidden = true
        destruction.zRotation = .pi
        
        setFirstSprite(sprite: ship, spriteSheet: SKTexture(imageNamed: "FighterWeapon"), spriteWidth: 64.0)
        animateSprite(sprite: engine, spriteSheet: SKTexture(imageNamed: "FighterEngine"), duration: 0.15, spriteWidth: 64.0)
        
        addChild(ship)
        addChild(engine)
        addChild(destruction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
