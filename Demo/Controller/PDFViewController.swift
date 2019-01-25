//
//  PDFViewController.swift
//  Demo
//
//  Created by asto on 1/9/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import PDFKit
class PDFViewController: UIViewController {
    var downloadTask: URLSessionDownloadTask?
    var backgroundSession: URLSession?
    var pdfView = PDFView()
    var pdfURL: URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(pdfView)
        
//        if let document = PDFDocument(url: pdfURL) {
//            pdfView.document = document
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.dismiss(animated: true, completion: nil)
//        }
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewDidLayoutSubviews() {
//        pdfView.frame = view.frame
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func open(_ sender: UIButton) {
        if let url = Bundle.main.url(forResource: "test", withExtension: "pdf") {
            print("==========")
            let webView = UIWebView(frame: self.view.frame)
            let urlRequest = URLRequest(url: url)
            webView.loadRequest(urlRequest as URLRequest)
            self.view.addSubview(webView)

        }
        
//        let pdfView = PDFView()
//
//        pdfView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(pdfView)
//
//        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
//        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        pdfView.topAnchor.constraint(equalTo: view.topAnchor, constant:25).isActive = true
//        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//
//        guard let path = Bundle.main.url(forResource: "test", withExtension: "pdf") else { return }
//
//        if let document = PDFDocument(url: path) {
//            pdfView.document = document
//        }
        
        
    }
    
    
    @IBAction func dl(_ sender: UIButton) {
        guard let url = URL(string: "https://www.tutorialspoint.com/swift/swift_tutorial.pdf") else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
}

extension PDFViewController:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            self.pdfURL = destinationURL
            print(self.pdfURL)
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}


