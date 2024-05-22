//
//  ViewController.swift
//  AgeCognitionTrain
//
//  Created by Hanker Lu on 2024/5/21.
//

import UIKit

import AudioToolbox

class TrainViewController: UIViewController {

    @IBOutlet weak var trainGameImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var randomAnswerLabelLeft: UILabel!
    @IBOutlet weak var randomAnswerLabelRight: UILabel!
    
    var isStartFlag = false
    var lastImageIndex = 0
    var currentImageIndex = 0
    let imageNames = ["guosenze", "zangyuanyuan", "luhuanpeng", "caiminghao", "liwenjie"]
    var scorePoint = 0
    var secondCounter: Double = 150.0
    var timer: DispatchSourceTimer?
    var randomAnswerLabelText = "none"
    
    func changeImage() {
        lastImageIndex = currentImageIndex
        currentImageIndex = randomInt()
        if currentImageIndex == lastImageIndex {
            currentImageIndex = (currentImageIndex + 1) % 5
        }
        trainGameImageView.image = UIImage(named: imageNames[currentImageIndex])
        var randomAnswerIndex = randomInt()
        randomAnswerLabelText = imageNames[randomAnswerIndex]
        if randomAnswerLabelText == "guosenze"
        {
            randomAnswerLabelLeft.text = "郭森泽？"
            randomAnswerLabelRight.text = "郭森泽？"
        }
        else if randomAnswerLabelText == "zangyuanyuan"
        {
            randomAnswerLabelLeft.text = "臧媛媛?"
            randomAnswerLabelRight.text = "臧媛媛?"
        }
        else if randomAnswerLabelText == "luhuanpeng"
        {
            randomAnswerLabelLeft.text = "卢欢鹏?"
            randomAnswerLabelRight.text = "卢欢鹏?"
        }
        else if randomAnswerLabelText == "caiminghao"
        {
            randomAnswerLabelLeft.text = "蔡明皓?"
            randomAnswerLabelRight.text = "蔡明皓?"
        }
        else if randomAnswerLabelText == "liwenjie"
        {
            randomAnswerLabelLeft.text = "李文杰?"
            randomAnswerLabelRight.text = "李文杰?"
        }
        else
        {
            randomAnswerLabelLeft.text = "   无"
            randomAnswerLabelRight.text = "   无"
        }
        scoreLabel.text = "分数: \(scorePoint)"
    }

    @IBAction func tickAnswerLeft(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Left Tick answer, current answer name is \(randomAnswerLabelLeft.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == randomAnswerLabelText {
            print("Left Judge Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Left Judge Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage() 
    }

    @IBAction func crossAnswerLeft(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Left Cross answer, current answer name is \(randomAnswerLabelLeft.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] != randomAnswerLabelText {
            print("Left Judge Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Left Judge Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func tickAnswerRight(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Right Tick answer, current answer name is \(randomAnswerLabelRight.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == randomAnswerLabelText {
            print("Right Judge Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Right Judge Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage() 
    }

    @IBAction func crossAnswerRight(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Right Cross answer, current answer name is \(randomAnswerLabelRight.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] != randomAnswerLabelText {
            print("Right Judge Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Right Judge Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func startGame(_ sender: Any) {
        if isStartFlag == true {
            return
        }
        isStartFlag = true
        self.secondCounter = 150.0
        changeImage()
        self.timer?.resume() // 启动定时器
    }

    @IBAction func selectGuosenze(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Guosenze is selected. Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == "guosenze" {
            print("Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func selectZangyuanyuan(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("ZangyuanYuan is selected. Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == "zangyuanyuan" {
            print("Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func selectLuhuanpeng(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Luhuanpeng is selected. Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == "luhuanpeng" {
            print("Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func selectCaiminghao(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("Caiminghao is selected. Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == "caiminghao" {
            print("Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    @IBAction func selectLiwenjie(_ sender: Any) {
        if isStartFlag == false {
            return
        }
        print("LiWenjie is selected. Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == "liwenjie" {
            print("Correct!")
            scorePoint += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Wrong!")
            scorePoint -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        changeImage()
    }

    
    //生成5以内的随机数函数
    func randomInt() -> Int {
        return Int.random(in: 0...4)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TrainViewController is loaded.")
        // Do any additional setup after loading the view.
        currentImageIndex = randomInt()
        trainGameImageView.image = UIImage(named: imageNames[currentImageIndex])
        scoreLabel.text = "分数：0"

        self.timer = DispatchSource.makeTimerSource(queue: .main)
        self.timer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.timer?.setEventHandler {
            // 定时器触发时执行的代码
            self.secondCounter -= 1.0
            var display_time = self.secondCounter * 0.1
            if display_time >= 0.0
            {
                // 将display_time显示小数点后一位
                self.timeLabel.text = "时间: " +  (String(format: "%.1f", display_time))
            }
            else if self.isStartFlag == true
            {
                self.timer?.suspend()
                self.isStartFlag = false
            }
        }
    }

    deinit {
        // 清理定时器
        self.timer?.cancel()
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
