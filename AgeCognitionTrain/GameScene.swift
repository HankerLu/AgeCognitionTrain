//
//  GameScene.swift
//  AgeCognitionTrain
//
//  Created by Hanker Lu on 2024/5/17.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var pos_delta_X: Float = 0.0
    private var pos_delta_Y: Float = 0.0
    private var direction_X: Int = 0
    private var direction_Y: Int = 0
    private var g_cnt: Int = 0
    private var delta: Float = 40
//    private var animatedSquareBorder : SKShapeNode?
    
    func createAnimatedSquareBorder(size: CGFloat) -> SKShapeNode {
        let square = SKShapeNode(rectOf: CGSize(width: size, height: size))
        square.strokeColor = .blue
        square.lineWidth = 20
        square.fillColor = .clear
        
//         创建颜色变化动画
//         let colorChange = SKAction.sequence([
//             SKAction.colorize(with: .red, colorBlendFactor: 1.0, duration: 1.0),
//             SKAction.colorize(with: .blue, colorBlendFactor: 1.0, duration: 1.0),
//             SKAction.colorize(with: .green, colorBlendFactor: 1.0, duration: 1.0),
//             SKAction.colorize(with: .yellow, colorBlendFactor: 1.0, duration: 1.0)
//         ])
//        
//         square.run(SKAction.repeatForever(colorChange))
        
        return square
    }

// 使用

    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        print("----loading game scene.")
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        self.removeAllChildren()

        self.spinnyNode = SKShapeNode(circleOfRadius: 10)
        let texture = SKTexture(imageNamed: "cookingduring")
        let size = CGSize(width: 600, height: 1000)  // 设置你想要的大小
        let spriteNode = SKSpriteNode(texture: texture, color: .white, size: size)
 //        let spriteNode = SKSpriteNode(texture: texture)
        // spriteNode.alpha = 
        self.spinnyNode?.addChild(spriteNode)
        self.addChild(self.spinnyNode!)

        if g_cnt%15 == 0
        {
            if direction_X == 0{
                pos_delta_X += delta
                direction_X = 1
            }else
            {
                pos_delta_X -= delta
                direction_X = 0
            }

            if direction_Y == 0{
                pos_delta_Y += delta
                direction_Y = 1
            }else
            {
                pos_delta_Y -= delta
                direction_Y = 0
            }
        }
        if g_cnt%8 == 0
        {
            if delta > 0{
                delta -= 1.0
            }
        }

        // Called before each frame is rendered
        let borderSize: CGFloat = 100
        let animatedSquareBorder = createAnimatedSquareBorder(size: borderSize)
//        animatedSquareBorder = SKShapeNode(rectOf: CGSize(width: size, height: size))
        animatedSquareBorder.position = CGPoint(x: self.frame.midX - 190.0 + CGFloat(self.pos_delta_X), y: self.frame.midY - 200.0 + CGFloat(self.pos_delta_Y))
        animatedSquareBorder.lineWidth = 4
        self.addChild(animatedSquareBorder)
        g_cnt += 1
        
    }
}
