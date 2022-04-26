//
//  prologue.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit
import SwiftUI


class Prologue: SKScene, SKPhysicsContactDelegate{
//    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    
    let gameArea: CGRect
    let blackCover = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var transitioning: Bool = false
    let tapToContinue: SKShapeNode
    let blackScreenBackground: SKShapeNode
    let prologueText: SKLabelNode = SKLabelNode(text: LanguageHandler.instance.prologueTextEnglish)
    
    let languageButton = SKSpriteNode(imageNamed: "EnglishFlag")
    let closeSettingsButton = SKSpriteNode(imageNamed: "Close")
    let musicIcon = SKSpriteNode(imageNamed: "MusicOn")
    let sfxButton = SKSpriteNode(imageNamed: "SfxOn")
    let impostazioniLabel = SKSpriteNode(imageNamed: "Settings")
    let settingsButton = SKSpriteNode(imageNamed: "Setting")
    let settingsBackground = SKSpriteNode(imageNamed: "DropMenu2")
    let backgroundSettings = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))


    override init(size: CGSize) {
        blackScreenBackground = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
        tapToContinue = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
        
        
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
        
//        addChild(settingsBackground)
//        addChild(backgroundSettings)
//        addChild(impostazioniLabel)
//        addChild(musicIcon)
//        addChild(sfxButton)
//        addChild(languageButton)
//        addChild(closeSettingsButton)
    
//        addChild(pauseButton)
        setUp()

        self.addChild(self.blackScreenBackground)
        self.addChild(self.prologueText)
        self.addChild(tapToContinue)
//        self.addChild(pauseButton)
        self.blackCover.removeFromParent()
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
//
        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)
        
        if(touchedNode.name == "tapToContinue"){
            let startGameScene = Level00(size: self.size)
            self.view?.presentScene(startGameScene)
        }
        
//        if(touchedNode.name == "pause"){
//
//            if(musicHandler.instance.mutedMusic == true){
//                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOff")))
//            } else if (musicHandler.instance.mutedMusic == false){
//                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOn")))
//            }
//
//            if(musicHandler.instance.mutedSFX == true){
//                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOff")))
//            } else if (musicHandler.instance.mutedSFX == false){
//                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOn")))
//            }
//
//            if(LanguageHandler.instance.language == "Italian"){
//                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "ItalianFlag")))
//                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Chiudi")))
//                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "ImpostazioniITA")))
//            } else if(LanguageHandler.instance.language == "English") {
//                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "EnglishFlag")))
//                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Close")))
//                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "Settings")))
//            }
//
//            addChild(settingsBackground)
//            addChild(backgroundSettings)
//            addChild(impostazioniLabel)
//            addChild(musicIcon)
//            addChild(sfxButton)
//            addChild(languageButton)
//            addChild(closeSettingsButton)
//
//        }
            
//            if(touchedNode.name == "musicButton"){
//                if(musicHandler.instance.mutedMusic == true){
//                    musicHandler.instance.unmuteBackgroundMusic()
//                    musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOn")))
//                } else if (!musicHandler.instance.mutedMusic){
//                    musicHandler.instance.muteBackgroundMusic()
//                    musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOff")))
//                }
//            }
            
//            if(touchedNode.name == "sfxButton"){
//                if(musicHandler.instance.mutedSFX == true){
//                    musicHandler.instance.unmuteSfx()
//                    sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOn")))
//                } else if (!musicHandler.instance.mutedSFX){
//                    musicHandler.instance.muteSfx()
//                    sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOff")))
//                }
//            }
            
//            if (touchedNode.name == "languageButton"){
//                if(LanguageHandler.instance.language == "English"){
//                    prologueText.text = LanguageHandler.instance.prologueTextItalian
//                    LanguageHandler.instance.language = "Italian"
//                    languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "ItalianFlag")))
//                    closeSettingsButton.removeFromParent()
//                    closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Chiudi")))
//                    impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "ImpostazioniITA")))
//                    addChild(closeSettingsButton)
//                } else if(LanguageHandler.instance.language == "Italian"){
//                    prologueText.text = LanguageHandler.instance.prologueTextEnglish
//                    LanguageHandler.instance.language = "English"
//                    closeSettingsButton.removeFromParent()
//                    closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Close")))
//                    addChild(closeSettingsButton)
//                    languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "EnglishFlag")))
//                    impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "Settings")))
//                }
//            }
            
//            if(touchedNode.name == "closeSettings"){
//                backgroundSettings.removeFromParent()
//                settingsBackground.removeFromParent()
//                impostazioniLabel.removeFromParent()
//                musicIcon.removeFromParent()
//                sfxButton.removeFromParent()
//                languageButton.removeFromParent()
//                closeSettingsButton.removeFromParent()
//            }
           

            
//            addChild(settingsBackground)
//            addChild(backgroundSettings)
//            addChild(impostazioniLabel)
//            addChild(musicIcon)
//            addChild(sfxButton)
//            addChild(languageButton)
//            addChild(closeSettingsButton)
        }

        
        
    func setUp(){
        blackScreenBackground.fillColor = .black
        blackScreenBackground.strokeColor = .black
        blackScreenBackground.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        
        if(LanguageHandler.instance.language == "English"){
            prologueText.text = LanguageHandler.instance.prologueTextEnglish
    
        } else if(LanguageHandler.instance.language == "Italian"){
            prologueText.text = LanguageHandler.instance.prologueTextItalian
      
        }
        prologueText.numberOfLines = 0
        prologueText.preferredMaxLayoutWidth = size.width*0.9
        prologueText.position = CGPoint(x: size.width*0.5, y: size.height*0.2)
        prologueText.fontColor = .white
        prologueText.zPosition = 3
        prologueText.fontSize = size.width*0.07
        
        tapToContinue.fillColor = .black
        tapToContinue.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        tapToContinue.name = "tapToContinue"
        tapToContinue.alpha = 0.01
        tapToContinue.zPosition = 5
        
//        pauseButton.name = "pause"
//        pauseButton.position = CGPoint(x: size.width*0.1, y: size.height*0.94)
//        pauseButton.zPosition = 6
//        pauseButton.xScale = size.width*0.0001
//        pauseButton.yScale = size.width*0.0001
        
        settingsButton.position = CGPoint(x: size.width*0.89, y: size.height*0.92)
        settingsButton.xScale = size.width*0.0002
        settingsButton.yScale = size.width*0.0002
        settingsButton.name = "settingsButton"
        
        backgroundSettings.fillColor = .black
        backgroundSettings.strokeColor = .black
        backgroundSettings.alpha = 0.45
        backgroundSettings.zPosition = 7
        backgroundSettings.name = "closeSettings"
        backgroundSettings.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        
        settingsBackground.zPosition = 8
        settingsBackground.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        settingsBackground.xScale = size.width*0.0011
        settingsBackground.yScale = size.width*0.0011

        
        
        impostazioniLabel.zPosition = 9
        impostazioniLabel.position = CGPoint(x: size.width*0.51, y: size.height*0.64)
        impostazioniLabel.xScale = size.width*0.0005
        impostazioniLabel.yScale = size.width*0.0005
        impostazioniLabel.name = "impostazioniLabel"
        
        musicIcon.position = CGPoint(x: size.width*0.675, y: size.height*0.55)
        musicIcon.zPosition = 9
        musicIcon.xScale = size.width*0.0005
        musicIcon.yScale = size.width*0.0005
        musicIcon.name = "musicButton"
        
        sfxButton.position = CGPoint(x: size.width*0.38, y: size.height*0.55)
        sfxButton.zPosition = 9
        sfxButton.xScale = size.width*0.0005
        sfxButton.yScale = size.width*0.0005
        sfxButton.name = "sfxButton"
        
        languageButton.position = CGPoint(x: size.width*0.51, y: size.height*0.43)
        languageButton.zPosition = 9
        languageButton.xScale = size.width*0.00035
        languageButton.yScale = size.width*0.00035
        languageButton.name = "languageButton"
        
        
        closeSettingsButton.zPosition = 9
        closeSettingsButton.xScale = size.width*0.0007
        closeSettingsButton.yScale = size.width*0.0007
        closeSettingsButton.position = CGPoint(x: size.width*0.51, y: size.height*0.31)
        closeSettingsButton.name = "closeSettings"
        
        
    }
}

