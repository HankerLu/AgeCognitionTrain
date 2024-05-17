//
//  GameViewController.swift
//  AgeCognitionTrain
//
//  Created by Hanker Lu on 2024/5/17.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var speakerImageView: UIImageView!
    @IBOutlet weak var lineImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置背景颜色为白色
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
            
            //设置imageView的屏幕大小
            // imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: 500)
            imageView.image = UIImage(named: "memory2")
            speakerImageView.image = UIImage(named: "speaker")
            lineImageView.image = UIImage(named: "line")
        }
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
