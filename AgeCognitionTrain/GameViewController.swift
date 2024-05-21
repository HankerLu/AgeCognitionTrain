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
    @IBOutlet weak var editorImageView: UIImageView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var editorTextView: UITextView!
    @IBOutlet weak var longPressGestureRecognizer: UILongPressGestureRecognizer!
    
    var isLongPressActive = false
    var timer: Timer?
    var globalIndex = 0 // 全局变量来跟踪当前的索引位置
 
    let mixedString = "一个年逾古稀的长者，她手中拿着一叠叠陈旧的照片，眼神中透着坚定与力量，向儿子倾情诉说着往事。这不仅是对抗岁月的一种方式，更是对抗认知记忆衰退的勇气表现。在她的故事中，每一张照片都是一个章节，记录着他曾经历过的点滴。有的是青涩的岁月，有的是挑战与困难，而有的则是甜蜜与幸福。他将这些回忆翻看一遍又一遍，仿佛重新演绎了自己的一生。而这些老照片，也成为了他与时光抗衡的武器，每一张都是对岁月的胜利宣言。"
    var lengthIndex: Int = 0

    func getNextCharacter(from string: String) -> String? {
        // 如果全局索引已经超出字符串长度，返回nil
        if globalIndex >= string.count {
            return nil
        }
        
        // 获取当前索引位置的字符
        let character = string[string.index(string.startIndex, offsetBy: globalIndex)]
        
        // 将全局索引位置向前移动
        globalIndex += 1
        
        return String(character)
    }

    @objc func longPressAction() {
        if isLongPressActive {
            // 在这里执行长按时需要持续进行的操作
            print("longPressAction is being executed.")
            if globalIndex >= lengthIndex {
                globalIndex = 0
            }
            let ret = getNextCharacter(from: mixedString)!
            editorTextView.text += ret
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
            //使图片的大小与imageView大小一致
            //imageView.image = imageView.image?.resizableImage(withCapInsets: .zero, resizingMode: .tile)//.resizableImage(withCapInsets: .zero, resizingMode: .tile)
            lineImageView.image = UIImage(named: "line")
            editorImageView.image = UIImage(named: "editor")
            recordButton.imageView?.image = UIImage(named: "speaker")
            recordButton.addGestureRecognizer(longPressGestureRecognizer)
            lengthIndex = mixedString.count
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
