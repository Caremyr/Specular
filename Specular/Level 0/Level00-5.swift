//
//  Level00-5.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import UIKit
import SpriteKit
import SwiftUI



class Level00_5: SKScene, SKPhysicsContactDelegate {
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
    
    let doorInteractionCollider = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureInteractionCollider")
    
    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    
    let cameraNode = SKCameraNode()

    let characterAvatar = SKSpriteNode(imageNamed: "Stop")
    let characterFeetCollider = SKSpriteNode(imageNamed: "CharacterFeet2")
    
    let room = SKSpriteNode(imageNamed: "Level0-Room5-Background")
    let boxes = SKSpriteNode(imageNamed: "Level0-Room5-BookShelf")
    let doorLF = SKSpriteNode(imageNamed: "Level0-Room5-DoorLF")
    let doorRTclosed = SKSpriteNode(imageNamed: "Door2 closed")
//    let doorRTopen = SKSpriteNode(imageNamed: "Door2 open")
    let halfWallBackground = SKSpriteNode(imageNamed: "HalfWallBackground")
    let lamp = SKSpriteNode(imageNamed: "Level0-Room5-Lamp")
    let barrierDownLF = SKSpriteNode(imageNamed: "BarrierBottomLT")
    let barrierDownRT = SKSpriteNode(imageNamed: "BarrierBottomRT")
    let barrierTopLF = SKSpriteNode(imageNamed: "BarrierTopLF")
    let barrierTopRT = SKSpriteNode(imageNamed: "BarrierTopRT")
    let doorColliderLF = SKSpriteNode(imageNamed: "DoorColliderLT")
    let doorColliderRT = SKSpriteNode(imageNamed: "DoorColliderRT")
    let halfWallCollider = SKSpriteNode(imageNamed: "ColliderHalfWall")
    let boxCollider = SKSpriteNode(imageNamed: "BoxesCollider")
    
    let colliderDoorClosed = SKSpriteNode(imageNamed: "DoorColliderRT-1")
    
    let doorZoneInteractionCollider: SKShapeNode
    let doorZoneInteractionCollider2: SKShapeNode
    let doorLable = SKLabelNode(fontNamed: "MonoSF")
    
    let blurDoor = SKSpriteNode(imageNamed: "blurDoor1")
    
    
    var interaction: Bool = false
  

    var location = CGPoint.zero
    //Variabili per gestire le animazioni
    var colliderHalfWall: Bool = false
    
    let gameArea: CGRect
    
    var stopScene: Bool = false
    
    override init(size: CGSize) {
        doorZoneInteractionCollider = SKShapeNode(rectOf: CGSize(width: size.width*0.75, height: size.height*0.1))
        doorZoneInteractionCollider2 = SKShapeNode(rectOf: CGSize(width: size.width*0.75, height: size.height*0.1))
        
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
        addChild(boxes)
        addChild(doorLF)
//        addChild(doorRTopen)
        addChild(doorRTclosed)
        addChild(characterAvatar)
        addChild(characterFeetCollider)
        addChild(lamp)
        addChild(barrierTopLF)
        addChild(barrierTopRT)
        addChild(barrierDownLF)
        addChild(barrierDownRT)
        addChild(doorColliderLF)
        addChild(doorColliderRT)
        addChild(halfWallCollider)
        addChild(halfWallBackground)
        addChild(boxCollider)
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.addChild(iButton)
        cameraNode.addChild(pauseButton)
        addChild(doorInteractionCollider)
        addChild(doorZoneInteractionCollider)
        addChild(doorZoneInteractionCollider2)
        addChild(colliderDoorClosed)
        
        addChild(blurDoor)
        
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
        
        
        self.scene?.physicsWorld.contactDelegate = self
        
        previousRoom = "Room5"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
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
    //            self.isPaused = true
                stopScene = true
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
//
//                if(musicHandler.instance.mutedMusic == true){
//                    cameraNode.addChild(PauseMenuHandler.instance.musicIconOff)
//                } else if (musicHandler.instance.mutedMusic == false){
//                    cameraNode.addChild(PauseMenuHandler.instance.musicIcon)
//                }
//
//
//                if(musicHandler.instance.mutedSFX){
//                    cameraNode.addChild(PauseMenuHandler.instance.sfxButtonOff)
//                } else if (!musicHandler.instance.mutedSFX){
//                    cameraNode.addChild(PauseMenuHandler.instance.sfxButton)
//                }
//
//                if(LanguageHandler.instance.language == "English"){
//                    cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonEnglish)
//                    cameraNode.addChild(PauseMenuHandler.instance.languageButton)
//                    cameraNode.addChild(PauseMenuHandler.instance.pauseLabel)
//                    cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonEnglish)
//                } else if (LanguageHandler.instance.language == "Italian"){
//                    cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonItalian)
//                    cameraNode.addChild(PauseMenuHandler.instance.languageButtonItalian)
//                    cameraNode.addChild(PauseMenuHandler.instance.pauseLabelItalian)
//                    cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonItalian)
//                }
//
//
//                cameraNode.addChild(PauseMenuHandler.instance.backgroundSettings)
//                cameraNode.addChild(PauseMenuHandler.instance.settingsBackground)
            }
            
        }
        
        if(touchedNode.name == "doorInteractionCollider" && (characterFeetCollider.frame.intersects(doorZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(doorZoneInteractionCollider2.frame))) {
            print("interazione")
            if(Level0VariableHadnler.instance.keyOpen){
                doorRTclosed.run(SKAction.setTexture(SKTexture(imageNamed: "Door2 open")))
//                interaction = false
                doorLable.removeFromParent()
                blurDoor.removeFromParent()
//                    doorRTclosed.removeFromParent()
                colliderDoorClosed.removeFromParent()
            } else {
                doorLable.removeFromParent()
                doorLable.removeAllActions()
                doorLable.alpha = 0
                doorRTclosed.run(SKAction.setTexture(SKTexture(imageNamed: "Door2 closed")))
                cameraNode.addChild(doorLable)
                doorLable.alpha = 1
                doorLable.run(SKAction.fadeOut(withDuration: 5))
                if(LanguageHandler.instance.language == "English"){
                    doorLable.text = "I can't open it! I need a key..."
                }else
                if(LanguageHandler.instance.language == "Italian"){
                    doorLable.text = "Non riesco ad aprirla! Ho bisogno di una chiave..."
                }
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
            if(touchedNode.name != "pause" && touchedNode.name != "closeInfo" && touchedNode.name != "infoButton" && touchedNode.name != "closePause" &&
            !(touchedNode.name == "doorInteractionCollider" && (characterFeetCollider.frame.intersects(doorZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(doorZoneInteractionCollider2.frame)))){
                if(!stopScene){
                    CharacterMovementHandler.instance.characterMovementSingle(touchLocation: touchLocation, characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)

                }
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
        if(!stopScene){
            if(characterFeetCollider.frame.intersects(doorZoneInteractionCollider.frame) ||
               characterFeetCollider.frame.intersects(doorZoneInteractionCollider2.frame)){
                blurDoor.alpha = 0.8
            }else{
                blurDoor.alpha = 0.01
            }
            
            CharacterMovementHandler.instance.characterMovement(characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)

            checkCollision()
            //Se almeno una delle due variabili responsabili del movimento sono impostate a "true" allora inizia il movimento
            //Controllo se la posizione del tocco dello schermo è in alto, in basso, a sinistra o a destra rispetto alla posizione corrente del personaggio ed effettuo il movimento di conseguenza.
            //N.B.: Per cambiare la velocità di movimento basta cambiare il valore dopo i +=

            characterAvatar.position = characterFeetCollider.position
            characterAvatar.position.y = characterAvatar.position.y - 8
            cameraNode.position = characterAvatar.position
            cameraNode.position.y += size.height*0.2
        }
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
        //Se la collisione che si è verificata ha come protagonisti il personaggio e la porta sul lato inferiore della stanza allora avvia la transizione alla nuova stanza
        if(contactA == "player" || contactB == "player"){
            if(contactA == "doorColliderLF" || contactB == "doorColliderLF"){
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
                        let room4 = Level00_4(size: self.size)
                        self.view?.presentScene(room4)
                    }
                }
                
            } else if(contactA == "doorColliderRT" || contactB == "doorColliderRT"){
                print("Right")
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
                        
                        let theEnd = TheEnd(size: self.size)
                        self.view?.presentScene(theEnd)
                    }
                }
//                let room6 = TheEnd(size: size)
//                view?.presentScene(room6)

            }
        }
    }
    
    func checkCollision(){
        if(characterFeetCollider.frame.intersects(halfWallCollider.frame)){
            colliderHalfWall = true
            characterAvatar.zPosition = 10
            doorRTclosed.zPosition = 11
        } else{
            if(colliderHalfWall){
                colliderHalfWall = false
                characterAvatar.zPosition = 11
                doorRTclosed.zPosition = 10
            }
        }
        
    }
    
    func roomSetUp(){
//        setup character
        characterAvatar.anchorPoint = CGPoint(x: 0.5,y: 0)
        characterAvatar.xScale = size.width*0.0004
        characterAvatar.yScale = size.width*0.0004
        characterAvatar.zPosition = 5
        characterAvatar.name = "player"
        if(previousRoom == "Room4"){
            characterFeetCollider.position = CGPoint(x: -size.width*0.2,y: size.height*0.1)
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopRight")))
        }
        characterFeetCollider.xScale = size.width*0.002
        characterFeetCollider.yScale = size.width*0.002
        characterFeetCollider.physicsBody = SKPhysicsBody(texture: characterFeetCollider.texture!, size: characterFeetCollider.size)
        characterFeetCollider.physicsBody?.affectedByGravity = false
        characterFeetCollider.physicsBody?.restitution = 0
        characterFeetCollider.physicsBody?.allowsRotation = false
        characterFeetCollider.physicsBody?.categoryBitMask = PhysicsCategories.Player
        characterFeetCollider.physicsBody?.contactTestBitMask = PhysicsCategories.MapEdge
        characterFeetCollider.name = "player"
        characterFeetCollider.alpha = 0.01

//      setup pause button
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: -gameArea.size.width*0.4, y: gameArea.size.height*0.9 + CGFloat(10))
        pauseButton.zPosition = 30
        pauseButton.xScale = size.width*0.0001
        pauseButton.yScale = size.width*0.0001
//        setup room
        room.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        room.xScale = size.width*0.001
        room.yScale = size.width*0.001
        room.zPosition = 1
//        setup barrier
        barrierTopRT.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
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
        barrierTopLF.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
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
        barrierDownRT.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
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
        barrierDownLF.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
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
//        setup collider
        doorColliderLF.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        doorColliderLF.xScale = size.width*0.001
        doorColliderLF.yScale = size.width*0.001
        doorColliderLF.physicsBody = SKPhysicsBody(texture: doorColliderLF.texture!, size: doorColliderLF.size)
        doorColliderLF.physicsBody?.affectedByGravity = false
        doorColliderLF.physicsBody?.restitution = 0
        doorColliderLF.physicsBody?.allowsRotation = false
        doorColliderLF.physicsBody?.isDynamic = false
        doorColliderLF.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        doorColliderLF.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        doorColliderLF.alpha = 0.01
        doorColliderLF.name = "doorColliderLF"
        
        colliderDoorClosed.position = CGPoint(x: size.width*0.30, y: size.height*0.3)
        colliderDoorClosed.xScale = size.width*0.001
        colliderDoorClosed.yScale = size.width*0.001
        colliderDoorClosed.physicsBody = SKPhysicsBody(texture: colliderDoorClosed.texture!, size: colliderDoorClosed.size)
        colliderDoorClosed.physicsBody?.affectedByGravity = false
        colliderDoorClosed.physicsBody?.restitution = 0
        colliderDoorClosed.physicsBody?.allowsRotation = false
        colliderDoorClosed.physicsBody?.isDynamic = false
        colliderDoorClosed.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        colliderDoorClosed.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        colliderDoorClosed.alpha = 0.0
       
        
        doorColliderRT.position = CGPoint(x: size.width*0.35, y: size.height*0.27)
        doorColliderRT.xScale = size.width*0.001
        doorColliderRT.yScale = size.width*0.001
        doorColliderRT.physicsBody = SKPhysicsBody(texture: doorColliderRT.texture!, size: doorColliderRT.size)
        doorColliderRT.physicsBody?.affectedByGravity = false
        doorColliderRT.physicsBody?.restitution = 0
        doorColliderRT.physicsBody?.allowsRotation = false
        doorColliderRT.physicsBody?.isDynamic = false
        doorColliderRT.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        doorColliderRT.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        doorColliderRT.alpha = 0.01
        doorColliderRT.name = "doorColliderRT"
//        setup boxes
        boxes.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        boxes.xScale = size.width*0.001
        boxes.yScale = size.width*0.001
        boxes.zPosition = 3
//        setup door left
        doorLF.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        doorLF.xScale = size.width*0.001
        doorLF.yScale = size.width*0.001
        doorLF.zPosition = 3
        doorLF.name = "doorLF"
//        setup door right
//        doorRTopen.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
//        doorRTopen.xScale = 0.4
//        doorRTopen.yScale = 0.4
        doorRTclosed.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        doorRTclosed.xScale = size.width*0.001
        doorRTclosed.yScale = size.width*0.001
        doorRTclosed.alpha = 0.95
        
        halfWallBackground.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        halfWallBackground.xScale = size.width*0.001
        halfWallBackground.yScale = size.width*0.001
        halfWallBackground.alpha = 0.8
        halfWallBackground.zPosition = 10
//        setup lamp
        lamp.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        lamp.xScale = size.width*0.001
        lamp.yScale = size.width*0.001
        lamp.zPosition = 3

        halfWallCollider.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        halfWallCollider.xScale = size.width*0.001
        halfWallCollider.yScale = size.width*0.001
        halfWallCollider.alpha = 0.01
        
        boxCollider.position = CGPoint(x: size.width*0.3, y: size.height*0.3)
        boxCollider.xScale = size.width*0.001
        boxCollider.yScale = size.width*0.001
        boxCollider.physicsBody = SKPhysicsBody(texture: boxCollider.texture!, size: boxCollider.size)
        boxCollider.physicsBody?.affectedByGravity = false
        boxCollider.physicsBody?.restitution = 0
        boxCollider.physicsBody?.allowsRotation = false
        boxCollider.physicsBody?.isDynamic = false
        boxCollider.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        boxCollider.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        boxCollider.alpha = 0.01
        
        iButton.name = "infoButton"
        iButton.zPosition = 35
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
        
        doorInteractionCollider.zPosition = 22
        doorInteractionCollider.xScale = size.width*0.002
        doorInteractionCollider.yScale = size.width*0.002
        doorInteractionCollider.position = CGPoint(x: size.width*0.9, y: size.height*0.05)
        doorInteractionCollider.alpha = 0.01
        doorInteractionCollider.name = "doorInteractionCollider"
        
        doorZoneInteractionCollider.zPosition = 21
        doorZoneInteractionCollider.fillColor = .red
        doorZoneInteractionCollider.strokeColor = .red
        doorZoneInteractionCollider.alpha = 0.01
        doorZoneInteractionCollider.position = CGPoint(x: size.width*0.6, y: -size.height*0.05)
        doorZoneInteractionCollider2.zPosition = 21
        doorZoneInteractionCollider2.fillColor = .blue
        doorZoneInteractionCollider2.strokeColor = .blue
        doorZoneInteractionCollider2.position = CGPoint(x: size.width*0.7, y: size.height*0)
        doorZoneInteractionCollider2.alpha = 0.01
        
        doorLable.fontColor = SKColor.white
        doorLable.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        doorLable.fontSize = size.width*0.04
        doorLable.zPosition = 150
        
        blurDoor.position = CGPoint(x: size.width*0.32, y: size.height*0.29)
        blurDoor.zPosition = 20
        blurDoor.xScale = size.width*0.0039
        blurDoor.yScale = size.width*0.0039
//        blurDoor.alpha = 0.9
    }
}

