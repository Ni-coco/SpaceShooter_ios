//
//  Bullet.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 18/12/2023.
//

import SpriteKit

protocol Bullet: AnyObject {
    var bulletSprite: SKSpriteNode! { get set }
    var isRemovable: Bool { get set }
    
    func updateMovement()
    func targetHit()
}

extension Bullet {
    var isRemovable: Bool {
        get { return isRemovable }
        set { isRemovable = false }
    }
        
    func targetHit() {
        let spriteSheet = SKTexture(imageNamed: "bulletTouch")
        let spriteWidth: CGFloat = 30
        
        let frameCount = Int(spriteSheet.size().width / spriteWidth)
        var textures: [SKTexture] = []

        for index in 0..<frameCount {
            let x = CGFloat(index) * spriteWidth / spriteSheet.size().width
            let texture = SKTexture(rect: CGRect(x: x, y: 0, width: spriteWidth / spriteSheet.size().width, height: 1), in: spriteSheet)
            textures.append(texture)
        }
        
        let animateAction = SKAction.animate(with: textures, timePerFrame: 0.2)
        let completionAction = SKAction.run {
            self.bulletSprite.removeFromParent()
        }
        
        let sequence = SKAction.sequence([animateAction, completionAction])
        bulletSprite.run(sequence)
    }
}
