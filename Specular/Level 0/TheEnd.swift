//
//  TheEnd.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit
import SwiftUI


class TheEnd: SKScene, SKPhysicsContactDelegate{
    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    
    let gameArea: CGRect
    
    let blackCover = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var transitioning: Bool = false
    
    let blackScreenBackground: SKShapeNode
    let mainMenuButton: SKSpriteNode = SKSpriteNode(imageNamed: "MainMenu")
    let creditsText: SKLabelNode = SKLabelNode(text: LanguageHandler.instance.creditsTextEnglish)

    override init(size: CGSize) {
        blackScreenBackground = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
        
        
        let playableHeight = size.width
        let playableMargin = (size.height-playableHeight)/2.0
        gameArea = CGRect(x: 0, y: playableMargin,
                                width: size.width,
                                height: playableHeight)
          super.init(size: size)
    }
        required init(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    override func didMove(to view: SKView) {
        
        
//        addChild(pauseButton)
        setUp()
        
        
//        let fadeOutAction = SKAction.fadeOut(withDuration: 1)
//        blackCover.alpha = 1
//        blackCover.fillColor = .black
//        blackCover.strokeColor = .black
//        blackCover.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
//        blackCover.zPosition = 10
//        addChild(blackCover)
//        blackCover.run(fadeOutAction)
        self.addChild(self.blackScreenBackground)
        self.addChild(self.mainMenuButton)
        self.addChild(self.creditsText)
        self.blackCover.removeFromParent()
        creditsText.xScale = 0
        creditsText.yScale = 0
    
        let scaleX = SKAction.scaleX(to: size.width*0.0025, duration: 1)
        let scaleY = SKAction.scaleY(to: size.width*0.0025, duration: 1)
        creditsText.run(scaleX)
        creditsText.run(scaleY)
       
        let moveFromRight = SKAction.moveTo(x: size.width*0.45, duration: 1.5)
        let moveToLeft = SKAction.moveTo(x: size.width*0.5, duration: 0.7)
        let moveToRight = SKAction.moveTo(x: size.width*0.52, duration: 0.5)
        
        let sequenceOfActions = SKAction.sequence([moveFromRight, moveToRight, moveToLeft])
        mainMenuButton.run(sequenceOfActions)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)

        if(touchedNode.name == "goToMenu"){
            let gameScene = GameScene(size: size)
            view?.presentScene(gameScene)
        }
}
    
    func setUp(){
        blackScreenBackground.fillColor = .black
        blackScreenBackground.strokeColor = .black
        blackScreenBackground.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        
        if(LanguageHandler.instance.language == "English"){
            mainMenuButton.run(SKAction.setTexture(SKTexture(imageNamed: "MainMenu")))
            creditsText.text = LanguageHandler.instance.creditsTextEnglish
        } else if(LanguageHandler.instance.language == "Italian"){
            mainMenuButton.run(SKAction.setTexture(SKTexture(imageNamed: "MenuPrincipale")))
            creditsText.text = LanguageHandler.instance.creditsTextItalian
        }
        mainMenuButton.position = CGPoint(x: size.width*2, y: size.height*0.1)
        mainMenuButton.xScale = size.width*0.0007
        mainMenuButton.yScale = size.width*0.0007
        mainMenuButton.name = "goToMenu"
        creditsText.numberOfLines = 0
        creditsText.preferredMaxLayoutWidth = size.width*0.9
        creditsText.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        creditsText.fontColor = .white
        creditsText.zPosition = 3
        creditsText.fontSize = size.width*0.085
//        creditsText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline

        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: -gameArea.size.width/3 + CGFloat(10), y: gameArea.size.height*0.9 + CGFloat(10))
        pauseButton.zPosition = 20
        pauseButton.xScale = 0.05
        pauseButton.yScale = 0.05
    }
}

