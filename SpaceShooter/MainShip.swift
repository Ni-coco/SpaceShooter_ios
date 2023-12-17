//
//  MainShip.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit
import UIKit

extension CGPoint {
    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
}

class MainShip: SKNode, Ship {
    
    let ship: SKSpriteNode!
    let engine: SKSpriteNode!
    let engineEffect: SKSpriteNode!
    let weapon: SKSpriteNode!
    let shield: SKSpriteNode!
    
    let shipList: [String] = ["Full Health", "Slight Damaged", "Damaged", "Very Damaged"]
    let engineList: [String] = ["Base Engine", "Burst Engine", "Pulse Engine", "Supercharged Engine"]
    let engineListsMovement: [[String]] = [
        ["Idle Base Engine", "Move Base Engine"],
        ["Idle Burst Engine", "Move Burst Engine"],
        ["Idle Big Pulse Engine", "Move Big Pulse Engine"],
        ["Idle Supercharged Engine", "Move Supercharged Engine"]
    ]
    let weaponList: [String] = ["canonGun", "spaceGun", "rocketGun", "zapperGun"]
    let bulletList: [String] = ["canonBullet", "spaceBullet", "rocketBullet", "zapperBullet"]
    
    var engineChoice: Int = Int(arc4random_uniform(4))
    var weaponChoice: Int = Int(arc4random_uniform(4))

    var isShooting: Bool = false
    var direction: CGVector = CGVector(dx: 0.0, dy: 0.0)
    
    var shootSpeed: Double = 2.0
    var shipSpeed: Double = 1.5
    var health = 4
    
    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
                
        self.viewSize = viewSize
        
        ship = SKSpriteNode(texture: SKTexture(imageNamed: "Full Health"), color: .white, size: SKTexture(imageNamed: "Full Health").size())
        engine = SKSpriteNode(texture: SKTexture(imageNamed: engineList[engineChoice]), color: .white, size: SKTexture(imageNamed: engineList[engineChoice]).size())
        engineEffect = SKSpriteNode(texture: SKTexture(imageNamed: engineListsMovement[engineChoice][0]), color: .white, size: CGSize(width: 48, height: 48))
        weapon = SKSpriteNode(texture: SKTexture(imageNamed: weaponList[weaponChoice]), color: .white, size: CGSize(width: 48, height: 48))
        shield = SKSpriteNode(texture: SKTexture(imageNamed: "Shield"), color: .white, size: CGSize(width: 64, height: 64))
                
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        
        ship.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 100)
        ship.zPosition = 104
        
        engine.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 95)
        engine.zPosition = 102
        
        engineEffect.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 90)
        engineEffect.zPosition = 103
        
        weapon.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 100)
        weapon.zPosition = 102
        
        shield.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 108)
        shield.zPosition = 104
        shield.isHidden = true
        
        ship.setScale(scale)
        engine.setScale(scale)
        engineEffect.setScale(scale)
        weapon.setScale(scale)
        shield.setScale(scale)
        
        animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineChoice][0]), duration: 0.15, spriteWidth: 48.0)
        animateSprite(sprite: shield, spriteSheet: SKTexture(imageNamed: "Shield"), duration: 0.15, spriteWidth: 64)
                          
        addChild(ship)
        addChild(engine)
        addChild(engineEffect)
        addChild(weapon)
        addChild(shield)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveShip() {
        if (ship.position != CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)) {
            ship.position = ship.position + CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)
            engine.position = engine.position + CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)
            engineEffect.position = engineEffect.position + CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)
            weapon.position = weapon.position + CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)
            shield.position = shield.position + CGPoint(x: direction.dx * shipSpeed, y: direction.dy * shipSpeed)
        }
    }
    
    func shoot() -> [SKSpriteNode] {
        managePlayerShoot(sprite: weapon, spriteSheet: SKTexture(imageNamed: weaponList[weaponChoice]), duration: 0.6, spriteWidth: 48.0)
        switch weaponChoice {
        case 0:
            return canonShoot()
        case 1:
            return spaceBullet()
        case 2:
            return rocketBullet()
        case 3:
            return zapperBullet()
        default:
            return []
        }
    }
    
    func canonShoot() -> [SKSpriteNode] {
        var bullets = [SKSpriteNode]()
        var x = weapon.position.x - (9 * scale)
        var y = weapon.position.y + (18 * scale)
        for _ in 0..<2 {
            let bullet = SKSpriteNode(texture: SKTexture(imageNamed: bulletList[weaponChoice]), color: .white, size: CGSize(width: 16, height: 16))
            bullet.position = CGPoint(x: x, y: y)
            bullet.zPosition = 105
            bullet.setScale(scale)
            animateSprite(sprite: bullet, spriteSheet: SKTexture(imageNamed: bulletList[weaponChoice]), duration: 0.3, spriteWidth: 32)
            bullets.append(bullet)
            x += (18 * scale)
            y -= (5 * scale)
        }
        return bullets
    }
    
    func spaceBullet() -> [SKSpriteNode] {
        var bullets = [SKSpriteNode]()
        
        let bullet = SKSpriteNode(texture: SKTexture(imageNamed: bulletList[weaponChoice]), color: .white, size: CGSize(width: 16, height: 16))
        bullet.position = CGPoint(x: weapon.position.x, y: weapon.position.y + (15 * scale))
        bullet.zPosition = 105
        bullet.setScale(scale)
        animateSprite(sprite: bullet, spriteSheet: SKTexture(imageNamed: bulletList[weaponChoice]), duration: 0.3, spriteWidth: 32)
        bullets.append(bullet)
        
        return bullets
    }
    
    func rocketBullet() -> [SKSpriteNode] {
        var bullets = [SKSpriteNode]()
        var x = weapon.position.x - (10 * scale)
        for _ in 0..<2 {
            let bullet = SKSpriteNode(texture: SKTexture(imageNamed: bulletList[weaponChoice]), color: .white, size: CGSize(width: 16, height: 16))
            bullet.position = CGPoint(x: x, y: weapon.position.y + (16 * scale))
            bullet.zPosition = 105
            bullet.setScale(scale)
            animateSprite(sprite: bullet, spriteSheet: SKTexture(imageNamed: bulletList[weaponChoice]), duration: 0.3, spriteWidth: 32)
            bullets.append(bullet)
            x += (21 * scale)
        }
        return bullets
    }
    
    func zapperBullet() -> [SKSpriteNode] {
        var bullets = [SKSpriteNode]()
        var x = weapon.position.x - (8 * scale)
        for _ in 0..<2 {
            let bullet = SKSpriteNode(texture: SKTexture(imageNamed: bulletList[weaponChoice]), color: .white, size: CGSize(width: 16, height: 16))
            bullet.position = CGPoint(x: x, y: weapon.position.y + (16 * scale))
            bullet.zPosition = 105
            bullet.setScale(scale)
            animateSprite(sprite: bullet, spriteSheet: SKTexture(imageNamed: bulletList[weaponChoice]), duration: 0.3, spriteWidth: 32)
            bullets.append(bullet)
            x += (16 * scale)
        }
        return bullets
    }
    
    func managePlayerShoot(sprite: SKSpriteNode, spriteSheet: SKTexture, duration: TimeInterval, spriteWidth: CGFloat) {
        if isShooting {
            return
        }
        isShooting = true

        let frameCount = Int(spriteSheet.size().width / spriteWidth)
        var textures: [SKTexture] = []

        for index in 0..<frameCount {
            let x = CGFloat(index) * spriteWidth / spriteSheet.size().width
            let texture = SKTexture(rect: CGRect(x: x, y: 0, width: spriteWidth / spriteSheet.size().width, height: 1), in: spriteSheet)
            textures.append(texture)
        }

        let animateAction = SKAction.animate(with: textures, timePerFrame: duration / Double(frameCount))
        let sequenceAction = SKAction.sequence([animateAction])
        let completionAction = SKAction.run {
            self.setFirstSprite(sprite: self.weapon, spriteSheet: SKTexture(imageNamed: self.weaponList[self.weaponChoice]), spriteWidth: 48.0)
        }
        sprite.run(SKAction.sequence([sequenceAction, completionAction]))

        DispatchQueue.main.asyncAfter(deadline: .now() + shootSpeed) {
            self.isShooting = false
        }
    }
        
    func manageEngineEffect(isMoving: Bool) {
        if isMoving {
            animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineChoice][1]), duration: 0.15, spriteWidth: 48.0)
        } else if !isMoving {
            animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineChoice][0]), duration: 0.15, spriteWidth: 48.0)
        }
    }
}
