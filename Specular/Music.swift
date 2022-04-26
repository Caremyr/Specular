//
//  Music.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import AVFoundation
import SwiftUI

final class musicHandler {
    
    static let instance = musicHandler()
    
    
    @AppStorage ("mutedMusic") var mutedMusic: Bool = false
    @AppStorage ("mutedSFX") var mutedSFX: Bool = false
//    let menuBackgroundMusicName: String = "academy.wav"
    let menuBackgroundMusicName: String = "Specular_Level0.wav"
//    let backgroundMusicName: String = "academy.wav"
    let backgroundMusicName: String = "Specular_Level0.wav"
    var backgroundMusicPlayerMenu: AVAudioPlayer = AVAudioPlayer()
    var backgroundMusicPlayer: AVAudioPlayer = AVAudioPlayer()
    var playingMusic: Bool = false
    
    
    func playBackgroundMusicMenu(){
        let resourceUrl = Bundle.main.url(forResource:
          menuBackgroundMusicName, withExtension: nil)
        guard let url = resourceUrl else {
          print("Could not find file: \(menuBackgroundMusicName)")
      return
      }
        do {
          try backgroundMusicPlayerMenu = AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayerMenu.numberOfLoops = -1
            backgroundMusicPlayerMenu.prepareToPlay()
            backgroundMusicPlayerMenu.play()
            if(mutedMusic){
                backgroundMusicPlayerMenu.volume = 0
            }
          } catch {
            print("Could not create audio player!")
        return
        }

      }
    
    func stopBackgroundMusicMenu(){
        backgroundMusicPlayerMenu.stop()
    }
    
    func continueBackgroundMusicMenu(){
        backgroundMusicPlayerMenu.play()
    }
    
    func muteBackgroundMusic(){
        backgroundMusicPlayerMenu.volume = 0
        backgroundMusicPlayer.volume = 0
        mutedMusic = true
    }
    
    func unmuteBackgroundMusic(){
        backgroundMusicPlayerMenu.volume = 1
        backgroundMusicPlayer.volume = 1
        mutedMusic = false
    }
    
    func muteSfx(){
        mutedSFX = true
    }
    
    func unmuteSfx(){
        mutedSFX = false
    }
    
    func playBackgroundMusic() {
        if(!playingMusic){
            let resourceUrl = Bundle.main.url(forResource:
              backgroundMusicName, withExtension: nil)
            guard let url = resourceUrl else {
              print("Could not find file: \(backgroundMusicName)")
          return
          }
            do {
              try backgroundMusicPlayer = AVAudioPlayer(contentsOf: url)
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                playingMusic = true
                if(mutedMusic){
                    backgroundMusicPlayer.volume = 0
                }
              } catch {
                print("Could not create audio player!")
            return
            }
        } else {
            backgroundMusicPlayer.play()
        }
        
    }
    
    func pauseBackgroundMusic(){
        backgroundMusicPlayer.pause()
    }
    
    func stopLevelBackgroundMusic() {
        backgroundMusicPlayer.stop()
        playingMusic = false
    }
    
    
}

//var backgrounMusicPlayerMenu: AVAudioPlayer!
//var backgroundMusicPlayer: AVAudioPlayer!
//var playingMusic: Bool = false
//var musicVolume: Bool = false
//
//func musicCheck(filename: String){
//    if(!playingMusic){
//        playBackgroundMusic(filename: filename)
//            } else {
//        backgroundMusicPlayer.play()
//    }
//}

//func playBackgroundMusic(filename: String) {
//  let resourceUrl = Bundle.main.url(forResource:
//    filename, withExtension: nil)
//  guard let url = resourceUrl else {
//    print("Could not find file: \(filename)")
//return
//}
//  do {
//    try backgroundMusicPlayer = AVAudioPlayer(contentsOf: url)
//      backgroundMusicPlayer.numberOfLoops = -1
//      backgroundMusicPlayer.prepareToPlay()
//      backgroundMusicPlayer.play()
//      playingMusic = true
//    } catch {
//      print("Could not create audio player!")
//  return
//  }
//
//}
//
//
//func musicStop(){
//    backgroundMusicPlayer.stop()
//}
