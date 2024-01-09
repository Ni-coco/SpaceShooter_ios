//
//  UI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class DisplayUI: SKNode {
    
    var lifeUI: SKSpriteNode
    var shieldUI: SKSpriteNode
    var shieldBtn: SKSpriteNode
    var shieldText: SKLabelNode = SKLabelNode()
    
    let viewSize: CGRect
    var scale: CGFloat = 0
    var canShield: Bool = true

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
        shieldText.fontName = UIFont(name: "Minecraft", size: 30)?.fontName
        shieldText.position = CGPoint(x: 0, y: -10) // Adjust the position based on your requirements
        shieldBtn.addChild(shieldText)
                            
        addChild(lifeUI)
        addChild(shieldUI)
        addChild(shieldBtn)
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
}


