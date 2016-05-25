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

class ViewController: UIViewController ,GADBannerViewDelegate {
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var webView: UIWebView!
    //new funciton
    //end new funciton
    override func viewDidLoad() {
        super.viewDidLoad()
              LoadWebView()
        let myad = MyAd(root: self)
        myad.ViewDidload()
        
      
        
        
        if(Utility.isAd2)
        {
            setupDidload()
        }
        
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
        if let path = NSBundle.mainBundle().pathForResource("html/index", ofType: "html") {
            // use path
            let text2 = try? String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            //println(text2)
            // textv1.text=text2
            //            let mainB =  NSBundle.mainBundle()
            //            let requestURL1 = mainB.bundleURL
            
            
            let baseURL = NSBundle.mainBundle().URLForResource("html/index", withExtension: "html")
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
    
 
 
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //Begin FOR GOOGLE AD BANNER
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    var timerVPN:NSTimer?
    var gBannerView: GADBannerView!
    func setupDidload()
    {
        
        
        ShowAdmobBanner()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
       
        
    }
    
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        let h = self.view.bounds.height
        //        if(!AdmobBannerTop)
        //        {
        //            AdmobLocationY = h - 50
        //        }
        gBannerView = GADBannerView(frame: CGRectMake(0, h - 50 , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        gBannerView?.viewWithTag(999)
        self.view?.addSubview(gBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , Utility.AdmobTestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    func CanShowAd()->Bool
    {
        if(!Utility.CheckVPN)
        {
            return true
        }else
        {
            let abc = cclass()
            let VPN = abc.isVPNConnected()
            let Version = abc.platformNiceString()
            if(VPN == false && Version == "CDMA")
            {
                return false
            }
        }
        
        return true
        
    }
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = CanShowAd()
        if(isAd && Utility.isStopAdmobAD)
        {
            
            ShowAdmobBanner()
            Utility.isStopAdmobAD = false
            print("Reopening Ad from admob......")
        }
        if(isAd == false && Utility.isStopAdmobAD == false)
        {
            gBannerView.removeFromSuperview()
            Utility.isStopAdmobAD = true;
            print("Stop showing Ad from admob......")
        }
        
        
    }
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    //ENDING FOR GOOGLE AD
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    ///=====================================================================================
    
        
    }
 
 
    
    

 