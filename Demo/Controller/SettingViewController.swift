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
        cell.lbAccount.text = "アカウント"
        //remove border if row empty
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        //remove hover cell
        cell.selectionStyle = .none
        //design layout label
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
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        settingTableView.reloadData()
        
    }
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var lbAccount: UILabel!
    
    @IBOutlet weak var lbChangeLg: UILabel!
    
    @IBAction func testlogout(_ sender: UIButton) {
        print("logout")
        let def = UserDefaults.standard
        
        def.set(true, forKey: "is_authenticated") // save true flag to UserDefaults
        
        let is_authenticated = def.bool(forKey: "is_authenticated") // return false if not found or stored value
        
        if is_authenticated {
            print(is_authenticated)
             def.set(false, forKey: "is_authenticated")

            // user logged in
            let LoginController = self.storyboard?.instantiateViewController(withIdentifier: "loginScreen") as? LoginViewController
            present(LoginController!, animated: true,completion: nil)
            
            
        }
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
