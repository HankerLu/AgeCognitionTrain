//
//  SongStoryViewController.swift
//  AgeCognitionTrain
//
//  Created by Hanker Lu on 2024/8/7.
//

import UIKit

class SongStoryViewController: UIViewController {

    @IBOutlet weak var smellingingLabel: UILabel!
    @IBOutlet weak var rememberLabel: UILabel!

    @IBOutlet weak var arrowImageView: UIImageView!

    @IBOutlet weak var findStoryLabel: UILabel!
    @IBOutlet weak var findSongLabel: UILabel!

    func songStoryAppearFunc() {
        // 按顺序显示按钮
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.smellingingLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
            self.rememberLabel.alpha = 1
        })

        UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
            self.findStoryLabel.alpha = 1
            self.arrowImageView.alpha = 1
        })

        UIView.animate(withDuration: 0.5, delay: 3.7, options: [], animations: {
            self.findSongLabel.alpha = 1
        })   
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        smellingingLabel.alpha = 0
        rememberLabel.alpha = 0
        arrowImageView.alpha = 0
        findStoryLabel.alpha = 0
        findSongLabel.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.songStoryAppearFunc()
        }
        // Do any additional setup after loading the view.
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
