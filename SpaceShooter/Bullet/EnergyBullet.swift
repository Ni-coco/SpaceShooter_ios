//
//  EnergyBullet.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 18/12/2023.
//

import SpriteKit

class EnergyBullet : Bullet, Animate {
    var bulletSprite: SKSpriteNode!
    
    var xMove = CGFloat()
    var yMove = CGFloat()
    var random = Int()
    var scenario = Int()
    var pattern = String()
    
    init(spawn: CGPoint, scale: CGFloat, pattern: String, scenario: Int) {
        self.scenario = scenario
        self.pattern = pattern
        
        self.xMove = CGFloat(arc4random_uniform(2))
        self.yMove = CGFloat(arc4random_uniform(2))
        self.random = Int(arc4random_uniform(2))
        
        bulletSprite = SKSpriteNode(texture: SKTexture(imageNamed: "Ball"), color: .white, size: CGSize(width: 32, height: 32))
        bulletSprite.position = CGPoint(x: spawn.x, y: spawn.y)
        bulletSprite.zPosition = 106
        bulletSprite.setScale(scale / 1.42)
        bulletSprite.physicsBody = SKPhysicsBody(circleOfRadius: 6)
        bulletSprite.physicsBody?.affectedByGravity = false
        bulletSprite.physicsBody?.collisionBitMask = 0
        bulletSprite.name = "enemyBullet"
        animateSprite(sprite: bulletSprite, spriteSheet: SKTexture(imageNamed: "Ball"), duration: 0.15, spriteWidth: 32)
    }
    
    func updateMovement() {
        if xMove == 0 && yMove == 0 {
            yMove = 1.2
        }
        
        let xPosition = bulletSprite.position.x
        let yPosition = bulletSprite.position.y
                
        if scenario == 0 {
            switch pattern {
            case "left":
                bulletSprite.position.x = xPosition - 1.2
            case "up":
                bulletSprite.position.y = yPosition - 1.2
            case "right":
                bulletSprite.position.x = xPosition + 1.2
            case "down":
                bulletSprite.position.y = yPosition + 1.2
            case "left up":
                bulletSprite.position.x = xPosition - 1.2
                bulletSprite.position.y = yPosition - 1.2
            case "left down":
                bulletSprite.position.x = xPosition - 1.2
                bulletSprite.position.y = yPosition + 1.2
            case "right up":
                bulletSprite.position.x = xPosition + 1.2
                bulletSprite.position.y = yPosition - 1.2
            case "right down":
                bulletSprite.position.x = xPosition + 1.2
                bulletSprite.position.y = yPosition + 1.2
            default:
                return
            }
        }
        else if scenario == 1 {
            switch pattern {
            case "left", "up", "right", "down":
                bulletSprite.position.y = yPosition - 1.2
            case "left up":
                bulletSprite.position.x = xPosition - 1.2
                bulletSprite.position.y = yPosition - 1.2
            case "left down":
                bulletSprite.position.x = xPosition - 1.2
                bulletSprite.position.y = yPosition + 1.2
            case "right up":
                bulletSprite.position.x = xPosition + 1.2
                bulletSprite.position.y = yPosition - 1.2
            case "right down":
                bulletSprite.position.x = xPosition + 1.2
                bulletSprite.position.y = yPosition + 1.2
            default:
                return
            }
        }
        else {
            bulletSprite.position.x = random == 0 ? xPosition + xMove : xPosition - xMove
            bulletSprite.position.y = random == 0 ? yPosition + yMove : yPosition - yMove
        }
    }
}
