//
//  GameScene.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 13/12/2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewSize: CGRect = CGRect()
    
    let background = Background()
    
    var scenario: Scenario?
    
    var player: MainShip?
    var ui: DisplayUI?
    
    var playerBullets = [Bullet]()
    var enemiesBullets = [Bullet]()
    var enemies = [Enemies]()
    var enemiesCount = 0
            
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        viewSize = view.frame
        
        addBackground()
        
        scenario = Scenario(viewSize: viewSize)
        
        player = MainShip(viewSize: viewSize)
        ui = DisplayUI(viewSize: viewSize)
        
        addChild(player!)
        addChild(ui!)
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
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = atPoint(location)

            if (touchedNode == ui!.shieldBtn || touchedNode == ui!.shieldText) && ui!.shieldAvailable() {
                player!.activateShield()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    for enemy in self.enemies {
                        if let dreadnought = enemy as? Dreadnought {
                            dreadnought.reloadPhysicsBody()
                            enemy.rayShield = false
                        }
                    }
                }
                ui!.manageShieldUI()
            } else {
                player!.manageEngineEffect(isMoving: true)
                lastTouches.append(touches.first!)
                updateDirection()
            }
        }
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
        updateScenario()
        updateUI()
    }
    
    func updatePlayer() {
        player!.moveShip()
        if !player!.isShooting && !player!.isHit() {
            let bulletsToAdd = player!.shoot()
            for bullet in bulletsToAdd {
                addChild(bullet.bulletSprite)
                playerBullets.append(bullet)
            }
        }
        
        playerBullets.removeAll() { bullet in
            if isOut(position: bullet.bulletSprite.position) {
                bullet.bulletSprite.removeFromParent()
                return true
            }
            bullet.bulletSprite.position.y += 2
            return false
        }
    }
    
    func updateEnemies() {
        enemies.removeAll { enemy in
            if enemy.getHealth() < 1 {
                enemy.isKilled()
                enemiesCount -= 1
                return true
            }
            enemy.updateMovement()
            let bullets = enemy.shoot()
            if let dreadnought = enemy as? Dreadnought {
                dreadnought.setShieldPosition(shieldPos: player!.shield.position.y)
            }
            if !bullets.isEmpty {
                for bullet in bullets {
                    enemiesBullets.append(bullet)
                    addChild(bullet.bulletSprite)
                }
            }
            return false
        }
        
        enemiesBullets.removeAll { bullet in
            if isOut(position: bullet.bulletSprite.position) {
                bullet.bulletSprite.removeFromParent()
                return true // Remove this bullet from the array
            }
            bullet.updateMovement()
            return false // Keep this bullet in the array
        }
    }
    
    func updateScenario() {
        if enemiesCount == 0 {
            enemiesCount = 99
            ui!.displayWave(wave: scenario!.getWave())
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.enemiesCount = 0
                for enemy in self.scenario!.getLevel() {
                    self.enemies.append(enemy)
                    self.addChild(enemy as! SKNode)
                    self.enemiesCount += 1
                }
            }
        }
    }
    
    func updateUI() {
        ui!.reloadTimer()
    }
    
    func isOut(position: CGPoint) -> Bool {
        if position.x > viewSize.width / 2 || position.x < -(viewSize.width / 2) {
            return true
        } else if position.y > viewSize.height / 2 || position.y < -(viewSize.height / 2) {
            return true
        }
        return false
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "shield" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else if contact.bodyA.node?.name == "player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else if contact.bodyA.node?.name == "enemy" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else if contact.bodyA.node?.name == "enemyRay" {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if player!.shield.isHidden == false && firstBody.node?.name == "shield" && (secondBody.node?.name == "enemyBullet" || secondBody.node?.name == "enemyRay") {
            if secondBody.node?.name == "enemyBullet" {
                enemiesBullets.removeAll() { bullet in
                    if bullet.bulletSprite == secondBody.node {
                        bullet.targetHit()
                        return true
                    }
                    return false
                }
            } else if secondBody.node?.name == "enemyRay" {
                for enemy in enemies {
                    if enemy.spriteList[1] == secondBody.node && enemy.rayIsActive() && !(player!.ship.position.y > enemy.spriteList[1].position.y) {
                        enemy.rayShield = true
                    }
                }
            }
        }
        else if firstBody.node?.name == "player" && !player!.isHit() && (secondBody.node?.name == "enemy" || secondBody.node?.name == "enemyBullet" || secondBody.node?.name == "enemyRay") {
            if secondBody.node?.name != "enemyRay" {
                player!.takeDamage()
                ui!.setLifeUI(index: player!.getHealth())
                if secondBody.node?.name == "enemyBullet" {
                    enemiesBullets.removeAll() { bullet in
                        if bullet.bulletSprite == secondBody.node {
                            bullet.targetHit()
                            return true
                        }
                        return false
                    }
                }
            }
            else if player!.shield.isHidden == true || player!.shield.isHidden == false {
                for enemy in enemies {
                    if enemy.spriteList[1] == secondBody.node && !(player!.ship.position.y > enemy.spriteList[1].position.y) {
                        
                        if enemy.rayIsActive() && player!.shield.isHidden == true {
                            player!.takeDamage()
                            ui!.setLifeUI(index: player!.getHealth())
                        }
                        else if !enemy.rayIsActive() {
                            if let dreadnought = enemy as? Dreadnought {
                                dreadnought.reloadPhysicsBody()
                            }
                        }
                    }
                }
            }
        }
        else if firstBody.node?.name == "enemy" && secondBody.node?.name == "playerBullet" {
            for enemy in enemies {
                if enemy.spriteList[0] == firstBody.node {
                    enemy.takeDamage(damage: 1)
                }
            }
            playerBullets.removeAll() { bullet in
                if bullet.bulletSprite == secondBody.node {
                    bullet.targetHit()
                    return true
                }
                return false
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()

        if contact.bodyA.node?.name == "shield" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }

        if firstBody.node?.name == "shield" && secondBody.node?.name == "enemyRay" {
            for enemy in enemies {
                if enemy.spriteList[1] == secondBody.node {
                    enemy.rayShield = false
                }
            }
        }
    }

}
