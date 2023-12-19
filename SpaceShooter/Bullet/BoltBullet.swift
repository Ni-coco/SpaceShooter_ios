//
//  BoltBullet.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 19/12/2023.
//

import SpriteKit

class BoltBullet : Bullet, Animate {
    var bulletSprite: SKSpriteNode!
    
    init(spawn: CGPoint, scale: CGFloat) {
        
        bulletSprite = SKSpriteNode(texture: SKTexture(imageNamed: "boltBullet"), color: .white, size: CGSize(width: 12, height: 12))
        bulletSprite.position = CGPoint(x: spawn.x, y: spawn.y)
        bulletSprite.zPosition = 106
        bulletSprite.setScale(scale / 1.1)
        bulletSprite.zRotation = .pi
        animateSprite(sprite: bulletSprite, spriteSheet: SKTexture(imageNamed: "boltBullet"), duration: 0.15, spriteWidth: 9)
    }
    
    func updateMovement() {
        bulletSprite.position.y -= 1.5
    }
}
