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

    @IBOutlet weak var selectGuosenzeButton: UIButton!
    @IBOutlet weak var selectZangyuanyuanButton: UIButton!
    @IBOutlet weak var selectLuhuanpengButton: UIButton!
    @IBOutlet weak var selectCaiminghaoButton: UIButton!
    @IBOutlet weak var selectLiwenjieButton: UIButton!
    @IBOutlet weak var tickAnswerLeftButton: UIButton!
    @IBOutlet weak var crossAnswerLeftButton: UIButton!
    @IBOutlet weak var tickAnswerRightButton: UIButton!
    @IBOutlet weak var crossAnswerRightButton: UIButton!
    
    var isStartFlag = false
    var lastImageIndex = 0
    var currentImageIndex = 0
    let imageNames = ["guosenze", "zangyuanyuan", "luhuanpeng", "caiminghao", "liwenjie"]
    var scorePoint = 0
    var secondCounter: Double = 300.0
    var rushModeCounter: Double = 12.0
    var timer: DispatchSourceTimer?
    var rushModeTimer: DispatchSourceTimer?
    var randomAnswerLabelText = "none"
    var rushModeScoreLeft = 0
    var rushModeScoreRight = 0
    var currentMode = 0
    var isRushModeTimerRunning = false

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
        if currentMode == 1 {
            scoreLabel.text = "\(rushModeScoreLeft) : \(rushModeScoreRight)"
        }
        else
        {
            scoreLabel.text = "分数: \(scorePoint)"
        }
    }
    func rushModeTimerHandler()
    {
        rushModeCounter = 12.0
        isRushModeTimerRunning = false
        print("Rush Mode Timer Handler is being executed.")
        tickAnswerLeftButton.isHidden = false
        crossAnswerLeftButton.isHidden = false
        tickAnswerRightButton.isHidden = false
        crossAnswerRightButton.isHidden = false
        rushModeTimer?.suspend()
        changeImage()
    }

    func rushModeTimerStart()
    {
        print("Rush Mode Timer Start is being executed.")
        tickAnswerLeftButton.isHidden = true
        crossAnswerLeftButton.isHidden = true
        tickAnswerRightButton.isHidden = true
        crossAnswerRightButton.isHidden = true
        if isRushModeTimerRunning == false
        {
            isRushModeTimerRunning = true
            rushModeTimer?.resume()
        }
    }

    func initGameMode() {
        isStartFlag = false
        secondCounter = 300.0
        scoreLabel.text = "分数：0"
        timeLabel.text = "时间: 15.0"
        randomAnswerLabelText = "none"
        scorePoint = 0
        rushModeScoreLeft = 0
        rushModeScoreRight = 0
        if currentMode == 0 {
            selectGuosenzeButton.isHidden = false
            selectZangyuanyuanButton.isHidden = false
            selectLuhuanpengButton.isHidden = false
            selectCaiminghaoButton.isHidden = false
            selectLiwenjieButton.isHidden = false
            randomAnswerLabelLeft.isHidden = true
            randomAnswerLabelRight.isHidden = true
            tickAnswerLeftButton.isHidden = true
            crossAnswerLeftButton.isHidden = true
            tickAnswerRightButton.isHidden = true
            crossAnswerRightButton.isHidden = true
        }
        else if currentMode == 1 {
            selectGuosenzeButton.isHidden = true
            selectZangyuanyuanButton.isHidden = true
            selectLuhuanpengButton.isHidden = true
            selectCaiminghaoButton.isHidden = true
            selectLiwenjieButton.isHidden = true
            randomAnswerLabelLeft.isHidden = false
            randomAnswerLabelRight.isHidden = false
            tickAnswerLeftButton.isHidden = false
            crossAnswerLeftButton.isHidden = false
            tickAnswerRightButton.isHidden = false
            crossAnswerRightButton.isHidden = false
        }
    }
    @IBAction func chooseSelectMode(_ sender: Any)
    {
        if currentMode != 0 {
            currentMode = 0
            initGameMode()
        }
    }

    @IBAction func chooseRushMode(_ sender: Any)
    {
        if currentMode != 1 {
            currentMode = 1
            initGameMode()
        }
    }

    @IBAction func tickAnswerLeft(_ sender: Any) {
        if isStartFlag == false || isRushModeTimerRunning == true{
            return
        }
        print("Left Tick answer, current answer name is \(randomAnswerLabelLeft.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == randomAnswerLabelText {
            print("Left Judge Correct!")
            scorePoint += 1
            rushModeScoreLeft += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Left Judge Wrong!")
            scorePoint -= 1
            rushModeScoreLeft -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        rushModeTimerStart() 
    }

    @IBAction func crossAnswerLeft(_ sender: Any) {
        if isStartFlag == false || isRushModeTimerRunning == true{
            return
        }
        print("Left Cross answer, current answer name is \(randomAnswerLabelLeft.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] != randomAnswerLabelText {
            print("Left Judge Correct!")
            scorePoint += 1
            rushModeScoreLeft += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Left Judge Wrong!")
            scorePoint -= 1
            rushModeScoreLeft -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        rushModeTimerStart()
    }

    @IBAction func tickAnswerRight(_ sender: Any) {
        if isStartFlag == false || isRushModeTimerRunning == true {
            return
        }
        print("Right Tick answer, current answer name is \(randomAnswerLabelRight.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] == randomAnswerLabelText {
            print("Right Judge Correct!")
            scorePoint += 1
            rushModeScoreRight += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Right Judge Wrong!")
            scorePoint -= 1
            rushModeScoreRight -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        rushModeTimerStart() 
    }

    @IBAction func crossAnswerRight(_ sender: Any) {
        if isStartFlag == false || isRushModeTimerRunning == true {
            return
        }
        print("Right Cross answer, current answer name is \(randomAnswerLabelRight.text). Last image index name is \(imageNames[lastImageIndex])")
        if imageNames[lastImageIndex] != randomAnswerLabelText {
            print("Right Judge Correct!")
            scorePoint += 1
            rushModeScoreRight += 1
            AudioServicesPlaySystemSound(SystemSoundID(1104))
        } else {
            print("Right Judge Wrong!")
            scorePoint -= 1
            rushModeScoreRight -= 1
            AudioServicesPlaySystemSound(SystemSoundID(1010))
        }
        rushModeTimerStart()
    }

    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func startGame(_ sender: Any) {
        if isStartFlag == true {
            return
        }
        isStartFlag = true
        self.secondCounter = 300.0
        scorePoint = 0
        rushModeScoreLeft = 0
        rushModeScoreRight = 0
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
        initGameMode()
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
        self.rushModeTimer = DispatchSource.makeTimerSource(queue: .main)
        self.rushModeTimer?.schedule(deadline: .now(), repeating: .milliseconds(100))
        self.rushModeTimer?.setEventHandler {
            self.rushModeCounter -= 1.0
            if self.rushModeCounter <= 0.0
            {
                self.rushModeTimerHandler()
            }
            // 定时器触发时执行的代码
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
