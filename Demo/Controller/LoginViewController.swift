//
//  LoginViewController.swift
//  Demo
//
//  Created by asto on 1/21/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set layout
        labelMessage.isHidden = true
        lblError.isHidden = true
        txtPassword.isSecureTextEntry = true
        txtEmail.layer.borderWidth = 1
        txtEmail.layer.borderColor = UIColor.lightGray.cgColor
        txtPassword.layer.borderWidth = 1
        txtPassword.layer.borderColor = UIColor.lightGray.cgColor
        //Set language for layout
        setLanguage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // add icon into textfield
        txtEmail.leftViewMode = UITextFieldViewMode.always
        txtPassword.leftViewMode = UITextFieldViewMode.always
        let emailIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: txtEmail.frame.size.height, height: txtEmail.frame.size.height))
        let passWordIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: txtPassword.frame.size.height, height: txtPassword.frame.size.height))
        emailIconView.image = UIImage(named: "email-icon")
        passWordIconView.image = UIImage(named: "password-icon")
        txtEmail.leftView = emailIconView
        txtPassword.leftView = passWordIconView
        txtEmail.isUserInteractionEnabled = true
        //Fix position logo
        self.Logo.center = CGPoint(x: self.boxLogo.frame.size.width  / 2,
                                   y: self.boxLogo.frame.size.height / 2)
    }
    
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var Logo: UIImageView!
    @IBOutlet weak var boxLogo: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnChangeLanguage: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func editEmail(_ sender: UITextField) {
        labelMessage.isHidden = true
        lblError.isHidden = true
    }
    
    @IBAction func editPassword(_ sender: UITextField) {
        labelMessage.isHidden = true
        lblError.isHidden = true
    }
    
    @IBAction func pressSignin(_ sender: UIButton) {
        
        var isSuccess = false
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [[String: String]] {
                    dump(person)
                    for  user in person {
                        if user["name"] == txtEmail.text && user["password"] == txtPassword.text {
                            isSuccess = true
                        }
                    }
                }
            } catch {
                // handle error
            }
        }
        
        if !isSuccess {
            
            //show notity
            labelMessage.isHidden = false
            lblError.isHidden = false
        } else {
            saveLoggedState()
            //Swap to library screen
            self.performSegue(withIdentifier: "tabbar", sender: nil)
        }
    }
    
    @IBAction func btnChangeLanguage(_ sender: UIButton) {
        //Switch language
        LocalizationSystem.sharedInstance.switchLanguage()
        //Set language for UI
        setLanguage()
    }
    /// call if user logged in
    func saveLoggedState() {
        var userInfo: Dictionary<String,String> = [:]
        userInfo["name"] = self.txtEmail.text
        userInfo["password"] = self.txtPassword.text
        userInfo["uiid"] = UIDevice.current.identifierForVendor?.uuidString
        UserDefaults.standard.set(userInfo, forKey: "userInfo")
        let result = UserDefaults.standard.value(forKey: "userInfo")
        
    }
    
    func setLanguage() {
        title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Management", comment: "")

        txtEmail.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "email", comment: "")
        txtPassword.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key: "password", comment: "")
        btnLogin.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "login", comment: ""), for: .normal)
        btnChangeLanguage.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "changeLanguage", comment: ""), for: .normal)
        lblError.lineBreakMode = .byWordWrapping
        lblError.numberOfLines = 2
        labelMessage.textColor = UIColor.red
        lblError.textColor = UIColor.red
        labelMessage.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "message", comment: "")
        lblError.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "error", comment: "")
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { _ in
            self.Logo.center = CGPoint(x: self.boxLogo.frame.size.width  / 2,
                                       y: self.boxLogo.frame.size.height / 2)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
