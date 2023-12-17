//
//  Frigate.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Frigate: SKNode, Ship, Enemies {
    
    var ship: SKSpriteNode!
    var engine: SKSpriteNode!
    var destruction: SKSpriteNode!
    
    //Enemies protocol
    var viewSize: CGRect
    var spawn: CGPoint = CGPoint()
    var moving: CGPoint = CGPoint()
    var shipSize: CGSize = CGSize()
    var scale: CGFloat = 0
    var shipSpeed: CGFloat = 0.8

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateWeapon"), color: .white, size: CGSize(width: 64, height: 64))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateEngine"), color: .white, size: CGSize(width: 64, height: 64))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "FrigateDestruction"), color: .white, size: CGSize(width: 64, height: 64))
        
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        shipSize = CGSize(width: ship.size.width / 2, height: ship.size.height)
        spawn = generateSpawn()
        moving = generateDestination()
        
        ship.position = CGPoint(x: spawn.x, y: spawn.y)
        ship.zPosition = 12
        ship.setScale(scale)
        ship.zRotation = .pi
        
        engine.position = CGPoint(x: spawn.x, y: spawn.y)
        engine.zPosition = 12
        engine.setScale(scale)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: spawn.x, y: spawn.y)
        destruction.zPosition = 12
        destruction.setScale(scale)
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
