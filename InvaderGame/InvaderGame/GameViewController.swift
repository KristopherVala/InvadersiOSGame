//
//  GameViewController.swift
//  FinalProjectIOS
//
//  Created by Kristopher Vala on 2019-04-09.
//  Copyright © 2019 dev. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view.presentScene(scene)
                
                if let gameScene = scene as? GameScene { gameScene.viewController = self } 
              
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
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
    
   func dismiss() {
    let start = self.storyboard?.instantiateViewController(withIdentifier:"MainViewController") as! MainViewController
    
    self.present(start, animated:true)
    
    }
}
