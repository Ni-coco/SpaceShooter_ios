//
//  Dreadnought.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit

class Dreadnought: SKNode, Animate, Enemies {
    
    var canShoot: Bool = true
    var ship: SKSpriteNode!
    var weapon: SKSpriteNode!
    var engine: SKSpriteNode!
    var destruction: SKSpriteNode!
    
    //Enemies protocol
    var spriteList: [SKSpriteNode] = []
    var viewSize: CGRect
    var spawn: CGPoint = CGPoint()
    var moving: CGPoint = CGPoint()
    var shipSize: CGSize = CGSize()
    var scale: CGFloat = 0
    var shipSpeed: CGFloat = 0.6
    var health: Int = 5

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        ship = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtWeapon"), color: .white, size: CGSize(width: 128, height: 128))
        weapon = SKSpriteNode(texture: SKTexture(imageNamed: "Ray"), color: .white, size: CGSize(width: 18, height: viewSize.height))
        engine = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtEngine"), color: .white, size: CGSize(width: 128, height: 128))
        destruction = SKSpriteNode(texture: SKTexture(imageNamed: "DreadnoughtDestruction"), color: .white, size: CGSize(width: 128, height: 128))
        
        super.init()
        
        scale = getScale(sceneSize: viewSize)
        shipSize = CGSize(width: ship.size.width / 2, height: ship.size.height)
        spawn = generateSpawn()
        moving = generateDestination()
        
        ship.position = CGPoint(x: spawn.x, y: spawn.y)
        ship.zPosition = 11
        ship.setScale(scale * 1.2)
        ship.zRotation = .pi
        
        weapon.anchorPoint = CGPointMake(0.5, 0);
        weapon.position = CGPoint(x: spawn.x, y: spawn.y - 38)
        weapon.zPosition = 12
        weapon.setScale(scale * 1.2)
        weapon.zRotation = .pi
        weapon.isHidden = true
        
        engine.position = CGPoint(x: spawn.x, y: spawn.y)
        engine.zPosition = 10
        engine.setScale(scale * 1.2)
        engine.zRotation = .pi
        
        destruction.position = CGPoint(x: spawn.x, y: spawn.y)
        destruction.zPosition = 10
        destruction.setScale(scale * 1.2)
        destruction.isHidden = true
        destruction.zRotation = .pi
        
        setFirstSprite(sprite: ship, spriteSheet: SKTexture(imageNamed: "DreadnoughtWeapon"), spriteWidth: 128)
        animateSprite(sprite: engine, spriteSheet: SKTexture(imageNamed: "DreadnoughtEngine"), duration: 0.15, spriteWidth: 128.0)
        animateSprite(sprite: weapon, spriteSheet: SKTexture(imageNamed: "Ray"), duration: 0.15, spriteWidth: 18)
        
        spriteList.append(ship)
        spriteList.append(weapon)
        spriteList.append(engine)
        spriteList.append(destruction)
        
        addChild(ship)
        addChild(weapon)
        addChild(engine)
        addChild(destruction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot() -> [Bullet] {
        updateRay()
        if getHealth() < 1 {
            return []
        }
        let shoot = Int(arc4random_uniform(200))
        if shoot == 0 && canShoot == true {
            rayShoot()
        }
        if shoot == 1 {
            return energyShoot()
        }
        return []
    }
    
    func updateRay() {
        weapon.size.height = ((viewSize.height / 2) + weapon.position.y)
    }
    
    func rayShoot() {
        canShoot = false
        
        let spriteSheet = SKTexture(imageNamed: "DreadnoughtWeapon")
        let frameCount = Int(spriteSheet.size().width / 128)
        var textures: [SKTexture] = []

        for index in 0..<frameCount {
            let x = CGFloat(index) * 128 / spriteSheet.size().width
            let texture = SKTexture(rect: CGRect(x: x, y: 0, width: 128 / spriteSheet.size().width, height: 1), in: spriteSheet)
            textures.append(texture)
        }
        
        var currentFrame = 0
        let animateAction = SKAction.customAction(withDuration: Double(frameCount) * 0.25) { _, elapsedTime in
            let frame = Int(elapsedTime / 0.25)
            if frame != currentFrame && frame == 22 {
                self.weapon.isHidden = false
                currentFrame = frame
            }
            self.spriteList[0].texture = textures[frame > 33 ? 0 : frame]
        }
        
        let removeAction = SKAction.run {
            self.spriteList[0].removeAction(forKey: "animateAction")
            self.setFirstSprite(sprite: self.spriteList[0], spriteSheet: spriteSheet, spriteWidth: 128)
            self.canShoot = true
            self.weapon.isHidden = true
        }
        
        let sequence = SKAction.sequence([animateAction, removeAction])
        spriteList[0].run(sequence, withKey: "animateAction")
    }

    func energyShoot() -> [Bullet] {
        let scenario = Int(arc4random_uniform(3))
        var bulletsToAdd: [Bullet] = []
        
        var xPosition = ship.position.x - 66
        var yPosition = ship.position.y
        
        for i in 0..<9 {
            let pattern = i == 0 ? "left" : i == 4 ? "up" : i == 8 ? "right" : i < 4 ? "left up" : "right up"
            let energyBullet = EnergyBullet(spawn: CGPoint(x: xPosition, y: yPosition), scale: scale, pattern: pattern, scenario: scenario)
            bulletsToAdd.append(energyBullet)
            
            if i != 0 && i != 8 {
                let pattern2 = i == 0 ? "left" : i == 4 ? "up" : i == 8 ? "right" : i < 4 ? "left up" : "right up"
                let energyBullet2 = EnergyBullet(spawn: CGPoint(x: xPosition, y: (ship.position.y - yPosition) + ship.position.y), scale: scale, pattern: pattern2, scenario: scenario)
                bulletsToAdd.append(energyBullet2)
            }
            
            xPosition += 16.66
            if i < 4 {
                yPosition -= 16.66
            } else {
                yPosition += 16.66
            }
        }
        return bulletsToAdd
    }
}
