//
//  RocketBullet.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 19/12/2023.
//

import SpriteKit

class RocketBullet : Bullet, Animate {
    var bulletSprite: SKSpriteNode!
    
    init(spawn: CGPoint, scale: CGFloat) {
        
        bulletSprite = SKSpriteNode(texture: SKTexture(imageNamed: "rocketEnemy"), color: .white, size: CGSize(width: 12, height: 18))
        bulletSprite.position = CGPoint(x: spawn.x, y: spawn.y)
        bulletSprite.zPosition = 106
        bulletSprite.setScale(scale / 1)
        bulletSprite.zRotation = .pi
        bulletSprite.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        bulletSprite.physicsBody?.affectedByGravity = false
        bulletSprite.physicsBody?.collisionBitMask = 0
        bulletSprite.name = "enemyBullet"
        animateSprite(sprite: bulletSprite, spriteSheet: SKTexture(imageNamed: "rocketEnemy"), duration: 0.15, spriteWidth: 9)
    }
    
    func updateMovement() {
        bulletSprite.position.y -= 1.5
    }
}
