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
    @IBOutlet weak var lineImageView: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var longPressGestureRecognizer: UILongPressGestureRecognizer!
    var isLongPressActive = false
    var timer: Timer?

    @objc func longPressAction() {
        if isLongPressActive {
            // 在这里执行长按时需要持续进行的操作
            print("longPressAction is being executed.")
        }
    }

    @IBAction func handleLongPress(gesture: UILongPressGestureRecognizer) {
        print("handleLongPress is being executed.")
        switch gesture.state {
        case .began:
            // 长按开始
            isLongPressActive = true
            // 启动定时器，每隔一定时间执行特定函数
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(longPressAction), userInfo: nil, repeats: true)
        case .ended, .cancelled, .failed:
            // 长按结束
            isLongPressActive = false
            timer?.invalidate() // 停止定时器
        default:
            break
        }
   }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameViewController viewDidLoad")
        
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
            lineImageView.image = UIImage(named: "line")
            recordButton.imageView?.image = UIImage(named: "speaker")
            recordButton.addGestureRecognizer(longPressGestureRecognizer)
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
