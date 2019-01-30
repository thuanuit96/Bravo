//
//  SettingViewController.swift
//  Demo
//
//  Created by asto on 1/24/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    var customCell : SettingTableViewCell? = nil
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingtableviewcell", for: indexPath) as! SettingTableViewCell
        cell.bntLogout.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Logout", comment: ""), for: .normal)
        cell.lbAccount.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Account", comment: "")
        cell.lbChangeLg.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Setting", comment: "")
        cell.btnChangeLg.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "Language", comment: ""), for: .normal)
        
        //remove border if row empty
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        //remove hover cell
        cell.selectionStyle = .none
        //design layout label
        let lbAccountFrame = cell.lbAccount.frame
        let bottomLayerAccount = CALayer()
        bottomLayerAccount.frame = CGRect(x: 0, y: lbAccountFrame.height, width: lbAccountFrame.width
            , height: 2)
        bottomLayerAccount.backgroundColor = UIColor.lightGray.cgColor
        cell.lbAccount.layer.addSublayer(bottomLayerAccount)
        let lbChangeLgFrame = cell.lbChangeLg.frame
        let bottomLayerChangeLg = CALayer()
        bottomLayerChangeLg.frame = CGRect(x: 0, y: lbChangeLgFrame.height, width: lbChangeLgFrame.width
            , height: 2)
        bottomLayerChangeLg.backgroundColor = UIColor.lightGray.cgColor
        cell.lbChangeLg.layer.addSublayer(bottomLayerChangeLg)
        
        // save cell in to gobal var
        customCell = cell
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //set layout for tableView
        self.settingTableView.rowHeight = 140
        self.settingTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        settingTableView.dataSource = self
        title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Management", comment: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        settingTableView.reloadData()
    }
    @IBOutlet weak var settingTableView: UITableView!
    @IBAction func testlogout(_ sender: UIButton) {
        
        let def = UserDefaults.standard
        let user = def.value(forKey: "userInfo") as! Dictionary<String, String>
        if !user.isEmpty {
            // user logged in
            def.removeObject(forKey: "userInfo")
            def.synchronize()
            let LoginController = self.storyboard?.instantiateViewController(withIdentifier: "loginScreen") as? LoginViewController
            present(LoginController!, animated: false,completion: nil)
        }
    }
    @IBAction func changeLanguage(_ sender: UIButton) {
        
        //Switch language
        LocalizationSystem.sharedInstance.switchLanguage()
        //Set language for UI
        //UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "tabbar")
        let tabbar = storyboard!.instantiateViewController(withIdentifier: "tabbar") as! TabbarViewController
        tabbar.selectedIndex = 3
        self.present(tabbar, animated: false, completion: nil)
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            
            let cell = self.customCell!
            let lbAccountFrame = cell.lbAccount.frame
            let bottomLayerAccount = CALayer()
            bottomLayerAccount.frame = CGRect(x: 0, y: lbAccountFrame.height, width: lbAccountFrame.width
                , height: 3)
            bottomLayerAccount.backgroundColor = UIColor.lightGray.cgColor
            cell.lbAccount.layer.addSublayer(bottomLayerAccount)
            
            let lbChangeLgFrame = cell.lbChangeLg.frame
            let bottomLayerChangeLg = CALayer()
            bottomLayerChangeLg.frame = CGRect(x: 0, y: lbChangeLgFrame.height, width: lbChangeLgFrame.width
                , height: 3)
            bottomLayerChangeLg.backgroundColor = UIColor.lightGray.cgColor
            cell.lbChangeLg.layer.addSublayer(bottomLayerChangeLg)
        }
    }
    
}
