//
//  Fighter.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Fighter: SKNode, Animate, Enemies {
    
    var canShoot: Bool = true

    var ship: SKSpriteNode!
    var engine: SKSpriteNode!
    var destruction: SKSpriteNode!
    
    //Enemies protocol
    var spriteList: [SKSpriteNode] = []
    var viewSize: CGRect
    var spawn: CGPoint = CGPoint()
    var moving: CGPoint = CGPoint()
    var shipSize: CGSize = CGSize()
    var scale: CGFloat = 0
    var shipSpeed: CGFloat = 1
    var health: Int = 5
    
    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "FighterWeapon"), color: .white, size: CGSize(width: 64, height: 64))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "FighterEngine"), color: .white, size: CGSize(width: 64, height: 64))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "FighterDestruction"), color: .white, size: CGSize(width: 64, height: 64))
        
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        shipSize = CGSize(width: ship.size.width / 2, height: ship.size.height)
        spawn = generateSpawn()
        moving = generateDestination()

        ship.position = CGPoint(x: spawn.x, y: spawn.y)
        ship.zPosition = 14
        ship.setScale(scale)
        ship.zRotation = .pi
        ship.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.collisionBitMask = 0
        ship.physicsBody?.categoryBitMask = 2
        ship.physicsBody?.contactTestBitMask = 1
        ship.name = "enemy"

        engine.position = CGPoint(x: spawn.x, y: spawn.y)
        engine.zPosition = 14
        engine.setScale(scale)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: spawn.x, y: spawn.y)
        destruction.zPosition = 14
        destruction.setScale(scale)
        destruction.isHidden = true
        destruction.zRotation = .pi
        
        setFirstSprite(sprite: ship, spriteSheet: SKTexture(imageNamed: "FighterWeapon"), spriteWidth: 64.0)
        animateSprite(sprite: engine, spriteSheet: SKTexture(imageNamed: "FighterEngine"), duration: 0.15, spriteWidth: 64.0)
        
        spriteList.append(ship)
        spriteList.append(engine)
        spriteList.append(destruction)
        
        addChild(ship)
        addChild(engine)
        addChild(destruction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot() -> [Bullet] {
        if canShoot && getHealth() > 0 && Int(arc4random_uniform(200)) == 0 {
            return rocketShoot()
        }
        return []
    }
    
    func rocketShoot() -> [Bullet] {
        animateOnce(sprite: ship, spriteSheet: SKTexture(imageNamed: "FighterWeapon"), duration: 0.15, spriteWidth: 64)
        canShoot = false
        
        var xPosition: CGFloat = ship.position.x - 11
        var yPosition: CGFloat = ship.position.y
        
        var bulletsToAdd: [Bullet] = []
        for _ in 0..<2 {
            let rocketBullet = RocketBullet(spawn: CGPoint(x: xPosition, y: yPosition), scale: scale)
            bulletsToAdd.append(rocketBullet)
            xPosition += 23
            yPosition += 5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.canShoot = true
        }
        return bulletsToAdd
    }
}
