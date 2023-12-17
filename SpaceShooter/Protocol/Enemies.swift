//
//  Enemies.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

protocol Enemies: AnyObject {
    
    var ship: SKSpriteNode! { get set }
    var engine: SKSpriteNode! { get set }
    var destruction: SKSpriteNode! { get set }
    
    var viewSize: CGRect { get set }
    var moving: CGPoint { get set }
    var shipSize: CGSize { get set }
    var shipSpeed: CGFloat { get set }
    
    func updateMovement()
    func generateDestination() -> CGPoint
    func generateSpawn() -> CGPoint
    func checkSize() -> Bool
}

extension Enemies {

    func updateMovement() {
        let deltaX: CGFloat = moving.x - ship.position.x
        let deltaY: CGFloat = moving.y - ship.position.y
        let distance: CGFloat = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        if distance < 1.0 {
            moving = generateDestination()
        }
        
        let directionX = deltaX / distance
        let directionY = deltaY / distance
        
        ship.position = CGPoint(x: ship.position.x + directionX * shipSpeed, y: ship.position.y + directionY * shipSpeed)
        engine.position = CGPoint(x: engine.position.x + directionX * shipSpeed, y: engine.position.y + directionY * shipSpeed)
        destruction.position = CGPoint(x: destruction.position.x + directionX * shipSpeed, y: destruction.position.y + directionY * shipSpeed)
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
}
