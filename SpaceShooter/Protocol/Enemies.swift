//
//  Enemies.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

protocol Enemies: AnyObject, Animate {
    
    var spriteList: [SKSpriteNode] { get set }
    var health: Int { get set }
    var viewSize: CGRect { get set }
    var moving: CGPoint { get set }
    var shipSize: CGSize { get set }
    var shipSpeed: CGFloat { get set }
    
    func updateMovement()
    func generateDestination() -> CGPoint
    func generateSpawn() -> CGPoint
    func checkSize() -> Bool
    func shoot() -> [Bullet]
    func getHealth() -> Int
    func takeDamage(damage: Int)
    func isKilled()
    func rayIsActive() -> Bool
}

extension Enemies {

    func updateMovement() {
        
        let deltaX: CGFloat = moving.x - spriteList[0].position.x
        let deltaY: CGFloat = moving.y - spriteList[0].position.y
        let distance: CGFloat = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        if distance < 1.0 {
            moving = generateDestination()
        }
        
        let directionX = deltaX / distance
        let directionY = deltaY / distance
        
        for sprite in spriteList {
            sprite.position = CGPoint(x: sprite.position.x + directionX * shipSpeed, y: sprite.position.y + directionY * shipSpeed)
        }
    }
    
    func generateSpawn() -> CGPoint {
        
        if checkSize() {
            return CGPoint()
        }
        
        let x = CGFloat(Float.random(in: Float(-(viewSize.width / 2) + shipSize.width)...Float((viewSize.width / 2) - shipSize.width)))
        let y = CGFloat((viewSize.height / 2) + shipSize.height)
        return CGPoint(x: x, y: y)
    }

    func generateDestination() -> CGPoint {
        
        if checkSize() {
            return CGPoint()
        }

        let x = CGFloat(Float.random(in: Float(-(viewSize.width / 2) + shipSize.width)...Float((viewSize.width / 2) - shipSize.width)))
        let y = CGFloat(Float.random(in: -60...Float((viewSize.height / 2) - shipSize.height)))
        return CGPoint(x: x, y: y)
    }
    
    func checkSize() -> Bool {
        return (-(viewSize.width / 2) + shipSize.width > (viewSize.width / 2) - shipSize.width || -60 > (viewSize.height / 2) - shipSize.height)
    }
    
    func getHealth() -> Int {
        return health
    }
    
    func takeDamage(damage: Int) {
        self.health -= damage
    }
    
    func rayIsActive() -> Bool {
        return false
    }
}
