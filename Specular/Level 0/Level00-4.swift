//
//  Level00-4.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit
import SwiftUI

//let furnitureFrames: [SKTexture] = []


class Level00_4: SKScene, SKPhysicsContactDelegate {
    @AppStorage("language") var language: String = "English"
    
    let blurFurniture = SKSpriteNode(imageNamed: "BlurFurnitureRoom4")

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
    
    //    cose relative alla chiave nel cassetto
    let Key = SKSpriteNode(imageNamed: "Key")
    let keyLabel = SKLabelNode(fontNamed: "MonoSF")
    let overlayDescription = SKSpriteNode(imageNamed: "DropKey2")
    
    let infoKey = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish11)
//    let infoKey1 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish21)
//    let infoKey2 = SKLabelNode(text: LanguageHandler.instance.objectiveEnglish31)
    let infoOpacityOverlayKey = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let bigOverlay = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    var keyObject : Bool = false
    
    //    prova animazione cassettone
    var open: Bool = false
//        var openClose = SKSpriteNode()
//        var TextureAtlas = SKTextureAtlas()
//        var TextureArray = [SKTexture]()
        
    
    //Bottone che apre il menu di pausa
    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    
    
    //Divido il personaggio in due parti, una è il collider per i piedi, per gestire le interazioni con gli altri collider per dove il personaggio può camminare, l'altra è l'avatar in sè
    let characterAvatar = SKSpriteNode(imageNamed: "Stop")
    let characterFeetCollider = SKSpriteNode(imageNamed: "CharacterFeet2")
    
    //Definisco i nodi che creano la stanza di gioco
    let room = SKSpriteNode(imageNamed: "Level0-Room4-Background")
    let rightBarrier = SKSpriteNode(imageNamed: "Level0-Room4-RightBarrier")
    let lowerBarrier = SKSpriteNode(imageNamed: "Level0-Room4-LowerBarrier")
    let topBarrier = SKSpriteNode(imageNamed: "Level0-Room4-TopBarrier")
    let leftBarrier = SKSpriteNode(imageNamed: "Level0-Room4-LeftBarrier")
    let curtain = SKSpriteNode(imageNamed: "Level0-Room4-Curtain")
    let furniture = SKSpriteNode(imageNamed: "Level0-Room4-Furniture")
//    let furniture = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureClosedSingle")
    let furnitureInteractionCollider = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureInteractionCollider")
    let box = SKSpriteNode(imageNamed: "Level0-Room4-Box")
    let furnitureCollider = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureCollider")
    let boxCollider = SKSpriteNode(imageNamed: "Level0-Room4-BoxCollider")
    let lowerDoor = SKSpriteNode(imageNamed: "Level0-Room4-LowerDoor")
    let rightDoor = SKSpriteNode(imageNamed: "Level0-Room4-RightRoom")
 
    let furnitureZoneInteractionCollider: SKShapeNode
    let furnitureZoneInteractionCollider2: SKShapeNode
    let furnitureZoneInteractionCollider3: SKShapeNode
    
    //Variabili usate per il movimento del personaggio

    var location = CGPoint.zero

    
//    suoni
    var cassetto2 : String = "cassetto"
    let cassettiera2 = SKAction.playSoundFileNamed("cassetto", waitForCompletion: false)
    
    //Camera di gioco
    let cameraNode = SKCameraNode()
 
    var stopScene: Bool = false
    
    let gameArea: CGRect
    
    override init(size: CGSize) {
        
        furnitureZoneInteractionCollider = SKShapeNode(rectOf: CGSize(width: size.width*0.7, height: size.height*0.1))
        furnitureZoneInteractionCollider2 = SKShapeNode(rectOf: CGSize(width: size.width*0.3, height: size.height*0.07))
        furnitureZoneInteractionCollider3 = SKShapeNode(rectOf: CGSize(width: size.width*0.6, height: size.height*0.07))

        
        
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

        
//        TextureAtlas = SKTextureAtlas(named: "frame")
//        le immagini della texture atlas le metto nel TextureArray
//        for i in 1...TextureAtlas.textureNames.count{
//            var frame = "Frame_\(i)"
//            TextureArray.append(SKTexture(imageNamed: frame))
//        }
//        openClose = SKSpriteNode(imageNamed: TextureAtlas.textureNames[0])
//        self.addChild(openClose)
        //Per non imputtanire troppo il codice, metto le impostazioni più lunghe in un'altra funzione definita sempre nella classe e la richiamo qui, così almeno sembra un po' più pulito
        roomSetup()
        addChild(room)
        addChild(characterAvatar)
        addChild(characterFeetCollider)
        addChild(rightBarrier)
        addChild(lowerBarrier)
        addChild(topBarrier)
        addChild(leftBarrier)
        addChild(curtain)
        addChild(box)
        addChild(furniture)
        addChild(furnitureInteractionCollider)
        addChild(furnitureCollider)
        addChild(boxCollider)
        addChild(lowerDoor)
        addChild(rightDoor)
//        addChild(Key)
        addChild(furnitureZoneInteractionCollider3)
        addChild(furnitureZoneInteractionCollider2)
        addChild(furnitureZoneInteractionCollider)
        cameraNode.addChild(iButton)
        addChild(blurFurniture)
        
        //Aggiungo la camera di gioco
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
                
        
        self.scene?.physicsWorld.contactDelegate = self
        
        previousRoom = "Room4"
    }
    
    //Funzione che rileva il tocco
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        //Ricavo la posizione sullo schermo del tocco e di eventuali nodi toccati
        let touchLocation = touch.location(in: self)
        let touchedNode = atPoint(touchLocation)
        
        //Se scelgo dal menu di pausa di tornare indietro, fermo la musica del livello e torno al menu principale
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
        
        //Se tocco il cassettone si apre, se ritocco si chiude, TO DO: Aggiungere una condizione che permette di aprire e chiudere il cassettone solamente se si è nelle vicinanz del cassettone
        if(touchedNode.name == "furniture" && ((characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider2.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider3.frame)))){
            if(!musicHandler.instance.mutedSFX){
                run(cassettiera2)
            }
            if(!open){
                keyObject = true
                open = true
//                Key.removeFromParent()
                if(!Level0VariableHadnler.instance.smallKeyPick){
                    addChild(Key)
                    cameraNode.addChild(keyLabel)
                    keyLabel.run(SKAction.fadeOut(withDuration: 5))
                }
                furniture.run(SKAction.setTexture(SKTexture(imageNamed: "Level0-Room4-FurnitureOpen")))
                Key.zPosition = 11
                if(LanguageHandler.instance.language == "English"){
                    keyLabel.text = "Such a small key..."
                }else
                if(LanguageHandler.instance.language == "Italian"){
                    keyLabel.text = "È una chave molto piccola..."
                }
            } else if (open){
                if(!musicHandler.instance.mutedSFX){
                    run(cassettiera2)
                }
                furniture.run(SKAction.setTexture(SKTexture(imageNamed: "Level0-Room4-Furniture")))
                open = false
                keyLabel.removeFromParent()
                keyObject = false
                if(!Level0VariableHadnler.instance.smallKeyPick){
                    Key.removeFromParent()
                }
//                addChild(Key)
//                Key.zPosition = 1
            }
        }
        
        if(touchedNode.name == "key" && ((characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider2.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider3.frame)))){
            print("chiave presa")
            Level0VariableHadnler.instance.smallKeyPick = true
            stopScene = true
            let xScaleKey = SKAction.scaleX(to: size.width*0.0012, duration: 0.3)
            let yScaleKey = SKAction.scaleY(to: size.width*0.0012, duration: 0.3)
            Level0VariableHadnler.instance.keyOpenSmall = true
            if(LanguageHandler.instance.language == "English"){
                infoKey.text = LanguageHandler.instance.objectiveEnglish11
//                infoKey1.text = LanguageHandler.instance.objectiveEnglish21
//                infoKey2.text = LanguageHandler.instance.objectiveEnglish31
            }else
            if(LanguageHandler.instance.language == "Italian"){
                infoKey.text = LanguageHandler.instance.objectiveItalian11
//                infoKey1.text = LanguageHandler.instance.objectiveItalian21
//                infoKey2.text = LanguageHandler.instance.objectiveItalian21
            }
            cameraNode.addChild(infoOpacityOverlayKey)
            cameraNode.addChild(overlayDescription)
            overlayDescription.xScale = 0
            overlayDescription.yScale = 0
            overlayDescription.run(xScaleKey)
            overlayDescription.run(yScaleKey, completion: {
                self.cameraNode.addChild(self.infoKey)
                self.cameraNode.addChild(self.bigOverlay)
            })
//            keyLabel1.run(SKAction.fadeOut(withDuration: 5))
            Key.removeFromParent()
//            self.isPaused = true
            keyLabel.removeFromParent()
        }
        
        if(touchedNode.name == "overlayDescription"){
//            self.isPaused = false
            infoOpacityOverlayKey.removeFromParent()
            infoKey.removeFromParent()
//            infoKey1.removeFromParent()
//            infoKey2.removeFromParent()
            overlayDescription.removeFromParent()
            bigOverlay.removeFromParent()
            stopScene = false
//            self.isPaused = false
        }
        
        
        if(touchedNode.name == "infoButton" ){
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
        
        
        //Se clicco in un punto qulasiasi dello schermo la cui posizione è diversa da quella del personaggio allora inizio il movimento del personaggio impostando la variabile moveSingle a true. Questo movimento del personaggio sul tap singolo dello schermo mi serve per fare una transizione fluida dal "non tocco" (quando il personaggio è fermo) dello schermo al "tocco continuo dello schermo" (quando il personaggio è in movimento e posso direzionare il suo spostamento muovendo il dito sullo schermo)
        //Assegno il valore della posizione del tocco alla variabile "location" così posso usare questo valore anche fuori da questa funzione, lo uso in particolare nella funzione di "update"
        if(touchLocation != characterFeetCollider.position){
            if(touchedNode.name != "pause" && touchedNode.name != "closePause" && touchedNode.name != "closeInfo" && touchedNode.name != "infoButton" &&
            !(touchedNode.name == "furniture" && ((characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider2.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider3.frame)))) &&
            !(touchedNode.name == "key" && ((characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider2.frame)) || (characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider3.frame))))){
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
        //Se la collisione che si è verificata ha come protagonisti il personaggio e la porta sul lato inferiore della stanza allora avvia la transizione alla nuova stanza
        if(contactA == "player" || contactB == "player"){
            if(contactA == "lowerDoor" || contactB == "lowerDoor"){
//                print("Lower")
                //TO DO: transizione verso la nuova stanza, stanza precedente
//                let nextRoom = Level00_3(size: size)
//                view?.presentScene(nextRoom)
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
                        
                        let nextRoom = Level00_3(size: self.size)
                        self.view?.presentScene(nextRoom)
                    }
                }
            } else if(contactA == "rightDoor" || contactB == "rightDoor"){
//                print("Right")
                //TO DO: transizione verso la nuova stanza, sgabuzzino
//                let nextRoom = Level00_5(size: size)
//                view?.presentScene(nextRoom)
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
                        
                        let nextRoom = Level00_5(size: self.size)
                        self.view?.presentScene(nextRoom)
                        
                    }
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //Se almeno una delle due variabili responsabili del movimento sono impostate a "true" allora inizia il movimento
        //Controllo se la posizione del tocco dello schermo è in alto, in basso, a sinistra o a destra rispetto alla posizione corrente del personaggio ed effettuo il movimento di conseguenza.
        //N.B.: Per cambiare la velocità di movimento basta cambiare il valore dopo i +=
        if(!stopScene){
            if(characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider2.frame) || characterFeetCollider.frame.intersects(furnitureZoneInteractionCollider3.frame)){
                blurFurniture.alpha = 0.8
                    }else{
                        blurFurniture.alpha = 0.01
                    }
            
            CharacterMovementHandler.instance.characterMovement(characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)

            
            //Alla fine della funzione di update vado ad impostare la posizione dell'avatar del personaggio in relazione a quella del collider dei piedi
            characterAvatar.position = characterFeetCollider.position
            characterAvatar.position.y = characterAvatar.position.y - 8
            //Vado poi a centrare la camera sul personaggio
            cameraNode.position = characterAvatar.position
            //Metto la camera di gioco un po' pià in alto così si vede la cima della stanza
            cameraNode.position.y += size.height*0.2
            
        }
        //Funzione che controlla le intersezioni tra gli oggetti
//        checkCollisions()
        
    
    }
    
    //Funzione per creare definire le impostazioni dei nodi della stanza
    func roomSetup(){
        //        prova cassettone
//                openClose.xScale = 0.4
//                openClose.yScale = 0.4
//                openClose.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
//                openClose.zPosition = 5
//                openClose.name = "cassettone"
        //Impostazioni riguardanti il collider dei piedi e il personaggio stesso
        characterAvatar.anchorPoint = CGPoint(x: 0.5,y: 0)
        characterAvatar.xScale = size.width*0.0004
        characterAvatar.yScale = size.width*0.0004
        characterAvatar.zPosition = 5
        characterAvatar.name = "player"
        if(previousRoom == "Room3"){
            characterFeetCollider.position = CGPoint(x: size.width*0.25,y: size.height*0.13)
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopBackRight")))
        } else {
            characterFeetCollider.position = CGPoint(x: size.width*0.89,y: size.height*0.15)
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopBackLeft")))
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
        //Impostazioni riguardanti il bottone che apre il menu di pausa
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: -gameArea.size.width*0.4, y: gameArea.size.height*0.9 + CGFloat(10))
        pauseButton.zPosition = 30
        pauseButton.xScale = size.width*0.0001
        pauseButton.yScale = size.width*0.0001
        //Impostazioni relative al background della stanza
        room.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        room.xScale = size.width*0.001
        room.yScale = size.width*0.001
        room.zPosition = 1
        //Impostazioni relative alle barriere che creano i confini della stanza
        rightBarrier.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        rightBarrier.xScale = size.width*0.001
        rightBarrier.yScale = size.width*0.001
        rightBarrier.physicsBody = SKPhysicsBody(texture: rightBarrier.texture!, size: rightBarrier.size)
        rightBarrier.physicsBody?.affectedByGravity = false
        rightBarrier.physicsBody?.restitution = 0
        rightBarrier.physicsBody?.allowsRotation = false
        rightBarrier.physicsBody?.isDynamic = false
        rightBarrier.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        rightBarrier.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        rightBarrier.alpha = 0.01
        rightBarrier.name = "outerBarrier"
        lowerBarrier.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        lowerBarrier.xScale = size.width*0.001
        lowerBarrier.yScale = size.width*0.001
        lowerBarrier.physicsBody = SKPhysicsBody(texture: lowerBarrier.texture!, size: lowerBarrier.size)
        lowerBarrier.physicsBody?.affectedByGravity = false
        lowerBarrier.physicsBody?.restitution = 0
        lowerBarrier.physicsBody?.allowsRotation = false
        lowerBarrier.physicsBody?.isDynamic = false
        lowerBarrier.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        lowerBarrier.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        lowerBarrier.alpha = 0.01
        lowerBarrier.name = "outerBarrier"
        topBarrier.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        topBarrier.xScale = size.width*0.001
        topBarrier.yScale = size.width*0.001
        topBarrier.physicsBody = SKPhysicsBody(texture: topBarrier.texture!, size: topBarrier.size)
        topBarrier.physicsBody?.affectedByGravity = false
        topBarrier.physicsBody?.restitution = 0
        topBarrier.physicsBody?.allowsRotation = false
        topBarrier.physicsBody?.isDynamic = false
        topBarrier.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        topBarrier.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        topBarrier.alpha = 0.01
        topBarrier.name = "outerBarrier"
        leftBarrier.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        leftBarrier.xScale = size.width*0.001
        leftBarrier.yScale = size.width*0.001
        leftBarrier.physicsBody = SKPhysicsBody(texture: leftBarrier.texture!, size: leftBarrier.size)
        leftBarrier.physicsBody?.affectedByGravity = false
        leftBarrier.physicsBody?.restitution = 0
        leftBarrier.physicsBody?.allowsRotation = false
        leftBarrier.physicsBody?.isDynamic = false
        leftBarrier.physicsBody?.categoryBitMask = PhysicsCategories.MapEdge
        leftBarrier.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        leftBarrier.alpha = 0.01
        leftBarrier.name = "outerBarrier"
        //Impostazioni riguardanti la tenda
        curtain.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        curtain.xScale = size.width*0.001
        curtain.yScale = size.width*0.001
        curtain.zPosition = 2
        //Impostazioni riguardanti la scatola
        box.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        box.xScale = size.width*0.001
        box.yScale = size.width*0.001
        box.zPosition = 2
        boxCollider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        boxCollider.xScale = size.width*0.001
        boxCollider.yScale = size.width*0.001
        boxCollider.zPosition = 2
        boxCollider.physicsBody = SKPhysicsBody(texture: boxCollider.texture!, size: boxCollider.size)
        boxCollider.physicsBody?.affectedByGravity = false
        boxCollider.physicsBody?.restitution = 0
        boxCollider.physicsBody?.allowsRotation = false
        boxCollider.physicsBody?.isDynamic = false
        boxCollider.alpha = 0.01
        //Impostazioni riguardanti il mobiletto
//        furniture.position = CGPoint(x: size.width*0, y: size.height*0.42)
        furniture.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        furniture.xScale = size.width*0.001
        furniture.yScale = size.width*0.001
        furniture.zPosition = 4
        
//        furniture.name = "furniture"
        furnitureInteractionCollider.position = CGPoint(x: size.width*0.05, y: size.height*0.45)
        furnitureInteractionCollider.xScale = size.width*0.001
        furnitureInteractionCollider.yScale = size.width*0.001
        furnitureInteractionCollider.zPosition = 5
        furnitureInteractionCollider.alpha = 0.01
        furnitureInteractionCollider.name = "furniture"
        
        furnitureZoneInteractionCollider.position = CGPoint(x: size.width*0.1, y: size.height*0.35)
        furnitureZoneInteractionCollider.strokeColor = .red
        furnitureZoneInteractionCollider.fillColor = .red
        furnitureZoneInteractionCollider.zPosition = 6
        furnitureZoneInteractionCollider.alpha = 0.01
        furnitureZoneInteractionCollider2.position = CGPoint(x: -size.width*0.125, y: size.height*0.3)
        furnitureZoneInteractionCollider2.strokeColor = .red
        furnitureZoneInteractionCollider2.fillColor = .red
        furnitureZoneInteractionCollider2.zPosition = 6
        furnitureZoneInteractionCollider2.alpha = 0.01
        furnitureZoneInteractionCollider3.position = CGPoint(x: size.width*0, y: size.height*0.26)
        furnitureZoneInteractionCollider3.strokeColor = .red
        furnitureZoneInteractionCollider3.fillColor = .red
        furnitureZoneInteractionCollider3.zPosition = 6
        furnitureZoneInteractionCollider3.alpha = 0.01
        
        
        
        furnitureCollider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        furnitureCollider.xScale = size.width*0.001
        furnitureCollider.yScale = size.width*0.001
        furnitureCollider.zPosition = 2
        furnitureCollider.physicsBody = SKPhysicsBody(texture: furnitureCollider.texture!, size: furnitureCollider.size)
        furnitureCollider.physicsBody?.affectedByGravity = false
        furnitureCollider.physicsBody?.restitution = 0
        furnitureCollider.physicsBody?.allowsRotation = false
        furnitureCollider.physicsBody?.isDynamic = false
        furnitureCollider.alpha = 0.01
        //Impostazioni riguardanti il collider delle porte
        lowerDoor.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        lowerDoor.name = "lowerDoor"
        lowerDoor.alpha = 0.01
        lowerDoor.xScale = size.width*0.001
        lowerDoor.yScale = size.width*0.001
        lowerDoor.physicsBody = SKPhysicsBody(texture: lowerDoor.texture!, size: lowerDoor.size)
        lowerDoor.physicsBody?.affectedByGravity = false
        lowerDoor.physicsBody?.restitution = 0
        lowerDoor.physicsBody?.allowsRotation = false
        lowerDoor.physicsBody?.isDynamic = false
        lowerDoor.physicsBody?.categoryBitMask = PhysicsCategories.LowerDoor
        lowerDoor.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        rightDoor.position = CGPoint(x: size.width*0.5, y:size.height*0.5)
        rightDoor.name = "rightDoor"
        rightDoor.alpha = 0.01
        rightDoor.xScale = size.width*0.001
        rightDoor.yScale = size.width*0.001
        rightDoor.physicsBody = SKPhysicsBody(texture: rightDoor.texture!, size: rightDoor.size)
        rightDoor.physicsBody?.affectedByGravity = false
        rightDoor.physicsBody?.restitution = 0
        rightDoor.physicsBody?.allowsRotation = false
        rightDoor.physicsBody?.isDynamic = false
        rightDoor.physicsBody?.categoryBitMask = PhysicsCategories.LowerDoor
        rightDoor.physicsBody?.contactTestBitMask = PhysicsCategories.Player
        
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
        
        Key.position = CGPoint(x: size.width*0.05, y: size.height*0.45)
        Key.xScale = 0.04
        Key.yScale = 0.04
        Key.name = "key"
        
        keyLabel.fontColor = SKColor.white
        keyLabel.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        keyLabel.fontSize = size.width*0.04
        keyLabel.zPosition = 150
        
        infoOpacityOverlayKey.strokeColor = .black
        infoOpacityOverlayKey.fillColor = .black
        infoOpacityOverlayKey.alpha = 0.6
        infoOpacityOverlayKey.zPosition = 50
        infoOpacityOverlayKey.position = CGPoint(x: size.width*0, y: size.height*0)
        
        overlayDescription.zPosition = 51
        overlayDescription.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0)
        overlayDescription.xScale = size.width*0.0012
        overlayDescription.yScale = size.width*0.0012
        overlayDescription.name = "overlayDescription"
        
        
        bigOverlay.strokeColor = .black
        bigOverlay.fillColor = .black
        bigOverlay.alpha = 0.01
        bigOverlay.zPosition = 100
        bigOverlay.position = CGPoint(x: size.width*0, y: size.height*0)
        bigOverlay.name = "overlayDescription"
        
        
        infoKey.preferredMaxLayoutWidth = size.width*0.9
        infoKey.numberOfLines = 0
        infoKey.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoKey.fontSize = size.width*0.05
        infoKey.fontColor = SKColor.white
        infoKey.zPosition = 52
        infoKey.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)
        
        
        blurFurniture.position = CGPoint(x: size.width*0.51, y: size.height*0.49)
        blurFurniture.xScale = size.width*0.001
        blurFurniture.yScale = size.width*0.001
        blurFurniture.zPosition = 4
        blurFurniture.alpha = 0.01
        
//        infoKey.fontSize = size.width*0.05
//        infoKey.fontColor = SKColor.white
//        infoKey.zPosition = 52
//        infoKey.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.2)
//        infoKey1.fontSize = size.width*0.05
//        infoKey1.zPosition = 52
//        infoKey1.fontColor = SKColor.white
//        infoKey1.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.3)
//        infoKey2.fontSize = size.width*0.05
//        infoKey2.fontColor = SKColor.white
//        infoKey2.zPosition = 52
//        infoKey2.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)

    }
}

