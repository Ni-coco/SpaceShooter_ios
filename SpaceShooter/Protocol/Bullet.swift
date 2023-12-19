//
//  Bullet.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 18/12/2023.
//

import SpriteKit

protocol Bullet: AnyObject {
    var bulletSprite: SKSpriteNode! { get set }
    
    func updateMovement()
}

extension Bullet {
}
