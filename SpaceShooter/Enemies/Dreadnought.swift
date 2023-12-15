//
//  Dreadnought.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Dreadnought: SKNode, Ship, Enemies {
    
    let ship: SKSpriteNode!
    let engine: SKSpriteNode!
    let destruction: SKSpriteNode!
    
    let sceneSize: CGSize

    init(sceneSize: CGSize) {
        
        self.sceneSize = sceneSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtWeapon"), color: .white, size: CGSize(width: 128, height: 128))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtEngine"), color: .white, size: CGSize(width: 128, height: 128))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtDestruction"), color: .white, size: CGSize(width: 128, height: 128))
        
        super.init()
        
        ship.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 160)
        ship.zPosition = 2
        ship.setScale(2)
        ship.zRotation = .pi
        
        engine.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 160)
        engine.zPosition = 1
        engine.setScale(2)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 160)
        destruction.zPosition = 2
        destruction.setScale(2)
        destruction.isHidden = true
        destruction.zRotation = .pi
        
        setFirstSprite(sprite: ship, spriteSheet: SKTexture(imageNamed: "DreadnoughtWeapon"), spriteWidth: 128)
        animateSprite(sprite: engine, spriteSheet: SKTexture(imageNamed: "DreadnoughtEngine"), duration: 0.15, spriteWidth: 128.0)
        
        addChild(ship)
        addChild(engine)
        addChild(destruction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
