//
//  ViewController.swift
//  HTML5 Game
//
//  Created by Phuong Nguyen on 12/29/15.
//  Copyright © 2015 Phuong Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var webView: UIWebView!
    //new funciton
    //end new funciton
    override func viewDidLoad() {
        super.viewDidLoad()
              LoadWebView()
        let myad = MyAd(root: self)
        myad.ViewDidload()
    }
//    func loadMMFULL()
//    {
//        self.mmFULL = MMInterstitialAd.init(placementId: data.MMediaFull)
//        self.mmFULL.delegate = self;
//        //self.mmFULL.modalTransitionStyle = MMa UIModalTransitionStyleCoverVertical;
//        mmFULL.load(nil)
//        mmFULL.showFromViewController(self)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func LoadWebView()
    {
        if let path = NSBundle.mainBundle().pathForResource("html2/ku", ofType: "htm") {
            // use path
            let text2 = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            //println(text2)
            // textv1.text=text2
            //            let mainB =  NSBundle.mainBundle()
            //            let requestURL1 = mainB.bundleURL
            
            
            let baseURL = NSBundle.mainBundle().URLForResource("html2/ku", withExtension: "htm")
            webView.loadHTMLString(text2!, baseURL: baseURL)
            
          
        }

    
    }
    
    
 
   

    
    //Form Event
    @IBAction func moreGameClick(sender: AnyObject) {
         Utility.MoreGame()
    }
    
    @IBAction func Click(sender: AnyObject) {
        
    }
    
    @IBAction func startGameHover(sender: AnyObject) {         
        Utility.OpenView("AdView1",view: self)
    }
    
 
 
    
        
        
    }
 
 
    
    

 