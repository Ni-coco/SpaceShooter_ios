//
//  RocketBulletP.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 26/12/2023.
//

import SpriteKit

class RocketBulletP : Bullet, Animate {
    var bulletSprite: SKSpriteNode!
    
    init(spawn: CGPoint, scale: CGFloat, texture: String) {
        
        bulletSprite = SKSpriteNode(texture: SKTexture(imageNamed: texture), color: .white, size: CGSize(width: 16, height: 16))
        bulletSprite.position = CGPoint(x: spawn.x, y: spawn.y)
        bulletSprite.zPosition = 105
        bulletSprite.setScale(scale * 1.4)
        bulletSprite.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        bulletSprite.physicsBody?.affectedByGravity = false
        bulletSprite.physicsBody?.collisionBitMask = 0
        bulletSprite.name = "playerBullet"
        animateSprite(sprite: bulletSprite, spriteSheet: SKTexture(imageNamed: texture), duration: 0.15, spriteWidth: 32)
    }
    
    func updateMovement() {}
}
