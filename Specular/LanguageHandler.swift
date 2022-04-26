//
//  LanguageHandler.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SwiftUI

class LanguageHandler {
    
    static let instance = LanguageHandler()
    
    @AppStorage("language") var language: String = "English"
    
    public let settingsLabelEnglish = "Settings"
    public let closePauseEnglish = "Close"
    public let pauseLabelEnglish = "Pause"
    public let objectiveEnglish = "Hello there!"
    public let objectiveEnglish2 = "You are a kid that has"
    public let objectiveEnglish3 = "to reach the closet at the end of the level."
    public let objectiveEnglish4 = "Interact with the objects and furniture in"
    public let objectiveEnglish5 = "the scene, you might find something useful..."
    public let objectiveEnglish6 = "...or you might encounter a gruesome death! :)"
    
    public let settingsLabelItalian = "Impostazioni"
    public let closePauseItalian = "Chiudi"
    public let pauseLabelItalian = "Pausa"
    public let objectiveItalian = "Ciao!"
    public let objectiveItalian2 = "Sei un fanciullo che deve"
    public let objectiveItalian3 = "raggiungere lo sgabuzzino alla fine del livello."
    public let objectiveItalian4 = "Interagisci con gli oggetti e i mobili nella"
    public let objectiveItalian5 = "scena, potresti trovare qualcosa di utile..."
    public let objectiveItalian6 = "...oppure incotrare una morte orribile! :)"
    
    //Crediti
    public let creditsTextEnglish = "AYO!\n\nYou finished the demo, congrats!\n\nNow you can go back to whatever you were doing before.\n\n©The ParroTeam"
    public let creditsTextEnglish1 = "You finished the demo, congrats!"
    public let creditsTextEnglish2 = "Now you can go back to whatever you were doing before."
    public let creditsTextItalian = "YOO!\n\nHai finito la demo, congratulazioni!\n\nAdesso puoi tornare a fare qulasiasi cosa tu stessi facendo prima.\n\n©The ParroTeam"


    
//    chiave
    public let objectiveEnglish11 = "It's a very small key,\nit could open a \nvery small door "
    
    public let objectiveItalian11 = "È una chiave molto piccola,\npotrebbe aprire una \nporta molto piccola"

    
//  diario
    public let objectiveEnglishDiary = "Dear Diary,"
    public let objectiveEnglishDiary1 = "Dear Diary,\n\nIt's moving day and \nI couldn't be happier! \nI really want to explore the whole \nhouse and see what secrets \nis going to hide! \nWill keep you informed."
    public let objectiveEnglishDiary2 = ""
    
    public let objectiveItalianDiary = "Caro Diario,"
    public let objectiveItalianDiary1 = "Caro Diario,\n\nè la giornata del trasloco \ne non potevo essere più felice! \nHo tanta voglia di esporare tutta \nla casa e vedere che segreti \nnasconde!\nTi terrò informato."
    public let objectiveItalianDiary2 = ""
    
//    doll
    public let objectiveEnglishDoll = "Such a creepy looking doll! \nWill it be safe to leave it there?"
  
    public let objectiveItalianDoll = "Una bambola dall'aspetto \nraccapricciante! \nSarà sicuro lasciarla li?"

//    frame
    public let objectiveEnglishFrame = "Who is this person!?! \nMaybe the previous owner \nof the house...\nLooks so strange!"
  
    public let objectiveItalianFrame = "Chi è questa persona!? \nForse il proprietario \nprecedente...\nÈ una foto strana!"
    
//    big key description
    public let objectiveEnglishBigKey1 = "It'a a very old key,\nit could open a \nlocked door. \nLet's find it!"
    
    public let objectiveItalianBigKey1 = "È una chiave molto vecchia,\npotrebbe aprire una \nporta bloccata. \nCerchiamola!"
    
//    info
    public let infoTextOneEnglish = "Hello there! \n\nYou have to reach the closet at the end of the level. \n\nExplore the house and interact with the objects and furniture in the scene, you might find something useful... \n\n...or you might encounter a terrible surprise!"
    public let infoTextTwoEnglish = "You can move by tapping and holding on the screen. \n\nTo interact with the objects simply go closer and click on them."
 
    public let infoTextOneItalian = "Ciao! \n\nDevi raggiungere lo sgabuzzino alla fine del livello. \n\nEsplora la casa e interagisci con gli oggetti e i mobili, potresti trovare qualcosa di utile... \n\n...oppure andare incotro ad una teribile sorpresa!"
    public let infoTextTwoItalian = "Per muoverti clicca sullo schermo e tieni premuto. \n\nPer interagire con gli oggetti avvicinati e cliccaci sopra."

//    prologue text
    public let prologueTextEnglish = "You and your parents just moved in the new house.\n\n<<I go inside, can’t wait!>> \n<<Fine, we will come soon.>>\n\nYou are so happy for this new experience. \nYou open the door, you enter by the front door, but suddenly it locks behind you, completely blocked.\n\nYou have to find a way out."
    

    public let prologueTextItalian = "Tu e la tua famiglia vi siete appena trasferiti nelle nuova casa.\n\n<<Io inizio ad entrare, non resisto!>> \n<Va bene, ti raggiungiamo subito.>>\n\nSei così felice per questa nuova esperienza. \nApri la porta, ma questa improvvisamente si chiude alla tue spalle, completamente bloccata.\n\nDevi trovare un modo per uscire."
}
