//
//  CharacterMovementHandler.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//

import Foundation
import SpriteKit
import SwiftUI


class CharacterMovementHandler {
    static let instance = CharacterMovementHandler()
    
    public var move: Bool = false
    public var moveSingle: Bool = false
    
    public var location: CGPoint = .zero
    
    public var walkingRight: Bool = false
    public var walkingLeft: Bool = false
    public var walkingUp: Bool = false
    public var walkingDown: Bool = false
    
    public let animationChangeOffset: CGFloat = 10
    
    func resetWalkingVariables(){
        self.walkingUp = false
        self.walkingDown = false
        self.walkingLeft = false
        self.walkingDown = false
        
        self.move = false
        self.moveSingle = false
    }
    
    func moveAndMoveSingleToggle(){
        self.moveSingle = false
        self.move = true
    }
    
    func checkStoppingFrame(characterAvatar: SKSpriteNode){
        characterAvatar.removeAllActions()
        if(walkingLeft && walkingDown){
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "Stop")))
        } else if (walkingRight && walkingDown){
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopRight")))
        } else if (walkingRight && walkingUp){
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopBackRight")))
        } else if (walkingLeft && walkingUp) {
            characterAvatar.run(SKAction.setTexture(SKTexture(imageNamed: "StopBackLeft")))
        }
    }
    
    func characterMovementSingle(touchLocation: CGPoint, characterFeetCollider: SKSpriteNode, characterAvatar: SKSpriteNode){
        location = touchLocation
        
        moveSingle = true
        //Così faccio iniziare l'animazione della camminata che si ripete per sempre e viene interrotta solamente quando finisce il movimento, cioè quando alzo il dito dallo schermo
        
        if(location.x > characterFeetCollider.position.x){
            walkingRight = true
            if (location.y > characterFeetCollider.position.y) {
                walkingUp = true
                characterAvatar.run(SKAction.repeatForever(walkingAnimationRightUp))
            } else if (location.y < characterFeetCollider.position.y){
                walkingDown = true
                characterAvatar.run(SKAction.repeatForever(walkingAnimationRightDown))
            }
        } else if (location.x < characterFeetCollider.position.x){
            walkingLeft = true
            if (location.y > characterFeetCollider.position.y) {
                walkingUp = true
                characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftUp))
            } else if (location.y < characterFeetCollider.position.y){
                walkingDown = true
                characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftDown))
            }
        }
    }
    
//    func characterMovementSingle(location: CGPoint, characterFeetCollider: SKSpriteNode, characterAvatar: SKSpriteNode){
//        moveSingle = true
//        //Così faccio iniziare l'animazione della camminata che si ripete per sempre e viene interrotta solamente quando finisce il movimento, cioè quando alzo il dito dallo schermo
//
//        if(location.x > characterFeetCollider.position.x){
//            walkingRight = true
//            if (location.y > characterFeetCollider.position.y) {
//                walkingUp = true
//                characterAvatar.run(SKAction.repeatForever(walkingAnimationRightUp))
//            } else if (location.y < characterFeetCollider.position.y){
//                walkingDown = true
//                characterAvatar.run(SKAction.repeatForever(walkingAnimationRightDown))
//            }
//        } else if (location.x < characterFeetCollider.position.x){
//            walkingLeft = true
//            if (location.y > characterFeetCollider.position.y) {
//                walkingUp = true
//                characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftUp))
//            } else if (location.y < characterFeetCollider.position.y){
//                walkingDown = true
//                characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftDown))
//            }
//        }
//    }
    
    func characterMovement(characterFeetCollider: SKSpriteNode, characterAvatar: SKSpriteNode){
        if(self.move || self.moveSingle){
            if(location.x > characterFeetCollider.position.x) {
                characterFeetCollider.position.x += movementSpeed
                if(location.y > characterFeetCollider.position.y){
                    characterFeetCollider.position.y += movementSpeed
                    if (location.y > characterFeetCollider.position.y + animationChangeOffset && location.x > characterFeetCollider.position.x + animationChangeOffset){
                        if(!walkingRight || !walkingUp){
                            walkingLeft = false
                            walkingDown = false
                            walkingRight = true
                            walkingUp = true
                            characterAvatar.removeAllActions()
                            characterAvatar.run(SKAction.repeatForever(walkingAnimationRightUp))
                        }
                    }
                } else if(location.y < characterFeetCollider.position.y){
                    characterFeetCollider.position.y -= movementSpeed
                    if (location.y < characterFeetCollider.position.y - animationChangeOffset && location.x > characterFeetCollider.position.x - animationChangeOffset){
                        if(!walkingRight || !walkingDown){
                            walkingRight = true
                            walkingDown = true
                            walkingLeft = false
                            walkingUp = false
                            characterAvatar.removeAllActions()
                            characterAvatar.run(SKAction.repeatForever(walkingAnimationRightDown))
                        }
                    }
                }
            } else if (location.x < characterFeetCollider.position.x){
                characterFeetCollider.position.x -= movementSpeed
                if(location.y > characterFeetCollider.position.y){
                    characterFeetCollider.position.y += movementSpeed
                    if(location.y > characterFeetCollider.position.y + animationChangeOffset && location.x < characterFeetCollider.position.x + animationChangeOffset){
                        if(!walkingLeft || !walkingUp){
                            walkingLeft = true
                            walkingUp = true
                            walkingRight = false
                            walkingDown = false
                            characterAvatar.removeAllActions()
                            characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftUp))
                        }
                    }
                } else if(location.y < characterFeetCollider.position.y){
                    characterFeetCollider.position.y -= movementSpeed
                    if(location.y < characterFeetCollider.position.y - animationChangeOffset && location.x < characterFeetCollider.position.x - animationChangeOffset){
                        if(!walkingLeft || !walkingDown){
                            walkingLeft = true
                            walkingDown = true
                            walkingRight = false
                            walkingUp = false
                            characterAvatar.removeAllActions()
                            characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftDown))
                        }
                    }
                }
            } else if (location.y > characterFeetCollider.position.y){
                characterFeetCollider.position.y += movementSpeed
            } else if (location.y < characterFeetCollider.position.y){
                characterFeetCollider.position.y -= movementSpeed
            }
            
        }
    }
    
//    func characterMovement(location: CGPoint, characterFeetCollider: SKSpriteNode, characterAvatar: SKSpriteNode){
//        if(self.move || self.moveSingle){
//            if(location.x > characterFeetCollider.position.x) {
//                characterFeetCollider.position.x += movementSpeed
//                if(location.y > characterFeetCollider.position.y){
//                    characterFeetCollider.position.y += movementSpeed
//                    if (location.y > characterFeetCollider.position.y + animationChangeOffset && location.x > characterFeetCollider.position.x + animationChangeOffset){
//                        if(!walkingRight || !walkingUp){
//                            walkingLeft = false
//                            walkingDown = false
//                            walkingRight = true
//                            walkingUp = true
//                            characterAvatar.removeAllActions()
//                            characterAvatar.run(SKAction.repeatForever(walkingAnimationRightUp))
//                        }
//                    }
//                } else if(location.y < characterFeetCollider.position.y){
//                    characterFeetCollider.position.y -= movementSpeed
//                    if (location.y < characterFeetCollider.position.y - animationChangeOffset && location.x > characterFeetCollider.position.x - animationChangeOffset){
//                        if(!walkingRight || !walkingDown){
//                            walkingRight = true
//                            walkingDown = true
//                            walkingLeft = false
//                            walkingUp = false
//                            characterAvatar.removeAllActions()
//                            characterAvatar.run(SKAction.repeatForever(walkingAnimationRightDown))
//                        }
//                    }
//                }
//            } else if (location.x < characterFeetCollider.position.x){
//                characterFeetCollider.position.x -= movementSpeed
//                if(location.y > characterFeetCollider.position.y){
//                    characterFeetCollider.position.y += movementSpeed
//                    if(location.y > characterFeetCollider.position.y + animationChangeOffset && location.x < characterFeetCollider.position.x + animationChangeOffset){
//                        if(!walkingLeft || !walkingUp){
//                            walkingLeft = true
//                            walkingUp = true
//                            walkingRight = false
//                            walkingDown = false
//                            characterAvatar.removeAllActions()
//                            characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftUp))
//                        }
//                    }
//                } else if(location.y < characterFeetCollider.position.y){
//                    characterFeetCollider.position.y -= movementSpeed
//                    if(location.y < characterFeetCollider.position.y - animationChangeOffset && location.x < characterFeetCollider.position.x - animationChangeOffset){
//                        if(!walkingLeft || !walkingDown){
//                            walkingLeft = true
//                            walkingDown = true
//                            walkingRight = false
//                            walkingUp = false
//                            characterAvatar.removeAllActions()
//                            characterAvatar.run(SKAction.repeatForever(walkingAnimationLeftDown))
//                        }
//                    }
//                }
//            } else if (location.y > characterFeetCollider.position.y){
//                characterFeetCollider.position.y += movementSpeed
//            } else if (location.y < characterFeetCollider.position.y){
//                characterFeetCollider.position.y -= movementSpeed
//            }
//
//        }
//    }
    
    
    
    
}

