//
//  UI.swift
//  SpaceShooter
//
//  Created by Nicolas Garde on 15/12/2023.
//

import SpriteKit
import UIKit

class DisplayUI: SKNode {
    
    let lifeUI: SKSpriteNode
    let shieldUI: SKSpriteNode
    
    let viewSize: CGRect
    var scale: CGFloat = 0

    init(viewSize: CGRect) {
        
        self.viewSize = viewSize

        lifeUI = SKSpriteNode(texture: SKTexture(imageNamed: "health4"))
        shieldUI = SKSpriteNode(texture: SKTexture(imageNamed: "shield4"))
        
        super.init()
        
        scale = getScale(viewSize: viewSize)
        
        
        lifeUI.position = CGPoint(x: -(viewSize.maxX / 2) + (75 * scale), y: -(viewSize.maxY / 2) + (37.5 * scale))
        shieldUI.position = CGPoint(x: -(viewSize.maxX / 2) + (75 * scale), y: -(viewSize.maxY / 2) + (62.5 * scale))
        
        lifeUI.zPosition = 1
        lifeUI.setScale(scale)
        
        shieldUI.zPosition = 1
        shieldUI.setScale(scale)
                            
        addChild(lifeUI)
        addChild(shieldUI)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getScale(viewSize: CGRect) -> CGFloat {
        let screenHeight = max(viewSize.height, viewSize.width)
        return(screenHeight / 1055)
    }
}
