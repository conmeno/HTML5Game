//
//  ViewController.swift
//  HTML5 Game
//
//  Created by Phuong Nguyen on 12/29/15.
//  Copyright © 2015 Phuong Nguyen. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController {

    
    
    let data = Data()
       var audioPlayer: AVAudioPlayer?
   
    
    
    @IBOutlet weak var webView: UIWebView!
    
    //end new funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadWebView()
        
        
        let myAd = MyAd(root: self)
        
        myAd.ViewDidload()

       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func LoadWebView()
    {
        if let path = NSBundle.mainBundle().pathForResource("html/index", ofType: "html") {
            // use path
            let text2 = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                      
            let baseURL = NSBundle.mainBundle().URLForResource("html/index", withExtension: "html")
            webView.loadHTMLString(text2!, baseURL: baseURL)
            
          
        }

    
    }
    
    
    
    
   
    
    //Form Event
    @IBAction func moreGameClick(sender: AnyObject) {
        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
//showAds()
    }
    
    @IBAction func Click(sender: AnyObject) {
        //showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("AdView1") as UIViewController
        
        self.presentViewController(WebDetailView, animated: true, completion: nil)
        
    }



}

