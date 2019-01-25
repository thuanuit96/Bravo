//
//  DetailMusicViewController.swift
//  Demo
//
//  Created by asto on 1/6/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import AVFoundation
import SQLite
class DetailMusicViewController: UIViewController {
    
    // MARK : Outlet
    @IBOutlet weak var sliderMusic: UISlider!
    @IBOutlet weak var lbEnd: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbSinger: UILabel!
    @IBOutlet weak var slideVolume: UISlider!
    @IBOutlet weak var lbStart: UILabel!
    var name:String?
    @IBOutlet weak var playPause: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    // MARK : Properties
    enum MusicType {
        case ONLINE, LOCAL, NONE
    }
    var onlinePlayer : AVPlayer?
    var localPlayer : AVAudioPlayer?
    var musicType : MusicType?
    var data :song?
    //Declare arr list music empty
    var listMusicData = [song]()
    //index of song in listMusic
    var songIndex : Int?
    
    // MARK : Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        initPlayer()
        
    }
    
    func initPlayer() {
        lbName.text = data?.name
        lbSinger.text = data?.singer
        guard let url = Bundle.main.url(forResource:data?.name, withExtension: "mp3") else {
            return
        }
        do {
            
            localPlayer = try AVAudioPlayer(contentsOf: url)
            let duration = localPlayer?.duration
            let min = Int(duration!) / 60
            let second = Int(duration!) % 60
            self.lbStart.text = "0:00"
            self.lbEnd.text = "\(min):\(second)"
            self.sliderMusic.maximumValue = Float(duration!)
            localPlayer?.enableRate = true
        
            localPlayer?.play()
            playPause.setImage(UIImage(named: "Pause"), for:.normal)
            
        } catch let err {
            print(err.localizedDescription)
        }
        
        
    }
    
    @objc func updateSlider() {
        if localPlayer!.isPlaying == true {
            sliderMusic.value = Float((localPlayer!.currentTime))
        } else if onlinePlayer != nil{
            let currentTimeBySecond = CMTimeGetSeconds((onlinePlayer!.currentTime()))
            sliderMusic.value = Float(currentTimeBySecond)
        }
    }
    
    // MARK : Action
    
    @IBAction func onClickBtnPlay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if localPlayer != nil {
            if localPlayer?.isPlaying == true {
                localPlayer?.stop()
                playPause.setImage(UIImage(named: "play_2"), for:.normal)
            } else {
                localPlayer?.play()
                playPause.setImage(UIImage(named: "Pause"), for:.normal)
            }
        } else if onlinePlayer != nil {
            if sender.isSelected == true {
                onlinePlayer?.play()
            } else {
                onlinePlayer?.pause()
            }
        }
    }
    
    //Mark set rate
    @IBAction func onClickSpeedUp(_ sender: UIButton) {
        let maxRate : Float = 2
        if localPlayer?.isPlaying == true {
            if (localPlayer?.rate)! < maxRate {
                localPlayer?.rate += 0.25
                localPlayer?.play()
                print(localPlayer?.rate)
            }
            
        }
    }
    
    @IBAction func onClickSpeedDown(_ sender: UIButton) {
        let minRate : Float = 0.25
        if localPlayer?.isPlaying == true {
            if (localPlayer?.rate)! > minRate {
                localPlayer?.rate -= 0.25
                localPlayer?.play()
                print(localPlayer?.rate)
            }
            
        }
        
    }
    //Mark click prev next song
    
    @IBAction func onClickBtnNextSong(_ sender: UIButton) {
        if songIndex! < listMusicData.count - 1 {
            let nextSong = songIndex! + 1
            let song = listMusicData[nextSong]
            if song.name != nil {
                songIndex = nextSong
                self.data = song
                initPlayer()
                sliderMusic.value = 0
                print("thuanasdadasdasd")
                dump(data)
            }
        }
        
    }
    
    
    @IBAction func onClickBtnPreSong(_ sender: UIButton) {
        if songIndex! > 0 {
            let preSong = songIndex! - 1
            let song = listMusicData[preSong]
            if song.url != nil {
                songIndex = preSong
                self.data = song
                initPlayer()
                sliderMusic.value = 0
                print("thuanasdadasdasd")
                dump(data)
            }
        }
        
    }
    @IBOutlet weak var onClickSpeedDown: UIButton!
    @IBAction func onClickNextTime(_ sender: Any) {
        let currentTime = sliderMusic.value
        var targetTime : Float = 0
        if currentTime + 10 > sliderMusic.maximumValue {
            targetTime = sliderMusic.maximumValue
        } else {
            targetTime = currentTime + 10
        }
        
        sliderMusic.value = targetTime
        if localPlayer != nil {
            localPlayer?.currentTime = TimeInterval(targetTime)
        } else if onlinePlayer != nil {
            onlinePlayer?.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1))
        }
    }
    @IBAction func onClickBtnBackTime(_ sender: Any) {
        let currentTime = sliderMusic.value
        var targetTime : Float = 0
        if currentTime - 10 > 0 {
            targetTime = currentTime - 10
        } else {
            targetTime = 0
        }
        
        sliderMusic.value = targetTime
        if localPlayer != nil {
            localPlayer?.currentTime = TimeInterval(targetTime)
        } else if onlinePlayer != nil {
            onlinePlayer?.seek(to: CMTime(seconds: Double(targetTime), preferredTimescale: 1))
        }
    }
    
    @IBAction func onChangeSliderVolume(_ sender: UISlider) {
        if localPlayer != nil {
            localPlayer?.volume = slideVolume.value
        } else if onlinePlayer != nil {
            onlinePlayer?.volume = slideVolume.value
        }
    }
    
}

