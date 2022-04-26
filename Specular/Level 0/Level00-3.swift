//
//  Level00-3.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import AVFoundation
import UIKit
import SpriteKit
import SwiftUI


class Level00_3: SKScene, SKPhysicsContactDelegate{
    @AppStorage("language") var language: String = "English"
    
    let blackCover = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var transitioning: Bool = false
    
    let iButton = SKSpriteNode(imageNamed: "Info")
    let infoText = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish)
    let infoText2 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish2)
    let infoText3 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish3)
    let infoText4 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish4)
    let infoText5 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish5)
    let infoText6 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish6)
    let infoOpacityOverlay = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let infoBackground = SKSpriteNode(imageNamed: "Drop Menu 2")
    var infoNavigation: Bool = true
    
    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    let room = SKSpriteNode(imageNamed: "Level0-Room3")
    let characterAvatar = SKSpriteNode(imageNamed: "Stop")
    let characterFeetCollider = SKSpriteNode(imageNamed: "CharacterFeet2")
    
    let barrierDownLF = SKSpriteNode(imageNamed: "BarrierBottomLF-Room3")
    let barrierDownRT = SKSpriteNode(imageNamed: "BarrierBottomRT-Room3")
    let barrierTopLF = SKSpriteNode(imageNamed: "BarrierLeft(1)")
    let barrierTopRT = SKSpriteNode(imageNamed: "BarrierTopRT-Room3")
    
    let doorColliderTopLF = SKSpriteNode(imageNamed: "DoorColliderTopLF-Room3")
    let doorColliderTopRT = SKSpriteNode(imageNamed: "DoorColliderTopRT-Room3")
    
    let armachair = SKSpriteNode(imageNamed: "Armchairs-Room3")
    let books = SKSpriteNode(imageNamed: "Books-Room3")
    let doorLF = SKSpriteNode(imageNamed: "Door open1-Room3")
    let doorRT = SKSpriteNode(imageNamed: "Door open RT-Room3")
    let lamp = SKSpriteNode(imageNamed: "Floor Lamp-Room3")
    
    let colliderLamp = SKSpriteNode(imageNamed: "ColliderLampRoom3")
    let colliderBook = SKSpriteNode(imageNamed: "Level0-Room3-BookCollider")
    let bookTransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room3-BooksTransparencyCollider")
    let colliderArmchairLeft = SKSpriteNode(imageNamed: "Level0-Room3-ArmchairColliderLeft")
    let colliderArmchairRight = SKSpriteNode(imageNamed: "Level0-Room3-ArmchairColliderRight")
    let colliderTrasparencyChair = SKSpriteNode(imageNamed: "ColliderTrasparencyRoom3")
    let armchairsTransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room3-ArmchairsTransparencyCollider")
    
    var WorldGroup = SKSpriteNode()
    
    var tappedObject: Bool = false
    var location = CGPoint.zero
    
    //Variabili per gestire le animazioni
    
    var chairCollider: Bool = false
    var booksCollided: Bool = false
    let blackEffect: SKShapeNode
    
    //Elementi dell'overlay del diario
    let diary = SKSpriteNode(imageNamed: "Diary1")
    let diaryZoneInteractionCollider: SKShapeNode
    let infoDiary = SKLabelNode(text: LanguageHandler.instance.objectiveEnglishDiary)
    let infoDiary1 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglishDiary1)
    let infoDiaryy2 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglishDiary2)
    let infoOpacityOverlayDiary = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let overlayDescription = SKSpriteNode(imageNamed: "DropDiary")
    
    let dollCreepy = SKSpriteNode(imageNamed: "DollCreepy")
    let dollCreepyInteractionLabel = SKLabelNode(fontNamed: "MonoSF")
    
    let cameraNode = SKCameraNode()
    
    let gameArea: CGRect
    
    var stopScene: Bool = false
    
    let tappableQuit = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let dollCreepyZoneInteraction: SKShapeNode
    
    override init(size: CGSize) {
        blackEffect = SKShapeNode(rectOf: CGSize(width: size.width*1, height: size.width*2.1))
        dollCreepyZoneInteraction = SKShapeNode(rectOf: CGSize(width: size.width*0.4, height: size.width*0.35))
        diaryZoneInteractionCollider = SKShapeNode(rectOf: CGSize(width: size.width*0.35, height: size.width*0.34))
        
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
        CharacterMovementHandler.instance.resetWalkingVariables()

        
        roomSetUp()
        addChild(room)
        addChild(doorLF)
        addChild(doorRT)
        addChild(lamp)
        addChild(armachair)
        addChild(books)
        addChild(barrierTopLF)
        addChild(barrierTopRT)
        addChild(barrierDownLF)
        addChild(barrierDownRT)
        addChild(doorColliderTopLF)
        addChild(doorColliderTopRT)
        addChild(characterAvatar)
        addChild(characterFeetCollider)
        addChild(colliderBook)
        addChild(bookTransparencyCollider)
        addChild(colliderLamp)
        addChild(colliderArmchairLeft)
        addChild(colliderArmchairRight)
        addChild(colliderTrasparencyChair)
        addChild(armchairsTransparencyCollider)
        addChild(diary)
        addChild(diaryZoneInteractionCollider)
        addChild(dollCreepy)
        addChild(dollCreepyZoneInteraction)
        
        cameraNode.addChild(blackEffect)
        cameraNode.addChild(iButton)
        addChild(cameraNode)
        camera = cameraNode
        //Aggiungo il bottonr per aprire il menu di pausa alla camera di gioco
        cameraNode.addChild(pauseButton)
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        blackCover.alpha = 1
        blackCover.fillColor = .black
        blackCover.strokeColor = .black
        blackCover.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0)
        blackCover.zPosition = 100
        cameraNode.addChild(blackCover)
        blackCover.run(fadeOutAction, completion: {
            musicHandler.instance.playBackgroundMusic()
        })
        
        //Per abilitare le collisioni nella scena
        self.scene?.physicsWorld.contactDelegate = self
     
        previousRoom = "Room3"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else{
            return
        }
        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)
        
        if(touchedNode.name == "goToMenu"){
            musicHandler.instance.stopLevelBackgroundMusic()
            let gameScene = GameScene(size: size)
            view?.presentScene(gameScene)
        }
        
        //Se premo sul bottone di pausa vado a mettere la scena in pausa, dopodichè faccio un controllo: nel caso in cui la variabile firstSet sia impostata a falsa significa che da quando ho aperto l'applicazione ancora non ho impostato nessuna volta la posizione degli elementi del menu di pausa, quindi procedo a farlo e dopodichè richiamo la funzione initializeNodeSettings() che nel caso in cui sia la prima volta che è richiamata fa tutte le impostazioni del caso del menu di pausa e poi mette la variabile firstSet a true, altrimenti si occupa solamente di impostare la trasparenza dei bottoni dell'attivazione e disattivazione della musica.
        //Fatto questo quello che faccio è caricare il menu di pausa nella scena aggiungengo i nodi al cameraNode
        if(touchedNode.name == "pause"){
            if(!UIAnimationsHandler.instance.itemInteractible && !UIAnimationsHandler.instance.fullOpen){
                stopScene = true
    //            self.isPaused = true
                if(PauseMenuHandler.instance.firstSet == false){
                    PauseMenuHandler.instance.settingsBackground.xScale = size.width*0.0011
                    PauseMenuHandler.instance.settingsBackground.yScale = size.width*0.0011
                    
                    PauseMenuHandler.instance.pauseLabel.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.32)
                    PauseMenuHandler.instance.pauseLabel.xScale = size.width*0.0007
                    PauseMenuHandler.instance.pauseLabel.yScale = size.width*0.0007
                    PauseMenuHandler.instance.pauseLabelItalian.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.32)
                    PauseMenuHandler.instance.pauseLabelItalian.xScale = size.width*0.0007
                    PauseMenuHandler.instance.pauseLabelItalian.yScale = size.width*0.0007
                    
                    PauseMenuHandler.instance.musicIcon.xScale = size.width*0.0005
                    PauseMenuHandler.instance.musicIcon.yScale = size.width*0.0005
                    PauseMenuHandler.instance.musicIcon.position = CGPoint(x: gameArea.size.width*0.13, y: gameArea.size.height*0.15)
                    PauseMenuHandler.instance.musicIconOff.xScale = size.width*0.0005
                    PauseMenuHandler.instance.musicIconOff.yScale = size.width*0.0005
                    PauseMenuHandler.instance.musicIconOff.position = CGPoint(x: gameArea.size.width*0.13, y: gameArea.size.height*0.15)
                    
                    PauseMenuHandler.instance.sfxButton.xScale = size.width*0.0005
                    PauseMenuHandler.instance.sfxButton.yScale = size.width*0.0005
                    PauseMenuHandler.instance.sfxButton.position = CGPoint(x: -gameArea.size.width*0.12, y: gameArea.size.height*0.15)
                    PauseMenuHandler.instance.sfxButtonOff.xScale = size.width*0.0005
                    PauseMenuHandler.instance.sfxButtonOff.yScale = size.width*0.0005
                    PauseMenuHandler.instance.sfxButtonOff.position = CGPoint(x: -gameArea.size.width*0.12, y: gameArea.size.height*0.15)
                    
                    PauseMenuHandler.instance.languageButton.xScale = size.width*0.00035
                    PauseMenuHandler.instance.languageButton.yScale = size.width*0.00035
                    PauseMenuHandler.instance.languageButton.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.05)
                    PauseMenuHandler.instance.languageButtonItalian.xScale = size.width*0.00035
                    PauseMenuHandler.instance.languageButtonItalian.yScale = size.width*0.00035
                    PauseMenuHandler.instance.languageButtonItalian.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.05)
                    
                    PauseMenuHandler.instance.mainMenuButtonEnglish.xScale = size.width*0.0005
                    PauseMenuHandler.instance.mainMenuButtonEnglish.yScale = size.width*0.0005
                    PauseMenuHandler.instance.mainMenuButtonEnglish.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.25)
                    PauseMenuHandler.instance.mainMenuButtonItalian.xScale = size.width*0.0005
                    PauseMenuHandler.instance.mainMenuButtonItalian.yScale = size.width*0.0005
                    PauseMenuHandler.instance.mainMenuButtonItalian.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.25)
                    
                    PauseMenuHandler.instance.closePauseButtonEnglish.xScale = size.width*0.0007
                    PauseMenuHandler.instance.closePauseButtonEnglish.yScale = size.width*0.0007
                    PauseMenuHandler.instance.closePauseButtonEnglish.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.4)
                    PauseMenuHandler.instance.closePauseButtonItalian.xScale = size.width*0.0007
                    PauseMenuHandler.instance.closePauseButtonItalian.yScale = size.width*0.0007
                    PauseMenuHandler.instance.closePauseButtonItalian.position = CGPoint(x: gameArea.size.width*0.01, y: -gameArea.size.height*0.4)
                }
                
                PauseMenuHandler.instance.initializeNodeSettings()
                
                cameraNode.addChild(PauseMenuHandler.instance.backgroundSettings)
                
                UIAnimationsHandler.instance.pauseOverlayPopUpAnimation(size: size, cameraNode: cameraNode)
            }
            
//            if(musicHandler.instance.mutedMusic == true){
//                cameraNode.addChild(PauseMenuHandler.instance.musicIconOff)
//            } else if (musicHandler.instance.mutedMusic == false){
//                cameraNode.addChild(PauseMenuHandler.instance.musicIcon)
//            }
//
//
//            if(musicHandler.instance.mutedSFX){
//                cameraNode.addChild(PauseMenuHandler.instance.sfxButtonOff)
//            } else if (!musicHandler.instance.mutedSFX){
//                cameraNode.addChild(PauseMenuHandler.instance.sfxButton)
//            }
//
//            if(LanguageHandler.instance.language == "English"){
//                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonEnglish)
//                cameraNode.addChild(PauseMenuHandler.instance.languageButton)
//                cameraNode.addChild(PauseMenuHandler.instance.pauseLabel)
//                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonEnglish)
//            } else if (LanguageHandler.instance.language == "Italian"){
//                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonItalian)
//                cameraNode.addChild(PauseMenuHandler.instance.languageButtonItalian)
//                cameraNode.addChild(PauseMenuHandler.instance.pauseLabelItalian)
//                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonItalian)
//            }
//
//
//            cameraNode.addChild(PauseMenuHandler.instance.backgroundSettings)
//            cameraNode.addChild(PauseMenuHandler.instance.settingsBackground)
            
        }
        
        if(touchedNode.name == "musicButton"){
            if(musicHandler.instance.mutedMusic == true){
                musicHandler.instance.unmuteBackgroundMusic()
                PauseMenuHandler.instance.musicIconOff.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.musicIcon)
            } else if (!musicHandler.instance.mutedMusic){
                musicHandler.instance.muteBackgroundMusic()
                PauseMenuHandler.instance.musicIcon.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.musicIconOff)
            }
        }
        
        if(touchedNode.name == "sfxButton"){
            if(musicHandler.instance.mutedSFX == true){
                musicHandler.instance.unmuteSfx()
                PauseMenuHandler.instance.sfxButtonOff.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.sfxButton)
            } else if  (!musicHandler.instance.mutedSFX){
                musicHandler.instance.muteSfx()
                PauseMenuHandler.instance.sfxButton.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.sfxButtonOff)
            }
        }
        
        if(touchedNode.name == "infoButton"){
            if(!UIAnimationsHandler.instance.itemInteractible && !UIAnimationsHandler.instance.fullOpen){
                stopScene = true
                let xScaleAction = SKAction.scaleX(to: self.size.width*0.0017, duration: 0.3)
                let yScaleAction = SKAction.scaleY(to: self.size.width*0.0008, duration: 0.3)
                if (LanguageHandler.instance.language == "English"){
                    infoText.text = LanguageHandler.instance.infoTextOneEnglish
                    infoText2.text = LanguageHandler.instance.infoTextTwoEnglish
                } else if (LanguageHandler.instance.language == "Italian"){
                    infoText.text = LanguageHandler.instance.infoTextOneItalian
                    infoText2.text = LanguageHandler.instance.infoTextTwoItalian
                }
                infoText.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.32)
                UIAnimationsHandler.instance.infoOverlayPopUpAnimation(size: size, cameraNode: cameraNode, infoBackground: infoBackground, infoText: infoText, infoOpacityOverlay: infoOpacityOverlay)
            }
        }
        if(touchedNode.name == "closeInfo"){
            if(infoNavigation){
                infoText.text = infoText2.text
                infoText.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.2)
                infoNavigation = false
            } else {
                if(UIAnimationsHandler.instance.fullOpen && UIAnimationsHandler.instance.itemInteractible){
                    UIAnimationsHandler.instance.infoOverlayRemoveAnimation(infoBackground: infoBackground, infoText: infoText, infoOpacityOverlay: infoOpacityOverlay)
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.stopScene = false
                        self.infoNavigation = true
                    })
                }
            }
        }
        
        
        if(touchedNode.name == "languageButton"){
            if(LanguageHandler.instance.language == "English"){
                LanguageHandler.instance.language = "Italian"
                PauseMenuHandler.instance.closePauseButtonEnglish.removeFromParent()
                PauseMenuHandler.instance.languageButton.removeFromParent()
                PauseMenuHandler.instance.pauseLabel.removeFromParent()
                PauseMenuHandler.instance.mainMenuButtonEnglish.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonItalian)
                cameraNode.addChild(PauseMenuHandler.instance.languageButtonItalian)
                cameraNode.addChild(PauseMenuHandler.instance.pauseLabelItalian)
                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonItalian)
            } else if (LanguageHandler.instance.language == "Italian"){
                LanguageHandler.instance.language = "English"
                PauseMenuHandler.instance.closePauseButtonItalian.removeFromParent()
                PauseMenuHandler.instance.languageButtonItalian.removeFromParent()
                PauseMenuHandler.instance.pauseLabelItalian.removeFromParent()
                PauseMenuHandler.instance.mainMenuButtonItalian.removeFromParent()
                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonEnglish)
                cameraNode.addChild(PauseMenuHandler.instance.languageButton)
                cameraNode.addChild(PauseMenuHandler.instance.pauseLabel)
                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonEnglish)
            }
        }
        
        if (touchedNode.name == "mainMenu"){
            musicHandler.instance.stopLevelBackgroundMusic()
            let newScene = GameScene(size: size)
            view?.presentScene(newScene)
        }
        
        if(touchedNode.name == "diary" && characterFeetCollider.frame.intersects(diaryZoneInteractionCollider.frame)){
            if(!UIAnimationsHandler.instance.itemInteractible && !UIAnimationsHandler.instance.fullOpen){
                stopScene = true
                if(LanguageHandler.instance.language == "English"){
                    infoDiary1.text = LanguageHandler.instance.objectiveEnglishDiary1
                }else if(LanguageHandler.instance.language == "Italian"){
                    infoDiary1.text = LanguageHandler.instance.objectiveItalianDiary1
                }
                UIAnimationsHandler.instance.itemPopUpAnimation(size: size, cameraNode: cameraNode, overlayNode: overlayDescription, infoText: infoDiary1, infoOpacityOverlay: infoOpacityOverlayDiary)
            }
            
//            stopScene = true
//            let xScaleInfo = SKAction.scaleX(to: size.width*0.0012, duration: 0.3)
//            let yScaleInfo = SKAction.scaleY(to: size.width*0.0012, duration: 0.3)
//            if(LanguageHandler.instance.language == "English"){
//                infoDiary.text = LanguageHandler.instance.objectiveEnglishDiary
//                infoDiary1.text = LanguageHandler.instance.objectiveEnglishDiary1
//                infoDiaryy2.text = LanguageHandler.instance.objectiveEnglishDiary2
//            }else
//            if(LanguageHandler.instance.language == "Italian"){
//                infoDiary.text = LanguageHandler.instance.objectiveItalianDiary
//                infoDiary1.text = LanguageHandler.instance.objectiveItalianDiary1
//                infoDiaryy2.text = LanguageHandler.instance.objectiveItalianDiary2
//            }
//            overlayDescription.xScale = 0
//            overlayDescription.yScale = 0
//            cameraNode.addChild(infoOpacityOverlayDiary)
//            cameraNode.addChild(overlayDescription)
//            overlayDescription.run(xScaleInfo)
//            overlayDescription.run(yScaleInfo, completion: {
//                self.cameraNode.addChild(self.infoDiary)
//                self.cameraNode.addChild(self.infoDiary1)
//                self.cameraNode.addChild(self.infoDiaryy2)
//            })
//            cameraNode.addChild(tappableQuit)
        }
        
        if(touchedNode.name == "overlayDescription"){
            if(UIAnimationsHandler.instance.fullOpen && UIAnimationsHandler.instance.itemInteractible){
                UIAnimationsHandler.instance.removePopUpAnimation(overlayNode: overlayDescription, infoText: infoDiary1, infoOpacityOverlay: infoOpacityOverlayDiary)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.stopScene = false
                })
            }
//            stopScene = false
//            self.isPaused = false
//            infoOpacityOverlayDiary.removeFromParent()
//            infoDiary.removeFromParent()
//            infoDiary1.removeFromParent()
//            infoDiaryy2.removeFromParent()
//            overlayDescription.removeFromParent()
//            tappableQuit.removeFromParent()
        }
        
        
        //Se clicco il bottone per chiudere il menu di pausa rimuovo tutti gli oggetti che compongono il menu di pausa dal cameraNode e rimuovo la pausa dalla scena di gioco
        if(touchedNode.name == "closePause"){
            if(UIAnimationsHandler.instance.fullOpen && UIAnimationsHandler.instance.itemInteractible){
                UIAnimationsHandler.instance.pauseOverlayRemoveAnimation()
//                PauseMenuHandler.instance.backgroundSettings.removeFromParent()
//                PauseMenuHandler.instance.settingsBackground.removeFromParent()
//
//                PauseMenuHandler.instance.pauseLabel.removeFromParent()
//                PauseMenuHandler.instance.pauseLabelItalian.removeFromParent()
//
//                PauseMenuHandler.instance.musicIcon.removeFromParent()
//                PauseMenuHandler.instance.musicIconOff.removeFromParent()
//                PauseMenuHandler.instance.sfxButton.removeFromParent()
//                PauseMenuHandler.instance.sfxButtonOff.removeFromParent()
//                PauseMenuHandler.instance.sfxButton.removeFromParent()
//
//                PauseMenuHandler.instance.languageButton.removeFromParent()
//                PauseMenuHandler.instance.languageButtonItalian.removeFromParent()
//
//                PauseMenuHandler.instance.closePauseButtonEnglish.removeFromParent()
//                PauseMenuHandler.instance.closePauseButtonItalian.removeFromParent()
//
//                PauseMenuHandler.instance.mainMenuButtonEnglish.removeFromParent()
//                PauseMenuHandler.instance.mainMenuButtonItalian.removeFromParent()

                stopScene = false
    //            self.isPaused = false
            }
        }
        
        if(touchLocation != characterFeetCollider.position){
            if(touchedNode.name != "overlayDescription" && touchedNode.name != "closePause" && touchedNode.name != "closeInfo" &&  !(touchedNode.name == "diary" && characterFeetCollider.frame.intersects(diaryZoneInteractionCollider.frame))){
                if(!stopScene){
                    CharacterMovementHandler.instance.characterMovementSingle(touchLocation: touchLocation, characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        CharacterMovementHandler.instance.moveAndMoveSingleToggle()
        for touch in touches {
            CharacterMovementHandler.instance.location = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        CharacterMovementHandler.instance.checkStoppingFrame(characterAvatar: characterAvatar)
        CharacterMovementHandler.instance.resetWalkingVariables()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        //Se almeno una delle due variabili responsabili del movimento sono impostate a "true" allora inizia il movimento
        //Controllo se la posizione del tocco dello schermo è in alto, in basso, a sinistra o a destra rispetto alla posizione corrente del personaggio ed effettuo il movimento di conseguenza.
        //N.B.: Per cambiare la velocità di movimento basta cambiare il valore dopo i +=
        if(!stopScene){
            if(Level0VariableHadnler.instance.bigKeyPick && Level0VariableHadnler.instance.dollObject){
                dollCreepy.alpha = 1
            }else{
                dollCreepy.alpha = 0.01
            }
            
            if(Level0VariableHadnler.instance.dollObject && Level0VariableHadnler.instance.bigKeyPick && characterFeetCollider.frame.intersects(dollCreepyZoneInteraction.frame)){
                if(!Level0VariableHadnler.instance.once){
                    blackEffect.alpha = 0.7
                    dollCreepy.zPosition = 51
                    cameraNode.addChild(dollCreepyInteractionLabel)
                    characterAvatar.zPosition = 52
                    blackEffect.zPosition = 50
                    stopScene = true
                    dollCreepyInteractionLabel.run(SKAction.fadeOut(withDuration: 3) , completion: {
                        self.stopScene = false
                        self.dollCreepyInteractionLabel.removeFromParent()
                        self.blackEffect.alpha = 0.01
                        Level0VariableHadnler.instance.once = true
                    })
    //                dollCreepyInteractionLabel.run(SKAction.fadeOut(withDuration: 5))
                    if(LanguageHandler.instance.language == "English"){
                        dollCreepyInteractionLabel.text = "Hi Dear..."
                    }else
                    if(LanguageHandler.instance.language == "Italian"){
                        dollCreepyInteractionLabel.text = "Salve a te..."
                    }
                }else{
                    dollCreepy.zPosition = 11
                }
                    
            }
//            else{
//                dollCreepyInteractionLabel.removeFromParent()
//                blackEffect.alpha = 0.01
//
//                }
            
            CharacterMovementHandler.instance.characterMovement(characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)
            //Alla fine della funzione di update vado ad impostare la posizione dell'avatar del personaggio in relazione a quella del collider dei piedi
            characterAvatar.position = characterFeetCollider.position
            characterAvatar.position.y = characterAvatar.position.y - 8
            //Vado poi a centrare la camera sul personaggio
            cameraNode.position = characterAvatar.position
            //Metto la camera di gioco un po' pià in alto così si vede la cima della stanza
            cameraNode.position.y += size.height*0.2
            
            checkCollisions()
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
       
        if(contactA == "player" || contactB == "player"){
            if(contactA == "doorColliderTopRT" || contactB == "doorColliderTopRT"){
//                let room4 = Level00_4(size: size)
//                view?.presentScene(room4)
                if(!transitioning){
                    transitioning = true
                    blackCover.removeFromParent()
                    let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
                    blackCover.alpha = 0
                    cameraNode.addChild(blackCover)
                    blackCover.run(fadeInAction)
                    
                    musicHandler.instance.pauseBackgroundMusic()

                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.removeAllChildren()
                        
                        let room4 = Level00_4(size: self.size)
                        self.view?.presentScene(room4)
                    }
                }
            } else if(contactA == "doorColliderTopLF" || contactB == "doorColliderTopLF"){
//                let room2 = Level00_2(size: size)
//                view?.presentScene(room2)
                if(!transitioning){
                    transitioning = true
                    blackCover.removeFromParent()
                    let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
                    blackCover.alpha = 0
                    cameraNode.addChild(blackCover)
                    blackCover.run(fadeInAction)
                    
                    musicHandler.instance.pauseBackgroundMusic()

                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.removeAllChildren()
                        
                        let room2 = Level00_2(size: self.size)
                        self.view?.presentScene(room2)
                    }
                }
            }
        }
    }
    
    func checkCollisions(){
        if(characterFeetCollider.frame.intersects(armchairsTransparencyCollider.frame)){
            chairCollider = true
            characterAvatar.zPosition = 10
            armachair.zPosition = 11
            dollCreepy.zPosition = 12
        } else{
            if(chairCollider){
                chairCollider = false
                characterAvatar.zPosition = 11
                armachair.zPosition = 10
                dollCreepy.zPosition = 11
            }
        }
        
        if(characterFeetCollider.frame.intersects(bookTransparencyCollider.frame)){
            booksCollided = true
            characterAvatar.zPosition = 10
            diary.zPosition = 11
            books.zPosition = 11
            diary.zPosition = 11
        } else{
            if(booksCollided){
                booksCollided = false
                characterAvatar.zPosition = 12
                diary.zPosition = 10
                books.zPosition = 10
                diary.zPosition = 10
            }
        }
        
    }
    
    
    
    func roomSetUp(){
        room.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        room.xScale = size.width*0.001
        room.yScale = size.width*0.001
        room.zPosition = -1
        
        barrierDownRT.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        barrierDownRT.xScale = size.width*0.001
        barrierDownRT.yScale = size.width*0.001
        barrierDownRT.physicsBody = SKPhysicsBody(texture: barrierDownRT.texture!, size: barrierDownRT.size)
        barrierDownRT.physicsBody?.affectedByGravity = false
        barrierDownRT.physicsBody?.restitution = 0
        barrierDownRT.physicsBody?.allowsRotation = false
        barrierDownRT.physicsBody?.isDynamic = false
        barrierDownRT.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        barrierDownRT.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        barrierDownRT.alpha = 0.01
        barrierDownRT.name = "outerBarrier"
        
        barrierDownLF.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        barrierDownLF.xScale = size.width*0.001
        barrierDownLF.yScale = size.width*0.001
        barrierDownLF.physicsBody = SKPhysicsBody(texture: barrierDownLF.texture!, size: barrierDownLF.size)
        barrierDownLF.physicsBody?.affectedByGravity = false
        barrierDownLF.physicsBody?.restitution = 0
        barrierDownLF.physicsBody?.allowsRotation = false
        barrierDownLF.physicsBody?.isDynamic = false
        barrierDownLF.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        barrierDownLF.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        barrierDownLF.alpha = 0.01
        barrierDownLF.name = "outerBarrier"
        
        barrierTopRT.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        barrierTopRT.xScale = size.width*0.001
        barrierTopRT.yScale = size.width*0.001
        barrierTopRT.physicsBody = SKPhysicsBody(texture: barrierTopRT.texture!, size: barrierTopRT.size)
        barrierTopRT.physicsBody?.affectedByGravity = false
        barrierTopRT.physicsBody?.restitution = 0
        barrierTopRT.physicsBody?.allowsRotation = false
        barrierTopRT.physicsBody?.isDynamic = false
        barrierTopRT.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        barrierTopRT.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        barrierTopRT.alpha = 0.01
        barrierTopRT.name = "outerBarrier"
        
        barrierTopLF.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        barrierTopLF.xScale = size.width*0.001
        barrierTopLF.yScale = size.width*0.001
        barrierTopLF.physicsBody = SKPhysicsBody(texture: barrierTopLF.texture!, size: barrierTopLF.size)
        barrierTopLF.physicsBody?.affectedByGravity = false
        barrierTopLF.physicsBody?.restitution = 0
        barrierTopLF.physicsBody?.allowsRotation = false
        barrierTopLF.physicsBody?.isDynamic = false
        barrierTopLF.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        barrierTopLF.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        barrierTopLF.alpha = 0.01
        barrierTopLF.name = "outerBarrier"
        
        characterAvatar.anchorPoint = CGPoint(x: 0.5,y: 0)
        characterAvatar.xScale = size.width*0.0004
        characterAvatar.yScale = size.width*0.0004
        characterAvatar.zPosition = 5
        characterAvatar.name = "player"
        if(previousRoom == "Room2"){
            characterFeetCollider.position = CGPoint(x: size.width*0,y: size.height*0.3)
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopRight")))
        }else {
            characterFeetCollider.position = CGPoint(x: size.width*1.18,y: size.height*0.2)
        }
        characterFeetCollider.xScale = size.width*0.001
        characterFeetCollider.yScale = size.width*0.001
        characterFeetCollider.physicsBody = SKPhysicsBody(texture: characterFeetCollider.texture!, size: characterFeetCollider.size)
        characterFeetCollider.physicsBody?.affectedByGravity = false
        characterFeetCollider.physicsBody?.restitution = 0
        characterFeetCollider.physicsBody?.allowsRotation = false
        characterFeetCollider.physicsBody?.categoryBitMask = PhysicsCategories.Player
        characterFeetCollider.physicsBody?.contactTestBitMask = PhysicsCategories.MapEdge
        characterFeetCollider.name = "player"
        characterFeetCollider.alpha = 0.01

        
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: -gameArea.size.width*0.4, y: gameArea.size.height*0.9 + CGFloat(10))
        pauseButton.zPosition = 30
        pauseButton.xScale = size.width*0.0001
        pauseButton.yScale = size.width*0.0001
        
        doorColliderTopRT.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        doorColliderTopRT.name = "doorColliderTopRT"
        doorColliderTopRT.alpha = 0.01
        doorColliderTopRT.xScale = size.width*0.001
        doorColliderTopRT.yScale = size.width*0.001
        doorColliderTopRT.physicsBody = SKPhysicsBody(texture: doorColliderTopRT.texture!, size: doorColliderTopRT.size)
        doorColliderTopRT.physicsBody?.affectedByGravity = false
        doorColliderTopRT.physicsBody?.restitution = 0
        doorColliderTopRT.physicsBody?.allowsRotation = false
        doorColliderTopRT.physicsBody?.isDynamic = false
        doorColliderTopRT.physicsBody?.categoryBitMask = PhysicsCategories.LowerDoor
        doorColliderTopRT.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        
        doorColliderTopLF.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        doorColliderTopLF.name = "doorColliderTopLF"
        doorColliderTopLF.alpha = 0.01
        doorColliderTopLF.xScale = size.width*0.001
        doorColliderTopLF.yScale = size.width*0.001
        doorColliderTopLF.physicsBody = SKPhysicsBody(texture: doorColliderTopLF.texture!, size: doorColliderTopLF.size)
        doorColliderTopLF.physicsBody?.affectedByGravity = false
        doorColliderTopLF.physicsBody?.restitution = 0
        doorColliderTopLF.physicsBody?.allowsRotation = false
        doorColliderTopLF.physicsBody?.isDynamic = false
        doorColliderTopLF.physicsBody?.categoryBitMask = PhysicsCategories.LowerDoor
        doorColliderTopLF.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        

        doorRT.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        doorRT.name = "doorRT"
        doorRT.alpha = 1
        doorRT.xScale = size.width*0.001
        doorRT.yScale = size.width*0.001
        
        doorLF.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        doorLF.name = "doorLF"
        doorLF.alpha = 1
        doorLF.xScale = size.width*0.001
        doorLF.yScale = size.width*0.001
 
        armachair.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        armachair.xScale = size.width*0.001
        armachair.yScale = size.width*0.001
        armachair.zPosition = 3
        colliderArmchairLeft.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        colliderArmchairLeft.xScale = size.width*0.001
        colliderArmchairLeft.yScale = size.width*0.001
        colliderArmchairLeft.alpha = 0.01
        colliderArmchairLeft.physicsBody = SKPhysicsBody(texture: colliderArmchairLeft.texture!, size: colliderArmchairLeft.size)
        colliderArmchairLeft.physicsBody?.affectedByGravity = false
        colliderArmchairLeft.physicsBody?.restitution = 0
        colliderArmchairLeft.physicsBody?.allowsRotation = false
        colliderArmchairLeft.physicsBody?.isDynamic = false
        colliderArmchairLeft.zPosition = 3
        colliderArmchairRight.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        colliderArmchairRight.xScale = size.width*0.001
        colliderArmchairRight.yScale = size.width*0.001
        colliderArmchairRight.alpha = 0.01
        colliderArmchairRight.physicsBody = SKPhysicsBody(texture: colliderArmchairRight.texture!, size: colliderArmchairRight.size)
        colliderArmchairRight.physicsBody?.affectedByGravity = false
        colliderArmchairRight.physicsBody?.restitution = 0
        colliderArmchairRight.physicsBody?.allowsRotation = false
        colliderArmchairRight.physicsBody?.isDynamic = false
        colliderArmchairRight.zPosition = 3
        
        colliderTrasparencyChair.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        colliderTrasparencyChair.xScale = size.width*0.001
        colliderTrasparencyChair.yScale = size.width*0.001
        colliderTrasparencyChair.alpha = 0.01
        armchairsTransparencyCollider.position = CGPoint(x: size.width*0.5, y: size.height*0.41)
        armchairsTransparencyCollider.xScale = size.width*0.001
        armchairsTransparencyCollider.yScale = size.width*0.001
        armchairsTransparencyCollider.alpha = 0.01
        
        lamp.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        lamp.xScale = size.width*0.001
        lamp.yScale = size.width*0.001
        lamp.zPosition = 3
        colliderLamp.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        colliderLamp.xScale = size.width*0.001
        colliderLamp.yScale = size.width*0.001
        colliderLamp.alpha = 0.01
        colliderLamp.physicsBody = SKPhysicsBody(texture: colliderLamp.texture!, size: colliderLamp.size)
        colliderLamp.physicsBody?.affectedByGravity = false
        colliderLamp.physicsBody?.allowsRotation = false
        colliderLamp.physicsBody?.restitution = 0
        colliderLamp.physicsBody?.isDynamic = false
        colliderLamp.zPosition = 3
        
        books.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        books.xScale = size.width*0.001
        books.yScale = size.width*0.001
        books.zPosition = 3
        colliderBook.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        colliderBook.xScale = size.width*0.001
        colliderBook.yScale = size.width*0.001
        colliderBook.alpha = 0.01
        colliderBook.physicsBody = SKPhysicsBody(texture: colliderBook.texture!, size: colliderBook.size)
        colliderBook.physicsBody?.affectedByGravity = false
        colliderBook.physicsBody?.allowsRotation = false
        colliderBook.physicsBody?.isDynamic = false
        colliderBook.physicsBody?.restitution = 0
        colliderBook.zPosition = 3
        bookTransparencyCollider.position = CGPoint(x: size.width*0.705, y: size.height*0.2)
        bookTransparencyCollider.xScale = size.width*0.001
        bookTransparencyCollider.yScale = size.width*0.001
        bookTransparencyCollider.zPosition = 3
        bookTransparencyCollider.alpha = 0.01
        
        iButton.name = "infoButton"
        iButton.zPosition = 30
        iButton.position = CGPoint(x: gameArea.size.width*0.4, y: gameArea.size.height*0.9 + CGFloat(10))
        iButton.xScale = size.width*0.0001
        iButton.yScale = size.width*0.0001

        infoOpacityOverlay.zPosition = 100
        infoOpacityOverlay.name = "closeInfo"
        infoOpacityOverlay.strokeColor = .black
        infoOpacityOverlay.fillColor = .black
        infoOpacityOverlay.alpha = 0.6
        infoBackground.zPosition = 101
        infoBackground.name = "closeInfo"
        infoBackground.xScale = size.width*0.0017
        infoBackground.yScale = size.width*0.0008
        infoBackground.position = CGPoint(x: -gameArea.size.width*0.02, y: gameArea.size.height*0)
        infoText.zPosition = 102
        infoText.name = "closeInfo"
        infoText.fontSize = size.width*0.05
        infoText.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.2)
        infoText2.zPosition = 102
        infoText2.name = "closeInfo"
        infoText2.fontSize = size.width*0.05
        infoText2.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.1)
        if(LanguageHandler.instance.language == "English"){
            infoText.text = LanguageHandler.instance.infoTextOneEnglish
            infoText2.text = LanguageHandler.instance.infoTextTwoEnglish
        } else if (LanguageHandler.instance.language == "Italian"){
            infoText.text = LanguageHandler.instance.infoTextOneItalian
            infoText2.text = LanguageHandler.instance.infoTextTwoItalian
        }
        infoText.preferredMaxLayoutWidth = size.width*0.9
        infoText.numberOfLines = 0
        infoText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoText.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.32)
        infoText2.preferredMaxLayoutWidth = size.width*0.9
        infoText2.numberOfLines = 0
        infoText2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoText2.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.2)
        
        diary.position = CGPoint(x: gameArea.size.width*0.7, y: gameArea.size.height*0.5)
        diary.xScale = size.width*0.00023
        diary.yScale = size.width*0.00023
        diary.zPosition = 3
        diary.name = "diary"
        
        diaryZoneInteractionCollider.position = CGPoint(x: gameArea.size.width*0.65, y: gameArea.size.height*0.45)
        diaryZoneInteractionCollider.zPosition = 4
        diaryZoneInteractionCollider.strokeColor = .red
        diaryZoneInteractionCollider.fillColor = .red
        diaryZoneInteractionCollider.alpha = 0.01
        
        overlayDescription.zPosition = 121
        overlayDescription.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0)
        overlayDescription.xScale = size.width*0.0012
        overlayDescription.yScale = size.width*0.0012
        overlayDescription.name = "overlayDescription"
        
        infoOpacityOverlayDiary.strokeColor = .black
        infoOpacityOverlayDiary.fillColor = .black
        infoOpacityOverlayDiary.alpha = 0.6
        infoOpacityOverlayDiary.zPosition = 120
        infoOpacityOverlayDiary.position = CGPoint(x: size.width*0, y: size.height*0)
        
        
        infoDiary.preferredMaxLayoutWidth = size.width*0.9
        infoDiary.numberOfLines = 0
        infoDiary.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoDiary.fontSize = size.width*0.045
        infoDiary.fontColor = SKColor.white
        infoDiary.zPosition = 121
        infoDiary.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.15)
        infoDiary1.preferredMaxLayoutWidth = size.width*0.9
        infoDiary1.numberOfLines = 0
        infoDiary1.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoDiary1.fontSize = size.width*0.045
        infoDiary1.fontColor = SKColor.white
        infoDiary1.zPosition = 121
        infoDiary1.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.5)
        infoDiaryy2.preferredMaxLayoutWidth = size.width*0.9
        infoDiaryy2.numberOfLines = 0
        infoDiaryy2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoDiaryy2.fontSize = size.width*0.045
        infoDiaryy2.fontColor = SKColor.white
        infoDiaryy2.zPosition = 121
        infoDiaryy2.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.5)
//        infoDiary.fontSize = size.width*0.05
//        infoDiary.fontColor = SKColor.white
//        infoDiary.zPosition = 122
//        infoDiary.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.2)
//        infoDiary.fontSize = size.width*0.05
//        infoDiary1.zPosition = 122
//        infoDiary1.fontColor = SKColor.white
//        infoDiary1.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.3)
//        infoDiaryy2.fontSize = size.width*0.05
//        infoDiaryy2.fontColor = SKColor.white
//        infoDiaryy2.zPosition = 122
//        infoDiaryy2.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)

        tappableQuit.strokeColor = .black
        tappableQuit.fillColor = .black
        tappableQuit.alpha = 0.01
        tappableQuit.zPosition = 150
        tappableQuit.position = CGPoint(x: size.width*0, y: size.height*0)
        tappableQuit.name = "overlayDescription"
        
        dollCreepy.position = CGPoint(x: size.width*0.35, y: size.height*0.45)
        dollCreepy.zPosition = 20
        dollCreepy.xScale = size.width*0.0003
        dollCreepy.yScale = size.width*0.0003
        dollCreepy.alpha = 0.01
        
        dollCreepyZoneInteraction.position = CGPoint(x: size.width*0.35, y: size.height*0.35)
        dollCreepyZoneInteraction.zPosition = 20
        dollCreepyZoneInteraction.alpha = 0.01
        dollCreepyZoneInteraction.fillColor = .red
        dollCreepyZoneInteraction.strokeColor = .red
        
        blackEffect.position = CGPoint(x: size.width*0, y: size.height*0)
        blackEffect.zPosition = 10
        blackEffect.alpha = 0.01
        blackEffect.fillColor = .black
        blackEffect.strokeColor = .black

        dollCreepyInteractionLabel.fontColor = SKColor.white
        dollCreepyInteractionLabel.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        dollCreepyInteractionLabel.fontSize = size.width*0.04
        dollCreepyInteractionLabel.zPosition = 150
    }
}

