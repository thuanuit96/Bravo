//
//  TabbarViewController.swift
//  Demo
//
//  Created by asto on 1/29/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
class TabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBar.items?[0].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Playlist", comment: "")
        tabBar.items?[1].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Library", comment: "")
        tabBar.items?[2].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Videos", comment: "")
        tabBar.items?[3].title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Management", comment: "")
        dump(tabBar.items?[1].title)
    }
    @IBOutlet weak var tab: UITabBar!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
