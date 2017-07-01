//
//  GameViewController.swift
//  Game
//
//  Created by Patrick on 01/07/17.
//  Copyright © 2017 Patrick. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
