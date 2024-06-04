//
//  UI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class GameUI: SKNode {
    
    var lifeUI: SKSpriteNode
    var shieldUI: SKSpriteNode
    var shieldBtn: SKSpriteNode
    var shieldText: SKLabelNode = SKLabelNode()
    var waveText: SKLabelNode = SKLabelNode()
    var timerText: SKLabelNode = SKLabelNode()
    
    var launchTime = Int64(Date().timeIntervalSince1970 * 1000)
    
    let viewSize: CGRect
    var scale: CGFloat = 0
    var canShield: Bool = true
    var score: String = ""

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"))
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"))
        shieldBtn = SKSpriteNode(texture: SKTexture(imageNamed: "Container"))
        
        super.init()
        
        scale = getScale(viewSize: viewSize)
        
        lifeUI.position = CGPoint(x: -(viewSize.maxX / 2) + (75 * scale), y: -(viewSize.maxY / 2) + (37.5 * scale))
        shieldUI.position = CGPoint(x: -(viewSize.maxX / 2) + (75 * scale), y: -(viewSize.maxY / 2) + (62.5 * scale))
        shieldBtn.position = CGPoint(x: (viewSize.maxX / 2) - (80 * scale), y: -(viewSize.maxY / 2) + (50 * scale))
        
        lifeUI.zPosition = 1
        lifeUI.setScale(scale)
        
        shieldUI.zPosition = 1
        shieldUI.setScale(scale)
        
        shieldBtn.zPosition = 1
        shieldBtn.setScale(scale * 0.5)
        
        shieldText = SKLabelNode(text: "Shield")
        shieldText.fontName = UIFont(name: "Minecraft", size: 40)?.fontName
        shieldText.position = CGPoint(x: 0, y: -12)
        shieldBtn.addChild(shieldText)
        
        waveText = SKLabelNode(text: "Wave 1")
        waveText.fontName = UIFont(name: "Minecraft", size: 60)?.fontName
        waveText.position = CGPoint(x: 0, y: 0)
        
        timerText.fontName = UIFont(name: "Minecraft", size: 5)?.fontName
        timerText.position = CGPoint(x: -(viewSize.width / 2) + 50, y: (viewSize.height / 2) - 40)
        timerText.setScale(scale * 0.8)
                            
        addChild(lifeUI)
        addChild(shieldUI)
        addChild(shieldBtn)
        addChild(waveText)
        addChild(timerText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getScale(viewSize: CGRect) -> CGFloat {
        let screenHeight = max(viewSize.height, viewSize.width)
        return(screenHeight / 1055)
    }
    
    func setLifeUI(index: Int) {
        if index >= 0 {
            lifeUI.texture = SKTexture(imageNamed: "health\(index)")
        }
    }
    
    func setShieldUI(index: Int) {
        if index >= 0 {
            shieldUI.texture = SKTexture(imageNamed: "shield\(index)")
        }
    }
    
    func manageShieldUI() {
        canShield = false
        self.setShieldUI(index: 0)
        var time = 5.0
        for i in 0..<5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                self.setShieldUI(index: i)
                if i == 4 {
                    self.canShield = true
                }
            }
            time += 5.0
        }
    }
    
    func shieldAvailable() -> Bool {
        return self.canShield
    }
    
    func displayWave(wave: Int) {
        waveText.text = "Wave \(wave)"
        waveText.alpha = 1.0

        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 5.0)
        waveText.run(fadeOut)
    }
    
    func reloadTimer() {
        let remainTime = Int64(Date().timeIntervalSince1970) * 1000 - launchTime
        let min = Int((remainTime / 1000) / 60)
        let sec = Int((remainTime / 1000) % 60)
        timerText.text = String(format: "%02d:%02d", min, sec) 
        score = String(format: "%02d:%02d", min, sec)
    }
    
    func getScore() -> String {
        return score
    }
    
    func reset() {
        launchTime = Int64(Date().timeIntervalSince1970 * 1000)
        canShield = true
    }
}


