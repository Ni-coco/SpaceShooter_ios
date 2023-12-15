//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let background = Background()
    let player = MainShip()
    let ui = DisplayUI()
    let fighter = Fighter()
    
    var playerBullets = [SKSpriteNode]()
        
    override func didMove(to view: SKView) {
        addChild(player)
//        addChild(ui)
        addChild(fighter)
        addBackground()
    }
    
    func addBackground() {
        addChild(background)
        background.scaleToSceneSize()
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    var lastTouches = [UITouch]()

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.manageEngineEffect(isMoving: true)
        lastTouches.append(touches.first!)
        updateDirection()
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        updateDirection()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let index = lastTouches.firstIndex(of: touch) {
                lastTouches.remove(at: index)
                updateDirection()
            }
        }
        if (lastTouches.isEmpty) {
            player.manageEngineEffect(isMoving: false)
            player.direction = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    func updateDirection() {
        guard let touch = lastTouches.last else { return }
        let touchLocation = touch.location(in: self)
        
        let direction = CGVector(dx: touchLocation.x - player.ship.position.x,
                                 dy: touchLocation.y - player.ship.position.y)
        
        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
        
        if length > 0 {
            player.direction = CGVector(dx: direction.dx / length, dy: direction.dy / length)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        background.updateBackground()
        updatePlayer()
    }
    
    func updatePlayer() {
        player.moveShip()
        updatePlayerShoot()
    }
    
    func updatePlayerShoot() {
        var bulletsToRemove = [SKSpriteNode]()

        if !player.isShooting {
            let bulletsToAdd = player.shoot()
            for bullet in bulletsToAdd {
                addChild(bullet)
                playerBullets.append(bullet)
            }
        }
        
        for bullet in playerBullets {
            bullet.position.y += 3
            if bullet.position.y > UIScreen.main.bounds.height {
                bulletsToRemove.append(bullet)
            }
        }

        for bullet in bulletsToRemove {
            bullet.removeFromParent()
            if let index = playerBullets.firstIndex(of: bullet) {
                playerBullets.remove(at: index)
            }
        }
    }
}
