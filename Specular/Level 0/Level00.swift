//
//  Level00.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//


import UIKit
import SpriteKit
import SwiftUI

let movementSpeed: CGFloat = 1.3

let walkingAnimationFramesRightUp: [SKTexture] = [SKTexture(imageNamed: "WalkingBigBackRightFrame1"), SKTexture(imageNamed: "WalkingBigBackRightFrame2")]

let walkingAnimationFramesRightDown: [SKTexture] = [SKTexture(imageNamed: "WalkingBigRightFrame1"), SKTexture(imageNamed: "WalkingBigRightFrame2")]

let walkingAnimationFramesLeftUp: [SKTexture] = [SKTexture(imageNamed: "WalkingBigBackLeftFrame1"), SKTexture(imageNamed: "WalkingBigBackLeftFrame2")]

let walkingAnimationFramesLeftDown: [SKTexture] = [SKTexture(imageNamed: "WalkingBigFrame1"), SKTexture(imageNamed: "WalkingBigFrame2")]

let walkingAnimationRightUp: SKAction = SKAction.animate(with: walkingAnimationFramesRightUp, timePerFrame: 0.25)
let walkingAnimationRightDown: SKAction = SKAction.animate(with: walkingAnimationFramesRightDown, timePerFrame: 0.25)
let walkingAnimationLeftUp: SKAction = SKAction.animate(with: walkingAnimationFramesLeftUp, timePerFrame: 0.25)
let walkingAnimationLeftDown: SKAction = SKAction.animate(with: walkingAnimationFramesLeftDown, timePerFrame: 0.25)


var previousRoom: String = "Room1"

let blurWardrobe = SKSpriteNode(imageNamed: "BlurWardrobeRoom1")
let blurBoxes = SKSpriteNode(imageNamed: "BlurBoxesRoom1-1")

struct PhysicsCategories {
    static let Player : UInt32 = 0x1 << 0
    static let MapEdge : UInt32 = 0x1 << 1
    static let LowerDoor : UInt32 = 0x1 << 2
}

class Level00: SKScene, SKPhysicsContactDelegate {
    var stopScene: Bool = false
    
    //Bottone che apre il menu di pausa
    let pauseButton = SKSpriteNode(imageNamed: "PauseButton")
    
    //Variabili che uso per fare le transizioni tra le diverse stanze
    let blackCover = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    var transitioning: Bool = false
    
    @AppStorage ("firstOpening") var firstOpening: Bool = true
    //Variabili che compongono il menu di guida al gioco
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
    
    
    //Definisco i nodi che creano la stanza di gioco
    let room = SKSpriteNode(imageNamed: "Level0-Room1")
    let rightBarrier = SKSpriteNode(imageNamed: "Level0-Room1-RightBarrier")
    let lowerBarrier = SKSpriteNode(imageNamed: "Level0-Room1-LowerBarrier")
    let topBarrier = SKSpriteNode(imageNamed: "Level0-Room1-TopBarrier")
    let leftBarrier = SKSpriteNode(imageNamed: "Level0-Room1-LeftBarrier")
    let lowerDoor = SKSpriteNode(imageNamed: "Level0-Room1-LowerDoor")
    let wardrobe = SKSpriteNode(imageNamed: "WardrobeClosedRoom1")
    let wardrobeCollider = SKSpriteNode(imageNamed: "Level0-Room1-WardrobeCollider")
    let wardrobeTransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room1-WardrobeTransparencyCollider")
//    let wardrobeShadow = SKSpriteNode(imageNamed: "Level0-Room1-WardrobeShadow")
//    let box2andShadow = SKSpriteNode(imageNamed: "Level0-Room1-Box2AndShadow")
//    let box2Single = SKSpriteNode(imageNamed: "Level0-Room1-Box2part2")
    let box2Collider = SKSpriteNode(imageNamed: "Level0-Room1-Box2Collider")
    let box2TransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room1-Boxes2TransparencyCollider")
//    let box2TransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room1-Box2TransparencyCollider")
    let box1Left = SKSpriteNode(imageNamed: "Level0-Room1-Box1Left")
    let box1LeftInteractionCollider = SKSpriteNode(imageNamed: "Level0-Room1-Box1Left")
    let box1Right = SKSpriteNode(imageNamed: "Boxes1 room1")
    let box1TransparencyCollider = SKSpriteNode(imageNamed: "Level0-Room1-Boxes1TransparencyCollider")
//    let box1Shadow = SKSpriteNode(imageNamed: "Level0-Room1-Box1Shadow")
    let box1Collider = SKSpriteNode(imageNamed: "Level0-Room1-Box1Collider")
    let wardrobeInteractionCollider = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureInteractionCollider")
    let wardrobeZoneInteractionCollider: SKShapeNode
    let wardrobeZoneInteractionCollider2: SKShapeNode
    
    
    let smalDoorClosed = SKSpriteNode(imageNamed: "SmallDoorClosed")
    let smalDoorInteraction = SKSpriteNode(imageNamed: "Level0-Room4-FurnitureInteractionCollider")
    let bigKey = SKSpriteNode(imageNamed: "KeyFinalDoor")
    let bigKeyLabel = SKLabelNode(fontNamed: "MonoSF")
    let smallDoorLabel = SKLabelNode(fontNamed: "MonoSF")
    //Macronodo che contiene tutti gli oggetti del mondo di gioco
    var worldGroup = SKSpriteNode()
    
    //Divido il personaggio in due parti, una è il collider per i piedi, per gestire le interazioni con gli altri collider per dove il personaggio può camminare, l'altra è l'avatar in sè
    let characterAvatar = SKSpriteNode(imageNamed: "Stop")
    let characterFeetCollider = SKSpriteNode(imageNamed: "CharacterFeet2")
    
    //suoni
    var portasbatte : String = "open-door"
    let sbattimento = SKAction.playSoundFileNamed("open-door", waitForCompletion: false)
    
    //Variabili usate per il movimento del personaggio
    var location = CGPoint.zero
    
    //Variabili usate per gestire le collisioni con gli oggetti della stanza
    var wardrobeCollided: Bool = false
    var box2Collided: Bool = false
    var box1LeftCollided: Bool = false
    var box1RightCollided: Bool = false
    var box1Collided: Bool = false

    var smallDoorOpen: Bool = false
    
    let infoBigKey = SKLabelNode(text: LanguageHandler.instance.objectiveEnglishBigKey1)

    
    
    //Camera di gioco
    let cameraNode = SKCameraNode()
    
    
//    cose relative alla bambola
    let doll = SKSpriteNode(imageNamed: "Doll")
    let dollLable = SKLabelNode(fontNamed: "MonoSF")
    let infoOpacityOverlayKey = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let bigOverlay = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    let overlayDescription = SKSpriteNode(imageNamed: "DropDoll")
    let overlayDescriptionKey = SKSpriteNode(imageNamed: "DropBigKey")

   
    let infoDoll = SKLabelNode(text: LanguageHandler.instance.objectiveEnglishDoll)

    var fadeOutDoorHandler: Bool = false
        
    
    
    var dollInteractible: Bool = false
    
    let gameArea: CGRect
        
    override init(size: CGSize) {
        
        wardrobeZoneInteractionCollider = SKShapeNode(rectOf: CGSize(width: size.width*0.6, height: size.height*0.1))
        wardrobeZoneInteractionCollider2 = SKShapeNode(rectOf: CGSize(width: size.width*0.37, height: size.height*0.07))
        
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
        
        
        //Per non imputtanire troppo il codice, metto le impostazioni più lunghe in un'altra funzione definita sempre nella classe e la richiamo qui, così almeno sembra un po' più pulito
        roomSetup()
        

        //Inserisco poi gli oggetti effettivamente nella scena
        addChild(room)
        addChild(rightBarrier)
        addChild(lowerBarrier)
        addChild(topBarrier)
        addChild(leftBarrier)
        addChild(lowerDoor)
        addChild(wardrobe)
        addChild(wardrobeCollider)
//        addChild(box2andShadow)
//        addChild(box2Single)
        addChild(box2Collider)
        addChild(box2TransparencyCollider)
        addChild(box1Left)
        addChild(smalDoorClosed)
        addChild(smalDoorInteraction)
        if(!Level0VariableHadnler.instance.boxLeftTouched){
            addChild(box1LeftInteractionCollider)
            addChild(blurBoxes)
        } else {
            smalDoorInteraction.zPosition = 12
            if(Level0VariableHadnler.instance.smallDoorOpen){
                smalDoorClosed.run(SKAction.setTexture(SKTexture(imageNamed: "SmallDoorOpen")))
                smallDoorOpen = true
                if(!Level0VariableHadnler.instance.bigKeyPick){
                    addChild(bigKey)
                    bigKey.zPosition = 13
                }
            }
        }
        addChild(box1Right)
//        addChild(box1Shadow)
        addChild(box1Collider)
        addChild(box1TransparencyCollider)
        addChild(wardrobeTransparencyCollider)
        

//        addChild(bigKey)
        
        addChild(doll)

        addChild(characterAvatar)
        addChild(characterFeetCollider)

        addChild(wardrobeInteractionCollider)
        addChild(wardrobeZoneInteractionCollider)
        addChild(wardrobeZoneInteractionCollider2)
        addChild(worldGroup)
        addChild(blurWardrobe)
        //Aggiungo la camera di gioco
        addChild(cameraNode)
        camera = cameraNode
        //Aggiungo il bottonr per aprire il menu di pausa alla camera di gioco
        cameraNode.addChild(pauseButton)
        
        cameraNode.addChild(iButton)
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
        blackCover.alpha = 1
        blackCover.fillColor = .black
        blackCover.strokeColor = .black
        blackCover.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0)
        blackCover.zPosition = 100
        cameraNode.addChild(blackCover)
        blackCover.run(fadeOutAction, completion: {
            musicHandler.instance.playBackgroundMusic()
            if(self.firstOpening){
                if(!UIAnimationsHandler.instance.itemInteractible && !UIAnimationsHandler.instance.fullOpen){
                    self.stopScene = true
                    let xScaleAction = SKAction.scaleX(to: self.size.width*0.0017, duration: 0.3)
                    let yScaleAction = SKAction.scaleY(to: self.size.width*0.0008, duration: 0.3)
                    if (LanguageHandler.instance.language == "English"){
                        self.infoText.text = LanguageHandler.instance.infoTextOneEnglish
                        self.infoText2.text = LanguageHandler.instance.infoTextTwoEnglish
                    } else if (LanguageHandler.instance.language == "Italian"){
                        self.infoText.text = LanguageHandler.instance.infoTextOneItalian
                        self.infoText2.text = LanguageHandler.instance.infoTextTwoItalian
                    }
                    self.infoText.position = CGPoint(x: -self.gameArea.size.width*0, y: -self.gameArea.size.height*0.32)
                    UIAnimationsHandler.instance.infoOverlayPopUpAnimation(size: self.size, cameraNode: self.cameraNode, infoBackground: self.infoBackground, infoText: self.infoText, infoOpacityOverlay: self.infoOpacityOverlay)
                }
//                self.stopScene = true
//                let xScaleAction = SKAction.scaleX(to: self.size.width*0.0017, duration: 0.5)
//                let yScaleAction = SKAction.scaleY(to: self.size.width*0.0008, duration: 0.5)
//                self.infoBackground.xScale = 0
//                self.infoBackground.yScale = 0
//                self.cameraNode.addChild(self.infoOpacityOverlay)
//                self.cameraNode.addChild(self.infoBackground)
//                self.infoBackground.run(xScaleAction)
//                self.infoBackground.run(yScaleAction, completion: {
//                    self.cameraNode.addChild(self.infoText)
//                })
            }
        })
        
        //Per abilitare le collisioni nella scena
        self.scene?.physicsWorld.contactDelegate = self
        
        previousRoom = "Room1"
        
        
        
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
        
        if(touchedNode.name == "smallDor" && characterFeetCollider.frame.intersects(box2TransparencyCollider.frame)){
            
            if(!Level0VariableHadnler.instance.smallKeyPick){
//            Level0VariableHadnler.instance.smallDorTouched = true
                print("Tapped on door, it's closed")
                smallDoorLabel.removeFromParent()
                smallDoorLabel.removeAllActions()
                smallDoorLabel.alpha = 0
                Level0VariableHadnler.instance.bigKeyVar = false
                smalDoorClosed.run(SKAction.setTexture(SKTexture(imageNamed: "SmallDoorClosed")))
                cameraNode.addChild(smallDoorLabel)
                smallDoorLabel.alpha = 1
                smallDoorLabel.run(SKAction.fadeOut(withDuration: 5))
                if(LanguageHandler.instance.language == "English"){
                        smallDoorLabel.text = "Maybe is locked..."
                }else if(LanguageHandler.instance.language == "Italian"){
                        smallDoorLabel.text = "Forse è chiuso..."
                    }
                bigKey.removeFromParent()
            }else if(Level0VariableHadnler.instance.smallKeyPick){
                Level0VariableHadnler.instance.keyOpenSmall = true
                Level0VariableHadnler.instance.smallDorTouched = true
                Level0VariableHadnler.instance.keyOpenSmall = true
                Level0VariableHadnler.instance.bigKeyVar = true
                bigKey.removeFromParent()
                if(!Level0VariableHadnler.instance.smallDoorOpen){
                    bigKeyLabel.removeAllActions()
                    bigKeyLabel.alpha = 0
                    smalDoorClosed.run(SKAction.setTexture(SKTexture(imageNamed: "SmallDoorOpen")))
                    smallDoorOpen = true
                    if(!Level0VariableHadnler.instance.bigKeyPick){
                        addChild(bigKey)
                        cameraNode.addChild(bigKeyLabel)
                        bigKeyLabel.alpha = 1
                        bigKeyLabel.run(SKAction.fadeOut(withDuration: 5))
                    }
                    bigKey.zPosition = 13
                    if(LanguageHandler.instance.language == "English"){
                        bigKeyLabel.text = "This looks like a very old key..."
                    }else
                    if(LanguageHandler.instance.language == "Italian"){
                        bigKeyLabel.text = "Sembra una chiave molto vecchia..."
                    }
                    Level0VariableHadnler.instance.smallDoorOpen = true
                } else if (Level0VariableHadnler.instance.smallDoorOpen){
                    smalDoorClosed.run(SKAction.setTexture(SKTexture(imageNamed: "SmallDoorClosed")))
                    bigKey.removeFromParent()
                    bigKeyLabel.removeFromParent()
                    smallDoorOpen = false
                    Level0VariableHadnler.instance.smallDoorOpen = false
                }
                
            }
        }
        
        if(touchedNode.name == "bigKey"){
            print("prendi chiave grande")
            stopScene = true
//            let xScaleKey = SKAction.scaleX(to: size.width*0.0012, duration: 0.3)
//            let yScaleKey = SKAction.scaleY(to: size.width*0.0012, duration: 0.3)
            Level0VariableHadnler.instance.keyOpenSmall = true
            if(LanguageHandler.instance.language == "English"){
                infoBigKey.text = LanguageHandler.instance.objectiveEnglishBigKey1
            }else
            if(LanguageHandler.instance.language == "Italian"){
                infoBigKey.text = LanguageHandler.instance.objectiveItalianBigKey1
            }
            
            UIAnimationsHandler.instance.itemPopUpAnimation(size: size, cameraNode: cameraNode, overlayNode: overlayDescriptionKey, infoText: infoBigKey, infoOpacityOverlay: infoOpacityOverlayKey)
//            cameraNode.addChild(infoOpacityOverlayKey)
//            cameraNode.addChild(overlayDescriptionKey)
//            overlayDescriptionKey.xScale = 0
//            overlayDescriptionKey.yScale = 0
//            overlayDescriptionKey.run(xScaleKey)
//            overlayDescriptionKey.run(yScaleKey, completion: {
//                self.cameraNode.addChild(self.infoBigKey)
//            })
            Level0VariableHadnler.instance.keyOpen = true
            Level0VariableHadnler.instance.bigKeyPick = true
            bigKey.removeFromParent()
        }
        if(touchedNode.name == "overlayDescriptionKey"){
            infoOpacityOverlayKey.removeFromParent()
            infoBigKey.removeFromParent()
            overlayDescriptionKey.removeFromParent()
            bigOverlay.removeFromParent()
            stopScene = false
        }
        
        
        
        if(touchedNode.name == "furniture" && (characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider2.frame) || characterFeetCollider.frame.intersects(wardrobeTransparencyCollider.frame))){
            if(Level0VariableHadnler.instance.wardrobeRoom1CanOpen == true ){
                if(!Level0VariableHadnler.instance.interaction && !Level0VariableHadnler.instance.dollObject){
                    Level0VariableHadnler.instance.dollObject = true
                    Level0VariableHadnler.instance.interaction = true
                            if(!musicHandler.instance.mutedSFX){
                                run(sbattimento)
                            }
                            wardrobe.run(SKAction.setTexture(SKTexture(imageNamed: "WardrobeOpenRoom1")))
                            cameraNode.addChild(dollLable)
                            dollLable.run(SKAction.fadeOut(withDuration: 5))
                            doll.zPosition = 20
                            if(LanguageHandler.instance.language == "English"){
                                dollLable.text = "What is this?"
                            }else
                            if(LanguageHandler.instance.language == "Italian"){
                                dollLable.text = "Cos'è?"
                            }
                } else if (Level0VariableHadnler.instance.interaction && Level0VariableHadnler.instance.dollObject){
                            if(!musicHandler.instance.mutedSFX){
                                run(sbattimento)
                            }
                            wardrobe.run(SKAction.setTexture(SKTexture(imageNamed: "WardrobeClosedRoom1")))
                    Level0VariableHadnler.instance.interaction = false
                    Level0VariableHadnler.instance.wardrobeRoom1CanOpen = false
                            dollLable.removeFromParent()
                    Level0VariableHadnler.instance.dollObject = true
//                            doll.zPosition = 1
                    doll.removeFromParent()
                        }
            }
        }
        
        if(touchedNode.name == "bambola" && (characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider2.frame) || characterFeetCollider.frame.intersects(wardrobeTransparencyCollider.frame))){
            if(!UIAnimationsHandler.instance.itemInteractible && !UIAnimationsHandler.instance.fullOpen){
                stopScene = true
                if(LanguageHandler.instance.language == "English"){
                    infoDoll.text = LanguageHandler.instance.objectiveEnglishDoll
                }else if(LanguageHandler.instance.language == "Italian"){
                    infoDoll.text = LanguageHandler.instance.objectiveItalianDoll
                }
                UIAnimationsHandler.instance.itemPopUpAnimation(size: size, cameraNode: cameraNode, overlayNode: overlayDescription, infoText: infoDoll, infoOpacityOverlay: infoOpacityOverlayKey)
            }
        }
        if(touchedNode.name == "overlayDescription"){
            if(UIAnimationsHandler.instance.fullOpen && UIAnimationsHandler.instance.itemInteractible){
                UIAnimationsHandler.instance.removePopUpAnimation(overlayNode: overlayDescription, infoText: infoDoll, infoOpacityOverlay: infoOpacityOverlayKey)
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                    self.stopScene = false
                })
            }

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
                
                
                
    //            cameraNode.addChild(PauseMenuHandler.instance.settingsBackground)
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
                        if(self.firstOpening){
                            self.firstOpening = false
                        }
                    })
                }
            }
        }
        
        if(touchedNode.name == "boxesLeft"){
//            print("Toccato")
           Level0VariableHadnler.instance.boxLeftTouched = true
//            box1Left.run(SKAction.moveTo(x: 0.01, duration: 3))
            box1Left.run(SKAction.moveTo(x: size.width*0.0001, duration: 3))
            box1LeftInteractionCollider.run(SKAction.moveTo(x: size.width*0.0001, duration: 3), completion: {
                self.box1LeftInteractionCollider.removeFromParent()
            })
//            box1LeftInteractionCollider.run(SKAction.moveTo(x: size.width*0.0001, duration: 3))
            box2Collider.run(SKAction.moveTo(x: size.width*0.4, duration: 3))
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            blurBoxes.run(fadeOutAction, completion: {
                blurBoxes.removeFromParent()
            })
//            box2Collider.run(SKAction.moveTo(x: size.width*0.00000001, duration: 3))
            smalDoorInteraction.zPosition = 12
        }

        //Se clicco in un punto qulasiasi dello schermo la cui posizione è diversa da quella del personaggio allora inizio il movimento del personaggio impostando la variabile moveSingle a true. Questo movimento del personaggio sul tap singolo dello schermo mi serve per fare una transizione fluida dal "non tocco" (quando il personaggio è fermo) dello schermo al "tocco continuo dello schermo" (quando il personaggio è in movimento e posso direzionare il suo spostamento muovendo il dito sullo schermo)
        //Assegno il valore della posizione del tocco alla variabile "location" così posso usare questo valore anche fuori da questa funzione, lo uso in particolare nella funzione di "update"
        if(touchLocation != characterFeetCollider.position){
            if(!(touchedNode.name == "furniture" && (characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider2.frame) || characterFeetCollider.frame.intersects(wardrobeTransparencyCollider.frame))) &&
               !(touchedNode.name == "bambola" && (characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider2.frame) || characterFeetCollider.frame.intersects(wardrobeTransparencyCollider.frame))) &&
               !(touchedNode.name == "smallDor" && characterFeetCollider.frame.intersects(box2TransparencyCollider.frame)) &&
               touchedNode.name != "closePause" && touchedNode.name != "closeInfo" && touchedNode.name != "overlayDescription"){
            
                if(!stopScene){
//                        location = touchLocation
//                    CharacterMovementHandler.instance.location = touchLocation
                    CharacterMovementHandler.instance.characterMovementSingle(touchLocation: touchLocation, characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)
                    }
                }
            }
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Per fare la transizione dal tocco singolo al tocco continuo, quando viene rilevato il tocco continuo, imposto la variabile moveSingle a false, in modo che il movimento col semplice tap si interrompa e poi metto la variabile move a true, così facendo avvio il movimento del personaggio col tocco continuo dello schermo
        //Tengo continuamente traccia di dove sto toccando lo schermo tramite il for ed assegnando il valore della posizione del tocco alla variabile "location", così facendo posso usare il valore del tocco anche al di fuori di questa funzione, in particolare lo uso nella funzione di "update"
        CharacterMovementHandler.instance.moveAndMoveSingleToggle()
        for touch in touches {
            CharacterMovementHandler.instance.location = touch.location(in: self)
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Quando smetto di toccare lo schermo interrompo entrambi i tipi di movimento
        //Se alzo il dito dallo schermo, ovvero interrompo il movimento, blocco le azioni del personaggio, cioè quello che mi interessa bloccare sono le animazioni e resetto la posizione statica del personaggio con il setTexture
        CharacterMovementHandler.instance.checkStoppingFrame(characterAvatar: characterAvatar)
        //Reimposto tutte le variabili che si occupano di gestire le animazioni della camminata a false
        CharacterMovementHandler.instance.resetWalkingVariables()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //Se almeno una delle due variabili responsabili del movimento sono impostate a "true" allora inizia il movimento
        //Controllo se la posizione del tocco dello schermo è in alto, in basso, a sinistra o a destra rispetto alla posizione corrente del personaggio ed effettuo il movimento di conseguenza.
        //N.B.: Per cambiare la velocità di movimento basta cambiare il valore dopo i +=
        if(!stopScene){
            if(characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider.frame) || characterFeetCollider.frame.intersects(wardrobeZoneInteractionCollider2.frame)){
//                print("Furniture \(Level0VariableHadnler.instance.interaction)")
                if(!Level0VariableHadnler.instance.dollObject || Level0VariableHadnler.instance.wardrobeRoom1CanOpen){
                    blurWardrobe.alpha = 0.8
                }else {
                    blurWardrobe.alpha = 0.01
                }}else{
                        blurWardrobe.alpha = 0.01
                }
            if(characterFeetCollider.frame.intersects(box2Collider.frame)){
                blurBoxes.alpha = 0.8
            }else{
                blurBoxes.alpha = 0.01
            }
//            if(Level0VariableHadnler.instance.dollObject ){
//                blurWardrobe.removeFromParent()
//            }

            
            CharacterMovementHandler.instance.characterMovement(characterFeetCollider: characterFeetCollider, characterAvatar: characterAvatar)
                
            //Alla fine della funzione di update vado ad impostare la posizione dell'avatar del personaggio in relazione a quella del collider dei piedi
            characterAvatar.position = characterFeetCollider.position
            characterAvatar.position.y = characterAvatar.position.y - 8
            //Vado poi a centrare la camera sul personaggio
            cameraNode.position = characterAvatar.position
            //Metto la camera di gioco un po' pià in alto così si vede la cima della stanza
            cameraNode.position.y += size.height*0.2
            
            //Funzione che controlla le intersezioni tra gli oggetti
            checkCollisions()
        }
    
    }
    
    //Funzione che controlla le collisioni tra i nodi che hanno physics object come proprietà
    func didBegin(_ contact: SKPhysicsContact) {
        let contactA = contact.bodyA.node?.name
        let contactB = contact.bodyB.node?.name
        
        //Se la collisione che si è verificata ha come protagonisti il personaggio e la porta sul lato inferiore della stanza allora avvia la transizione alla nuova stanza
        if(contactA == "player" || contactB == "player"){
            if(contactA == "lowerDoor" || contactB == "lowerDoor"){
                //TO DO: transizione verso la nuova stanza
                if(!transitioning){
                    transitioning = true
                    blackCover.removeFromParent()
                    let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
                    blackCover.alpha = 0
                    cameraNode.addChild(blackCover)
                    blackCover.run(fadeInAction)
                    
                    musicHandler.instance.pauseBackgroundMusic()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        if(Level0VariableHadnler.instance.dollObject == true){
                            Level0VariableHadnler.instance.wardrobeRoom1CanOpen = false
                        }
                        
                        self.removeAllChildren()
                        
                        let room2 = Level00_2(size: self.size)
                        self.view?.presentScene(room2)
                    }
                }
            }
        }
    }
    
    func checkCollisions(){
        //Verifico se ci sono state collisioni tra il personaggio e il collider che gestisce la trasparenza dell'armadio
        if(characterFeetCollider.frame.intersects(self.wardrobeTransparencyCollider.frame)){
            wardrobeCollided = true
            wardrobe.zPosition = 11
            characterAvatar.zPosition = 10
        } else {
            //Quando la collisione finisce resetto i valori di trasparenza, uso la variabile wadrobeCollided così non eseguo sempre queste azioni, ma solamente se c'è stata una modifica a questi valori in precedenza, se quindi il personaggio è andato dietro all'armadio e ora ne sta uscendo
            if(wardrobeCollided){
                wardrobeCollided = false
                wardrobe.zPosition = 10
                characterAvatar.zPosition = 11
            }
        }
        
        //Zona di interazione dietro le scatole in alto a sinistra
        if(characterFeetCollider.frame.intersects(self.box2TransparencyCollider.frame)){
            box2Collided = true
            box1Left.zPosition = 11
            box1LeftInteractionCollider.zPosition = 14
            blurBoxes.zPosition = 11
            
//            smalDoorClosed.zPosition = 10
//            box2Single.zPosition = 11
//            box2andShadow.zPosition = 11
            characterAvatar.zPosition = 10
        } else {
            if(box2Collided){
               box2Collided = false
                box1Left.zPosition = 10
                box1LeftInteractionCollider.zPosition = 0
//                smalDoorClosed.zPosition = 9
//                box2Single.zPosition = 10
//                box2andShadow.zPosition = 10
                characterAvatar.zPosition = 11
                blurBoxes.zPosition = 0
                
            }
        }
        
        if(characterFeetCollider.frame.intersects(self.box1TransparencyCollider.frame)){
            box1Collided = true
//            box1Left.zPosition = 11
            characterAvatar.zPosition = 10
            box1Right.zPosition = 11
            characterAvatar.zPosition = 10
            
        } else {
            if(box1Collided){
                box1Collided = false
//                box1Left.zPosition = 10
                characterAvatar.zPosition = 11
                box1Right.zPosition = 10
                characterAvatar.zPosition = 11
            }
        }
        
    }
    
    //Funzione per creare definire le impostazioni dei nodi della stanza
    func roomSetup(){
        //Impostazioni relativa alla stanza in quanto background
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
        //Imposto il collider per il cambio stanza della porta in basso
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
        //Impostazioni riguardanti il guardaroba ed il suo collider
        wardrobeCollider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        wardrobeCollider.xScale = size.width*0.001
        wardrobeCollider.yScale = size.width*0.001
        wardrobeCollider.alpha = 0.01
        wardrobeCollider.physicsBody = SKPhysicsBody(texture: wardrobeCollider.texture!, size: wardrobeCollider.size)
        wardrobeCollider.physicsBody?.affectedByGravity = false
        wardrobeCollider.physicsBody?.restitution = 0
        wardrobeCollider.physicsBody?.allowsRotation = false
        wardrobeCollider.physicsBody?.isDynamic = false
        wardrobeCollider.zPosition = 3
        wardrobe.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        wardrobe.xScale = size.width*0.001
        wardrobe.yScale = size.width*0.001
        wardrobe.zPosition = 3
        
        blurWardrobe.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        blurWardrobe.xScale = size.width*0.001
        blurWardrobe.yScale = size.width*0.001
        blurWardrobe.zPosition = 3
        blurWardrobe.alpha = 0.01
        
        wardrobeTransparencyCollider.position = CGPoint(x: size.width*0.905, y: size.height*0.33)
        wardrobeTransparencyCollider.xScale = size.width*0.001
        wardrobeTransparencyCollider.yScale = size.width*0.001
        wardrobeTransparencyCollider.zPosition = 3
        wardrobeTransparencyCollider.alpha = 0.01
        
        wardrobeInteractionCollider.position = CGPoint(x: size.width * 1.05, y: size.height * 0.43)
        wardrobeInteractionCollider.xScale = size.width*0.001
        wardrobeInteractionCollider.yScale = size.width*0.001
        wardrobeInteractionCollider.zPosition = 14
        wardrobeInteractionCollider.zRotation = .pi/2
        wardrobeInteractionCollider.alpha = 0.01
        wardrobeInteractionCollider.name = "furniture"
        
        wardrobeZoneInteractionCollider.position = CGPoint(x: size.width*1.05, y:size.height*0.3)
        wardrobeZoneInteractionCollider.zPosition = 15
        wardrobeZoneInteractionCollider.fillColor = .red
        wardrobeZoneInteractionCollider.strokeColor = .red
        wardrobeZoneInteractionCollider.alpha = 0.01
        wardrobeZoneInteractionCollider2.position = CGPoint(x: size.width*1.15, y:size.height*0.25)
        wardrobeZoneInteractionCollider2.zPosition = 15
        wardrobeZoneInteractionCollider2.fillColor = .red
        wardrobeZoneInteractionCollider2.strokeColor = .red
        wardrobeZoneInteractionCollider2.alpha = 0.01
        
//        //Impostazioni riguardanti le scatole in alto
//        box2andShadow.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
//        box2andShadow.xScale = 0.4
//        box2andShadow.yScale = 0.4
//        box2andShadow.zPosition = 3
//        box2Single.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
//        box2Single.xScale = 0.4
//        box2Single.yScale = 0.4
//        box2Single.zPosition = 3
//        box2Collider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        box2Collider.xScale = size.width*0.001
        box2Collider.yScale = size.width*0.001
        box2Collider.alpha = 0.01
        box2Collider.physicsBody = SKPhysicsBody(texture: box2Collider.texture!, size: box2Collider.size)
        box2Collider.physicsBody?.affectedByGravity = false
        box2Collider.physicsBody?.restitution = 0
        box2Collider.physicsBody?.allowsRotation = false
        box2Collider.physicsBody?.isDynamic = false
        box2Collider.zPosition = 3
        box2TransparencyCollider.position = CGPoint(x: size.width*0.37, y: size.height*0.41)
        box2TransparencyCollider.xScale = size.width*0.001
        box2TransparencyCollider.yScale = size.width*0.001
        box2TransparencyCollider.zPosition = 3
        box2TransparencyCollider.alpha = 0.01
        //Impostazioni riguardanti le scatole in basso
        if(Level0VariableHadnler.instance.boxLeftTouched){
            box1Left.position = CGPoint(x: size.width*0.0001, y: size.height*0.4)
            box1LeftInteractionCollider.position = CGPoint(x: size.width*0.0001, y: size.height*0.4)
            box2Collider.position = CGPoint(x: size.width*0.4, y: size.height*0.5)
        } else {
            box1Left.position = CGPoint(x: size.width*0.09, y: size.height*0.4)
            box1LeftInteractionCollider.position = CGPoint(x: size.width*0.09, y: size.height*0.4)
            box2Collider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        }
        box1Left.xScale = size.width*0.001
        box1Left.yScale = size.width*0.001
        box1Left.zPosition = 3
//        box1Left.name = "boxesLeft"
        box1LeftInteractionCollider.xScale = size.width*0.001
        box1LeftInteractionCollider.yScale = size.width*0.001
        box1LeftInteractionCollider.zPosition = 3
        box1LeftInteractionCollider.name = "boxesLeft"
        box1LeftInteractionCollider.alpha = 0.01
        
        
        blurBoxes.position = CGPoint(x: size.width*0.48, y: size.height*0.5)
        blurBoxes.zPosition = 0
        blurBoxes.size = box2Collider.size
//        blurBoxes.alpha = 0.9
        
        smalDoorClosed.position = CGPoint(x: size.width*0.35, y: size.height*0.52)
        smalDoorClosed.xScale = size.width*0.0005
        smalDoorClosed.yScale = size.width*0.0005
        smalDoorClosed.zPosition = 2
        
        bigKey.position = CGPoint(x: size.width*0.27, y: size.height*0.48)
        bigKey.zRotation = 3.14/4
        bigKey.xScale = size.width*0.00012
        bigKey.yScale = size.width*0.00012
        bigKey.name = "bigKey"

        smalDoorInteraction.position = CGPoint(x: size.width*0.28, y: size.height*0.52)
        smalDoorInteraction.xScale = size.width*0.00025
        smalDoorInteraction.yScale = size.width*0.00045
        smalDoorInteraction.zPosition = 1
        smalDoorInteraction.alpha = 0.01
        smalDoorInteraction.name = "smallDor"
        
        box1Right.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        box1Right.xScale = size.width*0.001
        box1Right.yScale = size.width*0.001
        box1Right.zPosition = 3
//        box1Shadow.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
//        box1Shadow.xScale = 0.4
//        box1Shadow.yScale = 0.4
//        box1Shadow.zPosition = 3
        box1Collider.position = CGPoint(x: size.width*0.5, y: size.height*0.5)
        box1Collider.xScale = size.width*0.001
        box1Collider.yScale = size.width*0.001
        box1Collider.alpha = 0.01
        box1Collider.physicsBody = SKPhysicsBody(texture: box1Collider.texture!, size: box1Collider.size)
        box1Collider.physicsBody?.affectedByGravity = false
        box1Collider.physicsBody?.restitution = 0
        box1Collider.physicsBody?.allowsRotation = false
        box1Collider.physicsBody?.isDynamic = false
        box1Collider.zPosition = 3
        box1TransparencyCollider.position = CGPoint(x: size.width*0.7, y: size.height*0.2)
        box1TransparencyCollider.xScale = size.width*0.001
        box1TransparencyCollider.yScale = size.width*0.001
        box1TransparencyCollider.zPosition = 3
        box1TransparencyCollider.alpha = 0.01
        //Impostazioni riguardanti il collider dei piedi e il personaggio stesso
        characterAvatar.anchorPoint = CGPoint(x: 0.5,y: 0)
        characterAvatar.xScale = size.width*0.0004
        characterAvatar.yScale = size.width*0.0004
        characterAvatar.zPosition = 5
        characterAvatar.name = "player"
        if(previousRoom == "Room2"){
            characterFeetCollider.position = CGPoint(x: size.width*0.27,y: size.height*0.15)
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopBackRight")))
        } else {
            characterFeetCollider.position = CGPoint(x: size.width*0.5,y: size.height*0.31)
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
        //TO DO: Far partire il personaggio da vicino alla porta in alto
        //Impostazioni riguardanti il bottone che apre il menu di pausa
        pauseButton.name = "pause"
        pauseButton.position = CGPoint(x: -gameArea.size.width*0.4, y: gameArea.size.height*0.9 + CGFloat(10))
        pauseButton.zPosition = 30
        pauseButton.xScale = size.width*0.0001
        pauseButton.yScale = size.width*0.0001
        
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
//        infoText.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.2)
        infoText2.zPosition = 102
        infoText2.name = "closeInfo"
        infoText2.fontSize = size.width*0.05
//        infoText2.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0.1)

        
        
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
        
        doll.position = CGPoint(x: size.width*0.94, y: size.height*0.44)
        doll.xScale = size.width*0.00025
        doll.yScale = size.width*0.00025
        doll.name = "bambola"
        
        dollLable.fontColor = SKColor.white
        dollLable.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        dollLable.fontSize = size.width*0.04
        dollLable.zPosition = 150
        
        
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

        
        infoDoll.preferredMaxLayoutWidth = size.width*0.9
        infoDoll.numberOfLines = 0
        infoDoll.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoDoll.fontSize = size.width*0.05
        infoDoll.fontColor = SKColor.white
        infoDoll.zPosition = 52
        infoDoll.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)
//        infoDoll1.fontSize = size.width*0.05
//        infoDoll1.fontColor = SKColor.white
//        infoDoll1.zPosition = 52
//        infoDoll1.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.3)
//        infoDoll2.fontSize = size.width*0.05
//        infoDoll2.fontColor = SKColor.white
//        infoDoll2.zPosition = 52
//        infoDoll2.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)
        
        bigKeyLabel.fontColor = SKColor.white
        bigKeyLabel.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        bigKeyLabel.fontSize = size.width*0.04
        bigKeyLabel.zPosition = 150
        
        smallDoorLabel.fontColor = SKColor.white
        smallDoorLabel.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.9)
        smallDoorLabel.fontSize = size.width*0.04
        smallDoorLabel.zPosition = 150
        
        infoBigKey.preferredMaxLayoutWidth = size.width*0.9
        infoBigKey.numberOfLines = 0
        infoBigKey.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        infoBigKey.fontSize = size.width*0.05
        infoBigKey.fontColor = SKColor.white
        infoBigKey.zPosition = 120
        infoBigKey.position = CGPoint(x: -gameArea.size.width*0, y: -gameArea.size.height*0.4)
        
        overlayDescriptionKey.zPosition = 51
        overlayDescriptionKey.position = CGPoint(x: -gameArea.size.width*0, y: gameArea.size.height*0)
        overlayDescriptionKey.xScale = size.width*0.0012
        overlayDescriptionKey.yScale = size.width*0.0012
        overlayDescriptionKey.name = "overlayDescriptionKey"
        
        

    }
    
    
    
    
}



