//
//  PlayMusicController.swift
//  Demo
//
//  Created by asto on 1/4/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import AVFoundation

class PlayMusicController: UIViewController {
    
    //Mark Declare
    var onlinePlayer : AVPlayer?
    var player : AVAudioPlayer?
    
    @IBOutlet weak var btnPre: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lbSlider: UISlider!
    @IBOutlet weak var lbSinger: UILabel!
    @IBOutlet weak var lbStart: UILabel!
    @IBOutlet weak var lbEnd: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("aaaaaa")
//        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
//        playerInit()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func aaaaaa(_ sender: Any) {
         print("aaaaaaaaa")
    }
    @IBAction func tssas(_ sender: Any) {
        print("aaaaaaaaa")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func playerInit() {
//        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else {
//            return
//        }
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            let duration = player?.duration
//            let min = Int(duration!) / 60
//            let second = Int(duration!) % 60
//            self.lbStart.text = "0:00"
//            self.lbEnd.text = "\(min):\(second)"
//            self.lbSlider.maximumValue = Float(duration!)
//        } catch let err {
//            print(err.localizedDescription)
//        }
//    }
//
//    @objc func updateSlider() {
//        if player!.isPlaying == true {
//            lbSlider.value = Float((player!.currentTime))
//        }
//    }
    
    
    
}
