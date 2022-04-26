//
//  UIAnimationsHandler.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit


class UIAnimationsHandler {
    
    static let instance = UIAnimationsHandler()
    
    public var itemInteractible: Bool = false
    public var fullOpen: Bool = false
    
    func pauseOverlayPopUpAnimation(size: CGSize, cameraNode: SKCameraNode){
        self.itemInteractible = true
        
        PauseMenuHandler.instance.settingsBackground.xScale = 0
        PauseMenuHandler.instance.settingsBackground.yScale = 0
        cameraNode.addChild(PauseMenuHandler.instance.settingsBackground)
        let xScalePause = SKAction.scale(to: size.width*0.0011, duration: 0.3)
        let yScalePause = SKAction.scale(to: size.width*0.0011, duration: 0.3)
        PauseMenuHandler.instance.settingsBackground.run(xScalePause)
        PauseMenuHandler.instance.settingsBackground.run(yScalePause, completion: {
            if(musicHandler.instance.mutedMusic == true){
                cameraNode.addChild(PauseMenuHandler.instance.musicIconOff)
            } else if (musicHandler.instance.mutedMusic == false){
                cameraNode.addChild(PauseMenuHandler.instance.musicIcon)
            }
            
            
            if(musicHandler.instance.mutedSFX){
                cameraNode.addChild(PauseMenuHandler.instance.sfxButtonOff)
            } else if (!musicHandler.instance.mutedSFX){
                cameraNode.addChild(PauseMenuHandler.instance.sfxButton)
            }
            
            if(LanguageHandler.instance.language == "English"){
                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonEnglish)
                cameraNode.addChild(PauseMenuHandler.instance.languageButton)
                cameraNode.addChild(PauseMenuHandler.instance.pauseLabel)
                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonEnglish)
            } else if (LanguageHandler.instance.language == "Italian"){
                cameraNode.addChild(PauseMenuHandler.instance.closePauseButtonItalian)
                cameraNode.addChild(PauseMenuHandler.instance.languageButtonItalian)
                cameraNode.addChild(PauseMenuHandler.instance.pauseLabelItalian)
                cameraNode.addChild(PauseMenuHandler.instance.mainMenuButtonItalian)
            }
            
            self.fullOpen = true
        })
    }
    
    func pauseOverlayRemoveAnimation(){
        itemInteractible = false
        
        PauseMenuHandler.instance.backgroundSettings.removeFromParent()
//        PauseMenuHandler.instance.settingsBackground.removeFromParent()
        
        PauseMenuHandler.instance.pauseLabel.removeFromParent()
        PauseMenuHandler.instance.pauseLabelItalian.removeFromParent()
        
        PauseMenuHandler.instance.musicIcon.removeFromParent()
        PauseMenuHandler.instance.musicIconOff.removeFromParent()
        PauseMenuHandler.instance.sfxButton.removeFromParent()
        PauseMenuHandler.instance.sfxButtonOff.removeFromParent()
        PauseMenuHandler.instance.sfxButton.removeFromParent()
        
        PauseMenuHandler.instance.languageButton.removeFromParent()
        PauseMenuHandler.instance.languageButtonItalian.removeFromParent()
        
        PauseMenuHandler.instance.closePauseButtonEnglish.removeFromParent()
        PauseMenuHandler.instance.closePauseButtonItalian.removeFromParent()
        
        PauseMenuHandler.instance.mainMenuButtonEnglish.removeFromParent()
        PauseMenuHandler.instance.mainMenuButtonItalian.removeFromParent()
        
        PauseMenuHandler.instance.settingsBackground.run(SKAction.scaleX(to: 0, duration: 0.3))
        PauseMenuHandler.instance.settingsBackground.run(SKAction.scaleY(to: 0, duration: 0.3), completion: {
            PauseMenuHandler.instance.settingsBackground.removeFromParent()
            self.fullOpen = false
        })
        
    }
    
    func infoOverlayPopUpAnimation(size: CGSize, cameraNode: SKCameraNode, infoBackground: SKSpriteNode, infoText: SKLabelNode, infoOpacityOverlay: SKShapeNode){
        self.itemInteractible = true
        let xScaleAction = SKAction.scaleX(to: size.width*0.0017, duration: 0.3)
        let yScaleAction = SKAction.scaleY(to: size.width*0.0008, duration: 0.3)
        cameraNode.addChild(infoOpacityOverlay)
        cameraNode.addChild(infoBackground)
        infoBackground.xScale = 0
        infoBackground.yScale = 0
        infoBackground.run(xScaleAction)
        infoBackground.run(yScaleAction, completion: {
            cameraNode.addChild(infoText)
            self.fullOpen = true
        })
    }
    
    
    func infoOverlayRemoveAnimation(infoBackground: SKSpriteNode, infoText: SKLabelNode, infoOpacityOverlay: SKShapeNode){
        self.itemInteractible = false
        infoText.removeFromParent()
        infoBackground.run(SKAction.scale(to: 0, duration: 0.3), completion: {
            infoBackground.removeFromParent()
            infoOpacityOverlay.removeFromParent()
            self.fullOpen = false
        })
    }
    
    func itemPopUpAnimation(size: CGSize, cameraNode: SKCameraNode, overlayNode: SKSpriteNode, infoText: SKLabelNode, infoOpacityOverlay: SKShapeNode){
        UIAnimationsHandler.instance.itemInteractible = true
        
        let popUpXscale = SKAction.scaleX(to: size.width*0.0012, duration: 0.3)
        let popUpYScale = SKAction.scaleY(to: size.width*0.0012, duration: 0.3)
        
        cameraNode.addChild(infoOpacityOverlay)
        cameraNode.addChild(overlayNode)
        overlayNode.xScale = 0
        overlayNode.yScale = 0
        overlayNode.run(popUpXscale)
        overlayNode.run(popUpYScale, completion: {
            cameraNode.addChild(infoText)
            self.fullOpen = true
        })
    }
    
    func removePopUpAnimation(overlayNode: SKSpriteNode, infoText: SKLabelNode, infoOpacityOverlay: SKShapeNode){
        UIAnimationsHandler.instance.itemInteractible = false
        infoText.removeFromParent()
        overlayNode.run(SKAction.scale(to: 0, duration: 0.3), completion: {
            overlayNode.removeFromParent()
            infoOpacityOverlay.removeFromParent()
            self.fullOpen = false
        })
        
    }
    
}

