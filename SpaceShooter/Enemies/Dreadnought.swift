//
//  Dreadnought.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Dreadnought: SKNode, Ship, Enemies {
    
    var ship: SKSpriteNode!
    var engine: SKSpriteNode!
    var destruction: SKSpriteNode!
    
    //Enemies protocol
    var viewSize: CGRect
    var spawn: CGPoint = CGPoint()
    var moving: CGPoint = CGPoint()
    var shipSize: CGSize = CGSize()
    var scale: CGFloat = 0
    var shipSpeed: CGFloat = 0.6

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtWeapon"), color: .white, size: CGSize(width: 128, height: 128))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtEngine"), color: .white, size: CGSize(width: 128, height: 128))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtDestruction"), color: .white, size: CGSize(width: 128, height: 128))
        
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        shipSize = CGSize(width: ship.size.width / 2, height: ship.size.height)
        spawn = generateSpawn()
        moving = generateDestination()
        
        ship.position = CGPoint(x: spawn.x, y: spawn.y)
        ship.zPosition = 11
        ship.setScale(scale * 1.2)
        ship.zRotation = .pi
        
        engine.position = CGPoint(x: spawn.x, y: spawn.y)
        engine.zPosition = 10
        engine.setScale(scale * 1.2)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: spawn.x, y: spawn.y)
        destruction.zPosition = 10
        destruction.setScale(scale * 1.2)
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
