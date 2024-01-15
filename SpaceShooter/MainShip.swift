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

class MainShip: SKNode, Animate {
    
    var sprite: SKNode = SKNode()
    
    let ship: SKSpriteNode!
    let engine: SKSpriteNode!
    var engineEffect: SKSpriteNode!
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
    
    var weaponChoice: Int = 3

    var isShooting: Bool = false
    var direction: CGVector = CGVector(dx: 0.0, dy: 0.0)
    
    var shootSpeed: Double = 2.0
    var shipSpeed: Double = 1.5
    var health = 4
    var damage = 100
    var hit: Bool = false
    
    var engineLvl: Int = 0
    var engineIndex: Int = 0
    var weaponLevel: Int = 3
    var weaponIndex: Int = 0
    
    var speedStat: Double = 1
    var shootStat: Double = 1
    var bulletStat: Double = 1
    
    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
                
        self.viewSize = viewSize
        
        ship = SKSpriteNode(texture: SKTexture(imageNamed: "Full Health"), color: .white, size: SKTexture(imageNamed: "Full Health").size())
        engine = SKSpriteNode(texture: SKTexture(imageNamed: engineList[engineIndex]), color: .white, size: SKTexture(imageNamed: engineList[engineIndex]).size())
        engineEffect = SKSpriteNode(texture: SKTexture(imageNamed: engineListsMovement[engineIndex][0]), color: .white, size: CGSize(width: 48, height: 48))
        weapon = SKSpriteNode(texture: SKTexture(imageNamed: weaponList[weaponChoice]), color: .white, size: CGSize(width: 48, height: 48))
        shield = SKSpriteNode(texture: SKTexture(imageNamed: "Shield"), color: .white, size: CGSize(width: 64, height: 64))
                      
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        
        ship.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 100)
        ship.zPosition = 104
        ship.physicsBody = SKPhysicsBody(circleOfRadius: 12)
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.collisionBitMask = 0
        ship.physicsBody?.categoryBitMask = 1
        ship.physicsBody?.contactTestBitMask = 2
        ship.name = "player"
        
        engine.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 95)
        engine.zPosition = 102
        
        engineEffect.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 90)
        engineEffect.zPosition = 103
        
        weapon.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 100)
        weapon.zPosition = 102
        
        shield.position = CGPoint(x: 0, y: -(viewSize.maxY / 2) + 108)
        shield.zPosition = 104
        shield.isHidden = true
        
        shield.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: shield.size.width / 2, height: shield.size.width / 6), center: CGPoint(x: 0, y: 15))
        shield.physicsBody?.affectedByGravity = false
        shield.physicsBody?.collisionBitMask = 0
        shield.physicsBody?.categoryBitMask = 1
        shield.physicsBody?.contactTestBitMask = 2
        shield.name = "shield"
        
        ship.setScale(scale * 1.05)
        engine.setScale(scale * 1.05)
        engineEffect.setScale(scale * 1.05)
        weapon.setScale(scale * 1.05)
        shield.setScale(scale * 1.05)
        
        animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineIndex][0]), duration: 0.15, spriteWidth: 48.0)
        animateSprite(sprite: shield, spriteSheet: SKTexture(imageNamed: "Shield"), duration: 0.15, spriteWidth: 64)
        
        sprite.addChild(ship)
        sprite.addChild(engine)
        sprite.addChild(engineEffect)
        sprite.addChild(weapon)
        sprite.addChild(shield)
        
        addChild(sprite)
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
    
    func shoot() -> [Bullet] {
        managePlayerShoot(sprite: weapon, spriteSheet: SKTexture(imageNamed: weaponList[weaponChoice]), duration: 0.4, spriteWidth: 48.0)
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
    
    func canonShoot() -> [Bullet] {
        var bullets = [Bullet]()
        var x = ship.position.x - (9 * scale) - ((weaponLevel == 1 ? 0 : weaponLevel == 2 ? 6 : 12) * scale)
        var y = ship.position.y + (18 * scale)
        for _ in 0..<2 {
            for _ in 0..<weaponLevel {
                let bullet = CanonBullet(spawn: CGPoint(x: x, y: y), scale: scale, texture: bulletList[weaponChoice])
                bullets.append(bullet)
                x += (weaponLevel > 1 ? (8 * scale) : 0) * scale
            }
            x += (weaponLevel == 1 ? 19 : weaponLevel == 2 ? 4 : 3) * scale
            y -= (5 * scale)
        }
        return bullets
    }
    
    func spaceBullet() -> [Bullet] {
        var bullets = [Bullet]()
        var x = Double(ship.position.x) - Double(weaponLevel > 1 ? 4 * weaponLevel : 0) + (weaponLevel > 1 && weaponLevel < 4 ? 0 : 2)
        for _ in 0..<weaponLevel {
            let bullet = SpaceBullet(spawn: CGPoint(x: x, y: ship.position.y + (15 * scale)), scale: scale, texture: bulletList[weaponChoice])
            bullets.append(bullet)
            x += (weaponLevel > 1 ? 12 : 0) * scale
        }
        return bullets
    }
    
    func rocketBullet() -> [Bullet] {
        var bullets = [Bullet]()
        var x = ship.position.x - (11 * scale) - ((weaponLevel == 1 ? 0 : weaponLevel == 2 ? 2 : 5) * scale)
        for _ in 0..<2 {
            for _ in 0..<weaponLevel {
                let bullet = RocketBulletP(spawn: CGPoint(x: x, y: weapon.position.y + (16 * scale)), scale: scale, texture: bulletList[weaponChoice])
                bullets.append(bullet)
                x += (weaponLevel > 1 ? (5 * scale) : 0) * scale
            }
            x += (weaponLevel == 1 ? 23 : weaponLevel == 2 ? 12 : 8) * scale
        }
        return bullets
    }
    
    func zapperBullet() -> [Bullet] {
        var bullets = [Bullet]()
        var x = ship.position.x - (8 * scale) - ((weaponLevel == 1 ? 0 : weaponLevel == 2 ? 4 : 10) * scale)
        for _ in 0..<2 {
            for _ in 0..<weaponLevel {
                let bullet = ZapperBullet(spawn: CGPoint(x: x, y: weapon.position.y + (16 * scale)), scale: scale, texture: bulletList[weaponChoice])
                bullets.append(bullet)
                x += (weaponLevel > 1 ? (7 * scale) : 0) * scale
            }
            x += (weaponLevel == 1 ? 16 : weaponLevel == 2 ? 3 : 1) * scale
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
            animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineIndex][1]), duration: 0.15, spriteWidth: 48.0)
        } else if !isMoving {
            animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineIndex][0]), duration: 0.15, spriteWidth: 48.0)
        }
    }
    
    func takeDamage() {
        self.health -= 1
        self.hit = true
        
        let flashTimer = Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            self.sprite.isHidden = !self.sprite.isHidden
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            flashTimer.invalidate()
            self.sprite.isHidden = false
            self.hit = false
        }
    }
    
    func updateStat(stat: Int) {
        switch stat {
        case 0:
            engineIndex += 1
            if engineLvl != 5 {
                engineLvl += 1
                self.shipSpeed += 0.05
                speedStat += 0.4
                // Update Stat
            } else {
                engineLvl = 0
                engineIndex = engineIndex == 3 ? engineIndex : engineIndex + 1
                engine.texture = SKTexture(imageNamed: engineList[engineIndex])
                engineEffect.texture = SKTexture(imageNamed: engineListsMovement[engineIndex][0])
                animateSprite(sprite: engineEffect, spriteSheet: SKTexture(imageNamed: engineListsMovement[engineIndex][0]), duration: 0.15, spriteWidth: 48.0)
            }
        case 1:
            if shootSpeed > 0.4 {
                self.shootSpeed -= 0.1
                shootStat += 0.1
                // Update Stat
            }
        case 2:
            if weaponLevel != 3 && weaponIndex != 1 || weaponIndex == 1 && weaponLevel != 5 {
                bulletStat += 1
                // Update Stat
                weaponLevel += 1
            }
        default: break
        }
    }
    
    func activateShield() {
        self.shield.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.shield.isHidden = true
        }
    }
    
    func getHealth() -> Int {
        return self.health
    }
    
    func isHit() -> Bool {
        return self.hit
    }
    
    func getDamage() -> Int {
        return self.damage
    }
}
