//
//  GameScene.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//


import SpriteKit
import GameplayKit
import SwiftUI



class GameScene: SKScene {
    
    let myGray = UIColor(red: 129/255, green: 129/255, blue: 129/255, alpha: 1.0)
    
    
    
    //Variabili che compongono l'home page, background, logo, riflessi e scritta
    let squareUp = SKShapeNode(rectOf: CGSize(width: 200, height: 200))
    let backgroundScreenBottomPart = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.3))
    let backgroundScreen = SKSpriteNode(imageNamed: "Gradient")
    let playButton = SKSpriteNode(imageNamed: "PlayButton1")
//    let playButton = SKSpriteNode(imageNamed: "Start")
    let door = SKSpriteNode(imageNamed: "MainMenuBackground")
//    let houseSpriteMenuMirrored = SKSpriteNode(imageNamed: "House.png")
    var gameTitleWithReflection = SKSpriteNode(imageNamed: "Title_white_resized")
    
    let blackCover = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    let impostazioniLabel = SKSpriteNode(imageNamed: "Settings")
    //Variabili che compongono il menu di impostazioni contenenti impostazioni per l'audio e per la lingua
    let settingsButton = SKSpriteNode(imageNamed: "Setting")
    
    let settingsBackground = SKSpriteNode(imageNamed: "DropMenu2")
    
    let backgroundSettings = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
//    let settingsLabel = SKLabelNode(text: "Settings")
    
    let musicIcon = SKSpriteNode(imageNamed: "MusicOn")
    
    let sfxButton = SKSpriteNode(imageNamed: "SfxOn")
    
    let languageButton = SKSpriteNode(imageNamed: "EnglishFlag")
    
//    let closeSettingsButton = SKLabelNode(text: "Close")
    let closeSettingsButton = SKSpriteNode(imageNamed: "Close")

    
    
    override func didMove(to view: SKView) {
        blackCover.alpha = 1
        blackCover.strokeColor = .black
        blackCover.fillColor = .black
        blackCover.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        blackCover.zPosition = 150
        addChild(blackCover)
//        blackCover.run(SKAction.fadeOut(withDuration: 1), completion: {
//            self.backgroundScreen.size.width = self.size.width
//            self.backgroundScreen.size.height = self.size.height
//            self.backgroundScreen.position = CGPoint(x: self.size.width*0.5,y: self.size.height*0.5)
//            self.addChild(self.backgroundScreen)
//
//            self.backgroundScreenBottomPart.position = CGPoint(x: self.size.width*0.5,y: self.size.height*0.15)
//            self.backgroundScreenBottomPart.fillColor = .black
//            self.backgroundScreenBottomPart.strokeColor = .black
//            self.addChild(self.backgroundScreenBottomPart)
//
//            self.door.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
//            self.door.xScale = 0.3
//            self.door.yScale = 0.3
//
//            self.playButton.position = CGPoint(x: self.size.width*0.5,y: self.size.height*0.1)
//            self.playButton.size = CGSize(width: self.size.width*0.25, height: self.size.width*0.25)
//            self.playButton.name = "playGameName"
//
//            self.gameTitleWithReflection.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.85)
//            self.gameTitleWithReflection.xScale = 0.3
//            self.gameTitleWithReflection.yScale = 0.3
//
//            //Impostazioni relative al menu di opzioni
//            self.settingsButton.position = CGPoint(x: self.size.width*0.89, y: self.size.height*0.92)
//            self.settingsButton.xScale = self.size.width*0.0002
//            self.settingsButton.yScale = self.size.width*0.0002
//            self.settingsButton.name = "settingsButton"
//
//            self.backgroundSettings.fillColor = .black
//            self.backgroundSettings.strokeColor = .black
//            self.backgroundSettings.alpha = 0.45
//            self.backgroundSettings.zPosition = 7
//            self.backgroundSettings.name = "closeSettings"
//            self.backgroundSettings.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
//
//            self.settingsBackground.zPosition = 8
//            self.settingsBackground.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
//            self.settingsBackground.xScale = self.size.width*0.0011
//            self.settingsBackground.yScale = self.size.width*0.0011
//
//            self.impostazioniLabel.zPosition = 9
//            self.impostazioniLabel.position = CGPoint(x: self.size.width*0.51, y: self.size.height*0.64)
//            self.impostazioniLabel.xScale = self.size.width*0.0005
//            self.impostazioniLabel.yScale = self.size.width*0.0005
//            self.impostazioniLabel.name = "impostazioniLabel"
//
//            self.musicIcon.position = CGPoint(x: self.size.width*0.675, y: self.size.height*0.55)
//            self.musicIcon.zPosition = 9
//            self.musicIcon.xScale = self.size.width*0.0005
//            self.musicIcon.yScale = self.size.width*0.0005
//            self.musicIcon.name = "musicButton"
//
//            self.sfxButton.position = CGPoint(x: self.size.width*0.38, y: self.size.height*0.55)
//            self.sfxButton.zPosition = 9
//            self.sfxButton.xScale = self.size.width*0.0005
//            self.sfxButton.yScale = self.size.width*0.0005
//            self.sfxButton.name = "sfxButton"
//
//            self.languageButton.position = CGPoint(x: self.size.width*0.51, y: self.size.height*0.43)
//            self.languageButton.zPosition = 9
//            self.languageButton.xScale = self.size.width*0.00035
//            self.languageButton.yScale = self.size.width*0.00035
//            self.languageButton.name = "languageButton"
//
//
//            self.closeSettingsButton.zPosition = 9
//            self.closeSettingsButton.xScale = self.size.width*0.0007
//            self.closeSettingsButton.yScale = self.size.width*0.0007
//            self.closeSettingsButton.position = CGPoint(x: self.size.width*0.51, y: self.size.height*0.31)
//            self.closeSettingsButton.name = "closeSettings"
//
//
//            //Aggiungo gli elementi alla scena
//            self.addChild(self.door)
//            self.addChild(self.gameTitleWithReflection)
//            self.addChild(self.playButton)
//            self.addChild(self.settingsButton)
//
//
//
//            //Avvio la musica
//            musicHandler.instance.playBackgroundMusicMenu()
//
//            self.blackCover.removeFromParent()
//        })
        
        backgroundScreen.size.width = size.width
        backgroundScreen.size.height = size.height
        backgroundScreen.position = CGPoint(x: size.width*0.5,y: size.height*0.5)
        addChild(backgroundScreen)

        backgroundScreenBottomPart.position = CGPoint(x: size.width*0.5,y: size.height*0.15)
        backgroundScreenBottomPart.fillColor = .black
        backgroundScreenBottomPart.strokeColor = .black
        addChild(backgroundScreenBottomPart)

        door.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        door.xScale = 0.3
        door.yScale = 0.3

        playButton.position = CGPoint(x: size.width*0.5,y: size.height*0.1)
        playButton.size = CGSize(width: size.width*0.25, height: size.width*0.25)
        playButton.name = "playGameName"

        gameTitleWithReflection.position = CGPoint(x: size.width*0.5, y: size.height*0.85)
        gameTitleWithReflection.xScale = 0.3
        gameTitleWithReflection.yScale = 0.3


        //Impostazioni relative al menu di opzioni
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


        //Aggiungo gli elementi alla scena
        addChild(door)
        addChild(gameTitleWithReflection)
        addChild(playButton)
        addChild(settingsButton)
        
        blackCover.run(SKAction.fadeOut(withDuration: 1), completion: {
            musicHandler.instance.playBackgroundMusicMenu()
            self.blackCover.removeFromParent()
        })

        //Avvio la musica
//        musicHandler.instance.playBackgroundMusicMenu()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if(touchedNode.name == "playGameName"){
            musicHandler.instance.stopBackgroundMusicMenu()
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            blackCover.alpha = 0
            blackCover.fillColor = .black
            blackCover.strokeColor = .black
            blackCover.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
            addChild(blackCover)
            blackCover.run(fadeInAction)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                let startGameScene = Prologue(size: self.size)
                self.view?.presentScene(startGameScene)
            }
        }
        
        if(touchedNode.name == "settingsButton"){
            
            if(musicHandler.instance.mutedMusic == true){
                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOff")))
            } else if (musicHandler.instance.mutedMusic == false){
                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOn")))
            }
            
            if(musicHandler.instance.mutedSFX == true){
                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOff")))
            } else if (musicHandler.instance.mutedSFX == false){
                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOn")))
            }
            
            if(LanguageHandler.instance.language == "Italian"){
                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "ItalianFlag")))
                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Chiudi")))
                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "ImpostazioniITA")))
            } else if(LanguageHandler.instance.language == "English") {
                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "EnglishFlag")))
                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Close")))
                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "Settings")))
            }

            
            addChild(settingsBackground)
            addChild(backgroundSettings)
            addChild(impostazioniLabel)
            addChild(musicIcon)
            addChild(sfxButton)
            addChild(languageButton)
            addChild(closeSettingsButton)
        }
        
        if(touchedNode.name == "musicButton"){
            if(musicHandler.instance.mutedMusic == true){
                musicHandler.instance.unmuteBackgroundMusic()
                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOn")))
            } else if (!musicHandler.instance.mutedMusic){
                musicHandler.instance.muteBackgroundMusic()
                musicIcon.run(SKAction.setTexture(SKTexture(imageNamed: "MusicOff")))
            }
        }
        
        if(touchedNode.name == "sfxButton"){
            if(musicHandler.instance.mutedSFX == true){
                musicHandler.instance.unmuteSfx()
                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOn")))
            } else if (!musicHandler.instance.mutedSFX){
                musicHandler.instance.muteSfx()
                sfxButton.run(SKAction.setTexture(SKTexture(imageNamed: "SfxOff")))
            }
        }
        
        if (touchedNode.name == "languageButton"){
            if(LanguageHandler.instance.language == "English"){
                LanguageHandler.instance.language = "Italian"
                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "ItalianFlag")))
                closeSettingsButton.removeFromParent()
                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Chiudi")))
                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "ImpostazioniITA")))
                addChild(closeSettingsButton)
            } else if(LanguageHandler.instance.language == "Italian"){
                LanguageHandler.instance.language = "English"
                closeSettingsButton.removeFromParent()
                closeSettingsButton.run(SKAction.setTexture(SKTexture(imageNamed: "Close")))
                addChild(closeSettingsButton)
                languageButton.run(SKAction.setTexture(SKTexture(imageNamed: "EnglishFlag")))
                impostazioniLabel.run(SKAction.setTexture(SKTexture(imageNamed: "Settings")))
            }
        }
        
        
        if(touchedNode.name == "closeSettings"){
            backgroundSettings.removeFromParent()
            settingsBackground.removeFromParent()
            impostazioniLabel.removeFromParent()
            musicIcon.removeFromParent()
            sfxButton.removeFromParent()
            languageButton.removeFromParent()
            closeSettingsButton.removeFromParent()
        }
       
    }

}
