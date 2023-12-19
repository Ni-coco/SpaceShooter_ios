//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var viewSize: CGRect = CGRect()
    
    let background = Background()
    
    var player: MainShip?
    var ui: DisplayUI?
    var fighter: Fighter?
    var scout: Scout?
    var frigate: Frigate?
    var dreadnought: Dreadnought?
    
    var playerBullets = [SKSpriteNode]()
    var enemiesBullets = [Bullet]()
    var enemies = [Enemies]()
            
    override func didMove(to view: SKView) {
        
        viewSize = view.frame
        
        addBackground()

        player = MainShip(viewSize: viewSize)
        ui = DisplayUI(viewSize: viewSize)
        fighter = Fighter(viewSize: viewSize)
        scout = Scout(viewSize: viewSize)
        frigate = Frigate(viewSize: viewSize)
        dreadnought = Dreadnought(viewSize: viewSize)
        
        addChild(player!)
        addChild(ui!)
        addChild(fighter!)
        addChild(scout!)
        addChild(frigate!)
        addChild(dreadnought!)
        
        enemies.append(fighter!)
        enemies.append(scout!)
        enemies.append(frigate!)
        enemies.append(dreadnought!)
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
        player!.manageEngineEffect(isMoving: true)
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
            player!.manageEngineEffect(isMoving: false)
            player!.direction = CGVector(dx: 0.0, dy: 0.0)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    func updateDirection() {
        guard let touch = lastTouches.last else { return }
        let touchLocation = touch.location(in: self)
        
        let direction = CGVector(dx: touchLocation.x - player!.ship.position.x,
                                 dy: touchLocation.y - player!.ship.position.y)
        
        let length = sqrt(direction.dx * direction.dx + direction.dy * direction.dy)
        
        if length > 0 {
            player!.direction = CGVector(dx: direction.dx / length, dy: direction.dy / length)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        background.updateBackground()
        updatePlayer()
        updateEnemies()
    }
    
    func updatePlayer() {
        player!.moveShip()
        if !player!.isShooting {
            let bulletsToAdd = player!.shoot()
            for bullet in bulletsToAdd {
                addChild(bullet)
                playerBullets.append(bullet)
            }
        }
        
        playerBullets.removeAll() { bullet in
            if isOut(position: bullet.position) {
                bullet.removeFromParent()
                return true
            } else {
                bullet.position.y += 2
                return false
            }
        }
    }
    
    func updateEnemies() {
        for enemy in enemies {
            enemy.updateMovement()
            let bullets = enemy.shoot()
            if !bullets.isEmpty {
                for bullet in bullets {
                    enemiesBullets.append(bullet)
                    addChild(bullet.bulletSprite)
                }
            }
        }
        
        enemiesBullets.removeAll { bullet in
            if isOut(position: bullet.bulletSprite.position) {
                bullet.bulletSprite.removeFromParent()
                return true // Remove this bullet from the array
            } else {
                bullet.updateMovement()
                return false // Keep this bullet in the array
            }
        }
    }
    
    func isOut(position: CGPoint) -> Bool {
        if position.x > viewSize.width / 2 || position.x < -(viewSize.width / 2) {
            return true
        } else if position.y > viewSize.height / 2 || position.y < -(viewSize.height / 2) {
            return true
        }
        return false
    }
}
