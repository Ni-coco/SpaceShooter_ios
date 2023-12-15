//
//  Frigate.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Frigate: SKNode, Ship, Enemies {
    
    let ship: SKSpriteNode!
    let engine: SKSpriteNode!
    let destruction: SKSpriteNode!
    
    let sceneSize: CGSize

    init(sceneSize: CGSize) {
        
        self.sceneSize = sceneSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateWeapon"), color: .white, size: CGSize(width: 64, height: 64))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateEngine"), color: .white, size: CGSize(width: 64, height: 64))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateDestruction"), color: .white, size: CGSize(width: 64, height: 64))
        
        super.init()
        
        ship.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 140)
        ship.zPosition = 2
        ship.setScale(1.8)
        ship.zRotation = .pi
        
        engine.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 140)
        engine.zPosition = 1
        engine.setScale(1.8)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: 0, y: self.sceneSize.height / 2 - 140)
        destruction.zPosition = 2
        destruction.setScale(1.8)
        destruction.isHidden = true
        destruction.zRotation = .pi
        
        setFirstSprite(sprite: ship, spriteSheet: SKTexture(imageNamed: "FrigateWeapon"), spriteWidth: 64.0)
        animateSprite(sprite: engine, spriteSheet: SKTexture(imageNamed: "FrigateEngine"), duration: 0.15, spriteWidth: 64.0)
        
        addChild(ship)
        addChild(engine)
        addChild(destruction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
