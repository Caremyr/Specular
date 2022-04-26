//
//  GameViewController.swift
//  Specular
//
//  Created by Salvatore Manna on 26/04/22.
//
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let scene = Prologue(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
//        let scene = SplashScreen(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        let scene = Level00(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
//        let scene = TheEnd(size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.showsPhysics = false

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
