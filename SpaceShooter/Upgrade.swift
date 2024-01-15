//
//  Upgrade.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/01/2024.
//

import SpriteKit

class Upgrade: SKNode {
    
    let spawn: CGPoint
    let viewSize: CGRect
    var upgradeSprite: SKSpriteNode
    
    let shipList: [String] = ["Speed", "Bullet", "PowerUp"]
    
    var bonusIndex: Int = (Double(arc4random_uniform(100)) / 100.0 < 0.6 ? 0 : (Double(arc4random_uniform(100)) / 100.0 < 0.9 ? 1 : 2))
    
    init(viewSize: CGRect, spawn: CGPoint) {
        
        self.viewSize = viewSize
        self.spawn = spawn
        
        upgradeSprite = SKSpriteNode(imageNamed: shipList[bonusIndex])
        
        super.init()
        
        upgradeSprite.position = CGPoint(x: spawn.x, y: spawn.y)
        upgradeSprite.zPosition = 101
        upgradeSprite.setScale(1)
        
        upgradeSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: upgradeSprite.size.width / 1.2, height: upgradeSprite.size.width / 1.4))
        upgradeSprite.physicsBody?.affectedByGravity = false
        upgradeSprite.physicsBody?.collisionBitMask = 0
        upgradeSprite.physicsBody?.categoryBitMask = 2
        upgradeSprite.physicsBody?.contactTestBitMask = 1
        upgradeSprite.name = "upgrade"
        
        addChild(upgradeSprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMove() {
        upgradeSprite.position.y = upgradeSprite.position.y - 0.8
    }
    
    func getBonusIndex() -> Int {
        return self.bonusIndex
    }
    
}
