//
//  Screen6ViewController.swift
//  AgeCognitionTrain
//
//  Created by Hanker Lu on 2024/8/7.
//

import UIKit

class Screen6ViewController: UIViewController {

    @IBOutlet weak var thinkingLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!

    @IBOutlet weak var arrowImageView: UIImageView!

    @IBOutlet weak var timeNeedLabel: UILabel!
    @IBOutlet weak var cookTimeLabel: UILabel!

    var timer: DispatchSourceTimer?
    // var secondCounter: Double = 600.0 //分屏3 用
    var secondCounter: Double = 100.0

    override func viewDidLoad() {
        
        super.viewDidLoad()

        print("------------------------------screen 6")
        
        self.timer = DispatchSource.makeTimerSource(queue: .main)
        self.timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.timer?.setEventHandler {
            // 定时器触发时执行的代码
            
            
            self.secondCounter -= 1.0
            let display_time = self.secondCounter * 0.1
            if display_time >= 0.0
            {
                // 将display_time显示小数点后一位
                // self.cookTimeLabel.text =  "15:" + (String(format: "%.1f", display_time)) //分屏3 用
                self.cookTimeLabel.text = "00:" + (String(format: "%.1f", display_time))
            }
        }
        // 初始时隐藏所有按钮
        thinkingLabel.alpha = 0
        noteLabel.alpha = 0
        arrowImageView.alpha = 0
        timeNeedLabel.alpha = 0
        cookTimeLabel.alpha = 0

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.screen6AppearFunc()
            self.timer?.resume() // 启动定时器
            print("延迟2秒后执行")
        }
        // Do any additional setup after loading the view.
    }

    func screen6AppearFunc() {
        // 按顺序显示按钮
        UIView.animate(withDuration: 0.3, delay: 0, options: [], animations: {
            self.thinkingLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.3, delay: 1.0, options: [], animations: {
            self.noteLabel.alpha = 1
            // self.arrowImageView.alpha = 1
        })

        UIView.animate(withDuration: 0.3, delay: 2.0, options: [], animations: {
            self.timeNeedLabel.alpha = 1
        })

        UIView.animate(withDuration: 0.3, delay: 3.0, options: [], animations: {
            self.cookTimeLabel.alpha = 1
        })   
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
