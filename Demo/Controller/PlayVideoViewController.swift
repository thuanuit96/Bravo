//
//  PlayVideoViewController.swift
//  Demo
//
//  Created by asto on 1/8/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
var  player : AVPlayer?
class PlayVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var videoPreviewLayer: UIView!
    @IBAction func playVideo(_ sender: Any) {
        if let videoString = Bundle.main.path(forResource:"videodemo", ofType: "mp4"){
        let videoUrl = URL(fileURLWithPath: videoString)
        // 2
        player = AVPlayer(url: videoUrl)
        // 3
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
            
            player?.play()
            print(player?.rate)
            

        // 4
            playerViewController.view.frame = videoPreviewLayer.frame
            self.addChildViewController(playerViewController)
            self.view.addSubview(playerViewController.view)
//        present(playerViewController, animated: true) {
//            player.play()
//        }
        }
    }

    
    @IBAction func speedUp(_ sender: UIButton) {
        print("---------Test-----------")
        if player != nil {
            let maxRate : Float = 2
            if (player?.rate)! < maxRate {
                player?.rate += 0.25
                print(player!.rate)
            }
            
        }
        
        

    }
    @IBOutlet weak var speedUp: UIButton!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
