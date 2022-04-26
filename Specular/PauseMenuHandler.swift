//
//  PauseMenuHandler.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit


//Classe all'interno della quale vengono definiti i nodi per creare il menu di pausa in ogni scena

class PauseMenuHandler {
    
    //Istanza della classe, su questa istanza richiamo variabili e funzioni della classe
    static let instance = PauseMenuHandler()
    
    //Nodi del menu di pausa
    
    public let settingsBackground = SKSpriteNode(imageNamed: "DropMenu2")
    
    public let backgroundSettings = SKShapeNode(rectOf: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
    
    public let settingsLabel = SKLabelNode(text: "Settings")
    
    public let pauseLabel = SKSpriteNode(imageNamed: "PauseEnglish")
    public let pauseLabelItalian = SKSpriteNode(imageNamed: "PausaItalian")
    
    public let musicIcon = SKSpriteNode(imageNamed: "MusicOn")
    public let musicIconOff = SKSpriteNode(imageNamed: "MusicOff")
    
    public let sfxButton = SKSpriteNode(imageNamed: "SfxOn")
    public let sfxButtonOff = SKSpriteNode(imageNamed: "SfxOff")
    
    public let languageButton = SKSpriteNode(imageNamed: "EnglishFlag")
    public let languageButtonItalian = SKSpriteNode(imageNamed: "ItalianFlag")
    
    public let mainMenuButtonEnglish = SKSpriteNode(imageNamed: "MainMenu")
    public let mainMenuButtonItalian = SKSpriteNode(imageNamed: "MenuPrincipale")
    
    public let closePauseButtonEnglish = SKSpriteNode(imageNamed: "Close")
    public let closePauseButtonItalian = SKSpriteNode(imageNamed: "Chiudi")
    
    //Variabile che uso per vedere se è da quando ho aperto l'appliczione ho già impostato le proprietà di base dei nodi
    //Dopo aver impostato le proprietà dei nodi per la prima volta la metto a true
    public var firstSet = false
    
    //Funzione che si occupa di impostare le proprietà dei nodi, dimensioni, tag, nomi, trasparenza etc...
    func initializeNodeSettings (){
        if(!firstSet){
            //Impostazioni delle proprietà dei nodi
            backgroundSettings.fillColor = .black
            backgroundSettings.strokeColor = .black
            backgroundSettings.alpha = 0.45
            backgroundSettings.zPosition = 100
            backgroundSettings.name = "closePause"
            
            settingsBackground.zPosition = 101
            
            pauseLabel.zPosition = 102
            pauseLabelItalian.zPosition = 102
            
            musicIcon.zPosition = 102
            musicIcon.name = "musicButton"
            musicIconOff.zPosition = 102
            musicIconOff.name = "musicButton"
            
            sfxButton.zPosition = 102
            sfxButton.name = "sfxButton"
            sfxButtonOff.zPosition = 102
            sfxButtonOff.name = "sfxButton"
            
            languageButton.zPosition = 102
            languageButton.name = "languageButton"
            languageButtonItalian.zPosition = 102
            languageButtonItalian.name = "languageButton"
            
            mainMenuButtonEnglish.zPosition = 102
            mainMenuButtonEnglish.name = "mainMenu"
            mainMenuButtonItalian.zPosition = 102
            mainMenuButtonItalian.name = "mainMenu"
            
            closePauseButtonItalian.zPosition = 102
            closePauseButtonItalian.name = "closePause"
            closePauseButtonEnglish.zPosition = 102
            closePauseButtonEnglish.name = "closePause"
            
            //Dopo aver impostato le proprietà dei nodi metto questa variabile a true, così non rifaccio più questa operazione quando richiamo questa funzione
            firstSet = true
        }
    }
}
