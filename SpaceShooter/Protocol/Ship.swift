//
//  Ship.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit

protocol Ship {
}

extension Ship {
    
    func animateSprite(sprite: SKSpriteNode, spriteSheet: SKTexture, duration: TimeInterval, spriteWidth: CGFloat) {
        let frameCount = Int(spriteSheet.size().width / spriteWidth)
        var textures: [SKTexture] = []

        for index in 0..<frameCount {
            let x = CGFloat(index) * spriteWidth / spriteSheet.size().width
            let texture = SKTexture(rect: CGRect(x: x, y: 0, width: spriteWidth / spriteSheet.size().width, height: 1), in: spriteSheet)
            textures.append(texture)
        }
        
        let animateAction = SKAction.animate(with: textures, timePerFrame: duration)
        let repeatForever = SKAction.repeatForever(animateAction)
        sprite.run(repeatForever)
    }
    
    func setFirstSprite(sprite: SKSpriteNode, spriteSheet: SKTexture, spriteWidth: CGFloat) {
        let firstTexture = SKTexture(rect: CGRect(x: 0, y: 0, width: spriteWidth / spriteSheet.size().width, height: 1), in: spriteSheet)
        sprite.texture = firstTexture
    }
    
    func getScale(sceneSize: CGRect) -> CGFloat {
        let screenHeight = max(sceneSize.height, sceneSize.width)  // Use the larger dimension as a reference
        return (screenHeight / 844)  // Adjust this factor as needed
    }
}
