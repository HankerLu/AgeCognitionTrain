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
    @IBOutlet weak var nameLabel: UILabel!
    
    var isStartFlag = false
    var lastImageIndex = 0
    var currentImageIndex = 0
    let imageNames = ["guosenze", "zangyuanyuan", "luhuanpeng", "caiminghao", "liwenjie"]
    var scorePoint = 0
    
    func changeImage() {
        lastImageIndex = currentImageIndex
        currentImageIndex = randomInt()
        if currentImageIndex == lastImageIndex {
            currentImageIndex = (currentImageIndex + 1) % 5
        }
        trainGameImageView.image = UIImage(named: imageNames[currentImageIndex])
        nameLabel.text = "Score: \(scorePoint)"
    }

    @IBAction func backToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func startGame(_ sender: Any) {
        isStartFlag = true
        changeImage()
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
        nameLabel.text = "none"
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
