//
//  FileZipViewController.swift
//  Demo
//
//  Created by asto on 1/10/19.
//  Copyright © 2019 asto. All rights reserved.
//

import MBProgressHUD
import UIKit
import SSZipArchive
import ZIPFoundation
import Alamofire
import DPLocalization
import SAMKeychain
class FileZipViewController: UIViewController,URLSessionDownloadDelegate{
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        changeLg.setupAutolocalization(withKey: "Welcome", keyPath: "text")
        text2.setupAutolocalization(withKey: "Download", keyPath: "text")

        
//set laguage via divice
        let alertTitle = NSLocalizedString("Welcome", comment: "")
        
//        btnShareVideo.setTitle(NSLocalizedString("Welcome", comment: ""), for: .normal)
        let alertMessage = NSLocalizedString("Thank you for trying this app, you are a great person!", comment: "")
        let cancelButtonText = NSLocalizedString("Cancel", comment: "")
        let signupButtonText = NSLocalizedString("Signup", comment: "")
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: cancelButtonText, style: UIAlertActionStyle.cancel, handler: nil)
        let signupAction = UIAlertAction(title: signupButtonText, style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(cancelAction)
        alert.addAction(signupAction)
        present(alert, animated: true, completion: nil)
        
        language = ["English", "Japanese", "Thái Lan", "Indonesia", "Việt Nam"]
        // Do any additional setup after loading the view.
    }
    
    
    // get UIIndentify
    func UUID() -> String {
        
        let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        let accountName = "incoding"
        
        var applicationUUID = SAMKeychain.password(forService: bundleName, account: accountName)
        
        if applicationUUID == nil {
            
            applicationUUID = UIDevice.current.identifierForVendor?.uuidString
            
            // Save applicationUUID in keychain without synchronization
            let query = SAMKeychainQuery()
            query.service = bundleName
            query.account = accountName
            query.password = applicationUUID
            query.synchronizationMode = SAMKeychainQuerySynchronizationMode.no
            
            do {
                try query.save()
            } catch let error as NSError {
                print("SAMKeychainQuery Exception: \(error)")
            }
        }
        print(applicationUUID)

        return applicationUUID!
    }
    @IBAction func getDevice(_ sender: UIButton) {
         print(self.UUID())
        
        
        

//        print(UIDevice.current.identifierForVendor?.uuidString)
                exit(0);

//        print(UIDevice.current.name)
//        print(UIDevice.current.systemName)
//        print(UIDevice.current.model)
//        print(UIDevice.current.localizedModel)
//        print(UIDevice.modelName)

        
        

    }
    
    let notificationName = Notification.Name("Did selected language")
    var language = [String]()
    
    
    @IBOutlet weak var text2: UITextField!
    
    @IBAction func changeLanguage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Language", message: "Select language", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: {() -> Void in })
        }))
        for item in language {
            actionSheet.addAction(UIAlertAction(title: item, style: .default, handler: {(_ action: UIAlertAction) -> Void in
                let langCode = Language.getLanguageCode(item)
                print(item)
                Language.setLanguage(langCode)
                NotificationCenter.default.post(name: self.notificationName, object: nil)
                self.dismiss(animated: true, completion:nil)
            }))
        }
        self.present(actionSheet,animated: true,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var hud : MBProgressHUD?
    
    @IBAction func tesst(_ sender: Any) {
        
       
        
    }
    @IBOutlet weak var btnShareVideo: UIButton!
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!

    @IBOutlet weak var changeLg: UILabel!
    @IBAction func onSegmentedControlValueChanged(sender: AnyObject) {
        switch (self.languageSegmentedControl.selectedSegmentIndex) {
        case 0:
            dp_set_current_language("en");
            break;
        case 1:
            dp_set_current_language("ja");
            break;
        default:
            dp_set_current_language(nil);
            break;
        }
    }
    var progress1: Float = 0.0
    var task: URLSessionTask!
    
    var percentageWritten:Float = 0.0
    var taskTotalBytesWritten = 0
    var taskTotalBytesExpectedToWrite = 0
    
    lazy var session : URLSession = {
        let config = URLSessionConfiguration.default
        // config.allowsCellularAccess = false
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        return session
    }()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    
    private let byteFormatter: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useKB, .useMB]
        return formatter
    }()
    
    
    @IBOutlet weak var percentDownload: UILabel!
    
    @IBAction func btnShareVideoTapped(_ sender: Any) {
        
        var hud =  MBProgressHUD.showAdded(to: self.view, animated: true)
        self.hud = hud
        // Set the bar determinate mode to show task progress.
        progress1 = 0.0
        hud.mode = MBProgressHUDMode.determinateHorizontalBar
        hud.isUserInteractionEnabled = true;
        hud.progress = self.progress1
        hud.labelText = NSLocalizedString("Downloading...", comment: "HUD loading title")
        DispatchQueue.global(qos: .default).async(execute: {() -> Void in
            // Do something useful in the background and update the HUD periodically.
            self.doSomeWorkWithProgress()
            DispatchQueue.main.async(execute: {() -> Void in
                

                //hud?.hide(true)
                hud.labelText = NSLocalizedString("Just Wait...", comment: "HUD loading title")
            })
        })
        
        
//        let videoPath = "https://github.com/weichsel/ZIPFoundation/archive/development.zip"
        let videoPath = "https://r7---sn-n8v7znss.googlevideo.com/videoplayback?c=WEB&initcwndbps=1468750&key=yt6&expire=1547396782&lmt=1472252858944634&sparams=dur%2Cei%2Cid%2Cinitcwndbps%2Cip%2Cipbits%2Citag%2Clmt%2Cmime%2Cmm%2Cmn%2Cms%2Cmv%2Cnh%2Cpl%2Cratebypass%2Crequiressl%2Csource%2Cexpire&nh=IgpwcjAzLnN2bzA2KgkxMjcuMC4wLjE%2C&ipbits=0&signature=BF8B753EBCF0F591192E97CDDBC1B062BA95567F.75350B54E9C44662D7C32DE1CD7F6708C1A25971&dur=2204.665&mime=video%2Fmp4&itag=22&requiressl=yes&mn=sn-n8v7znss%2Csn-4g5e6nsk&source=youtube&mm=31%2C26&ratebypass=yes&ip=37.145.33.107&fvip=3&ms=au%2Conr&id=o-APDwAk6i-h4fTNlzWTiTTPWUXsSC9tB3q8VxNdsyiV58&ei=ThI7XJnwKM3k7gSc356QAg&mv=m&pl=16&mt=1547375010&video_id=h1Q5X-Uv0dw&title=APP+DEVELOPMENT+-+Building+iOS+Apps+with+Firebase"
        print(videoPath)
        //let urlData = NSData(contentsOf: NSURL(string:"\(getDataArray["video_url"] as! String)")! as URL)
        let s = videoPath
        let url = NSURL(string:s)!
        let req = NSMutableURLRequest(url:url as URL)
        _ = URLSessionConfiguration.default
        let task = self.session.downloadTask(with: req as URLRequest)
        self.task = task
        task.resume()

        //-------------------------------------------------------------
        
    }
    
    //MARK:- share video
    func doSomeWorkWithProgress() {
        // This just increases the progress indicator in a loop.
        while progress1 < 1.0 {
            DispatchQueue.main.async(execute: {() -> Void in
                // Instead we could have also passed a reference to the HUD
                // to the HUD to myProgressTask as a method parameter.
                print("Progess dowload \(self.progress1)")
                MBProgressHUD(for: self.view)?.progress = self.progress1
                print("thuan test show percent")
            })
            usleep(50000)
        }
    }
    
    //MARK:- URL Session delegat
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("downloaded \(100*totalBytesWritten/totalBytesExpectedToWrite)")
        var stringValue = "\(100*totalBytesWritten/totalBytesExpectedToWrite)"
        hud?.labelText = NSLocalizedString(stringValue + " %", comment: "Pecent download")

        taskTotalBytesWritten = Int(totalBytesWritten)

        taskTotalBytesExpectedToWrite = Int(totalBytesExpectedToWrite)
        percentageWritten = Float(taskTotalBytesWritten) / Float(taskTotalBytesExpectedToWrite)
        print(percentageWritten)
        //  let x = Double(percentageWritten).rounded(toPlaces: 2)
        let x = String(format:"%.2f", percentageWritten)
        print(x)
        self.progress1 = Float(x)!
        print(progress1)
        
//        let written = byteFormatter.string(fromByteCount: totalBytesWritten)
//        let expected = byteFormatter.string(fromByteCount: totalBytesExpectedToWrite)
//        print("Downloaded \(written) / \(expected)")
//
//        DispatchQueue.main.async {
//            self.progressView.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
//        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        // unused in this example
    }
    
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("completed: error: \(error)")
    }
    
    var zipPath : URL?
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading!")
        let fileManager = FileManager()
        // this can be a class variable
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(directoryURL)
        let docDirectoryURL = NSURL(fileURLWithPath: "\(directoryURL)")
        print(docDirectoryURL)
        // Get the original file name from the original request.
        //print(lastPathComponent)
        let destinationFilename = downloadTask.originalRequest?.url?.lastPathComponent
        print(destinationFilename!)
        // append that to your base directory
        let destinationURL =  docDirectoryURL.appendingPathComponent("\(destinationFilename!)")
        self.zipPath = destinationURL!
        print(destinationURL!)
        /* check if the file exists, if so remove it. */
        if let path = destinationURL?.path {
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(at: destinationURL!)
                    
                } catch let error as NSError {
                    print(error.debugDescription)
                }
                
            }
        }
        
        do
        {
            try fileManager.copyItem(at: location, to: destinationURL!)
        }
        catch {
            print("Error while copy file")
            
        }
        DispatchQueue.main.async(execute: {() -> Void in
            MBProgressHUD.hide(for: self.view, animated: true)
        })
        // let videoLink = NSURL(fileURLWithPath: filePath)
        let objectsToShare = [destinationURL!] //comment!, imageData!, myWebsite!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare , applicationActivities: nil)
        activityVC.setValue("Video", forKey: "subject")
        //New Excluded Activities Code
        if #available(iOS 9.0, *) {
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList, UIActivityType.assignToContact, UIActivityType.copyToPasteboard, UIActivityType.mail, UIActivityType.message, UIActivityType.openInIBooks, UIActivityType.postToTencentWeibo, UIActivityType.postToVimeo, UIActivityType.postToWeibo, UIActivityType.print]
        } else {
            // Fallback on earlier versions
            activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList, UIActivityType.assignToContact, UIActivityType.copyToPasteboard, UIActivityType.mail, UIActivityType.message, UIActivityType.postToTencentWeibo, UIActivityType.postToVimeo, UIActivityType.postToWeibo, UIActivityType.print ]
        }
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = self.btnShareVideo
            popoverController.sourceRect = self.btnShareVideo.bounds
            
        }
        self.present(activityVC, animated: true, completion: nil)
    }
    //Unzip file
    
    @IBOutlet weak var progressLabel: UILabel!
    var isObservingProgress = false
    var progressViewKVOContext = 0
    
    @objc
    var progress: Progress?
    
    func startObservingProgress()
    {
        guard !isObservingProgress else { return }
        
        progress = Progress()
        progress?.completedUnitCount = 0
//        self.indicator.progress = 0.0
        
        self.addObserver(self, forKeyPath: #keyPath(progress.fractionCompleted), options: [.new], context: &progressViewKVOContext)
        isObservingProgress = true
    }
    
    func stopObservingProgress()
    {
        guard isObservingProgress else { return }
        
        self.removeObserver(self, forKeyPath: #keyPath(progress.fractionCompleted))
        isObservingProgress = false
        self.progress = nil
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(progress.fractionCompleted) {
            DispatchQueue.main.async {
             print(Float(self.progress?.fractionCompleted ?? 0.0))
                if let progressDescription = self.progress?.localizedDescription {
                    self.progressLabel.text = progressDescription
                }
                
                if self.progress?.isFinished == true {
                    self.progressLabel.text = ""
//                    self.indicator.progress = 0.0
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.progress?.cancel()
    }
    

    @IBAction func unzipPressed(_: UIButton) {
        

        let fileManager = FileManager()
        print("------------------")
//        print(self.zipPath!)
        
        do {
            

            
//            try fileManager.createDirectory(at: des, withIntermediateDirectories: true, attributes: nil)
            
            let url = URL(string: "/Users/asto/Desktop/Demo/")
            print(url)
             try fileManager.unzipItem(at: self.zipPath!, to: url!, progress: self.progress)
//            try fileManager.unzipItem(at: self.zipPath!, to: url!)

    

            
            self.startObservingProgress()
            DispatchQueue.global().async {

//                try? FileManager.default.unzipItem(at: self.zipPath!, to: self.zipPath!, progress: self.progress)
                self.stopObservingProgress()
            }
            
        } catch {
            print("Extraction of ZIP archive failed with error:\(error)")
        }
    }
//    func tempUnzipPath() -> String? {
//        var path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
//        path += "/\(UUID().uuidString)"
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
//        } catch {
//            return nil
//        }
//        return url.path
//    }
    
}


extension ViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(
        _ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
extension FileZipViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerViewControllerForPreview(
        _ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
    
}
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

