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

class ViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {

    
    
    let data = Data()
    @IBOutlet weak var topView: UIView!
    
   // var timerAd:NSTimer?
    var AdNumber = 0
    var audioPlayer: AVAudioPlayer?
   
    
    var gBannerView: GADBannerView!
    //    var startAppBanner: STABannerView?
    //    var startAppAd: STAStartAppAd?
    
    var timerVPN:NSTimer?
    
    var isStopAD = true
    
    @IBOutlet weak var textDevice: UITextView!
    
    var interstitial: GADInterstitial!
    
    
    @IBOutlet weak var webView: UIWebView!
    //new funciton
    @IBOutlet weak var AdOption: UIView!
    @IBOutlet weak var AdmobCheck: UISwitch!
    //@IBOutlet weak var AmazonCheck: UISwitch!
    @IBOutlet weak var ChartboostCheck: UISwitch!
    
    var isAdmob = true;
    var isAmazon = false
    var isChart = false
    
    var isShowFullAdmob = false
    var isShowFllAmazon = false
    var isShowChartboostFirst = false
    var timerAdmobFull:NSTimer?
    
    //end new funciton
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        CheckAdOptionValue()
        if(showAd())
        {
            ShowAdmobBanner()
            if(isAdmob)
            {
                
                self.interstitial = self.createAndLoadAd()
            }
            isStopAD = false
        }
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        self.timerAdmobFull = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "timerAdmobFull:", userInfo: nil, repeats: true)
       
        
        
        
        AdOption.hidden = true
        topView.hidden = true
        LoadWebView()
       
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
            //println(text2)
            // textv1.text=text2
            //            let mainB =  NSBundle.mainBundle()
            //            let requestURL1 = mainB.bundleURL
            
            
            let baseURL = NSBundle.mainBundle().URLForResource("html/index", withExtension: "html")
            webView.loadHTMLString(text2!, baseURL: baseURL)
            
          
        }

    
    }
    
    
    
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: data.gFull)
        //ad.delegate = self
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, data.TestDeviceID]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    func ShowAdmobBanner()
    {
        let w = view?.bounds.width
        let h = view?.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, (h! - 50) , w!, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
    {
        let abc = cclass()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        return true
    }
    
    
    
    func showAds()
    {
        
        Chartboost.showInterstitial("Home" + String(AdNumber))
        
        AdNumber++
        
        if(AdNumber > 7)
        {
            //adView.backgroundColor = UIColor.redColor()
        }
        print(AdNumber)
    }
    func timerMethodAutoAd(timer:NSTimer) {
        print("auto play")
        // adView.backgroundColor = UIColor.redColor()
        
        showAds()
        
    }
    
    
    
    
//    @IBAction func hover(sender: AnyObject) {
//        //auto
//        showAdmob()
//        self.timerAd = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "timerMethodAutoAd:", userInfo: nil, repeats: true)
//    }
    
    
    
    
    //click button
    
//    @IBAction func moreapp1Click(sender: AnyObject) {
//        showAdmob()
//    }
    
    
    func CheckAdOptionValue()
    {
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Admob") != nil)
        {
            isAdmob = NSUserDefaults.standardUserDefaults().objectForKey("Admob") as! Bool
            
        }
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Amazon") != nil)
        {
            isAmazon = NSUserDefaults.standardUserDefaults().objectForKey("Amazon")as! Bool
            
        }
        
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("Chart") != nil)
        {
            isChart = NSUserDefaults.standardUserDefaults().objectForKey("Chart") as! Bool
            
        }
        AdmobCheck.on = isAdmob
        
        ChartboostCheck.on = isChart
    }

    
    //Form Event
    @IBAction func moreGameClick(sender: AnyObject) {
//        let barsLink : String = "itms-apps://itunes.apple.com/ca/developer/phuong-nguyen/id1004963752"
//        UIApplication.sharedApplication().openURL(NSURL(string: barsLink)!)
showAds()
    }
    
    @IBAction func Click(sender: AnyObject) {
        showAds()
    }
    
    @IBAction func startGameHover(sender: AnyObject) {
        
        //if (startAppBanner == nil) {
        //   startAppBanner = STABannerView(size: STA_AutoAdSize, autoOrigin: STAAdOrigin_Bottom, withView: self.view, //withDelegate: nil);
        //self.view.addSubview(startAppBanner!)
        //}
        let myIDFA: String?
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        } else {
            myIDFA = nil
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        AdOption.hidden = false
        topView.hidden = false
        
        textDevice.text = "IDFA: \n" + myIDFA! + "\nVendorID: \n" + venderID
        
        
    }
    
    //end click button
       //Save ADOption
    @IBAction func GoogleChange(sender: UISwitch) {
        //if(AdmobCheck.on)
        //{
        
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Admob")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAdmob = sender.on
        //
        // }
        
    }
    
//    @IBAction func AmazonChange(sender: UISwitch) {
//        //        if(AmazonCheck.on)
//        //        {
//        
//        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Amazon")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        isAmazon = sender.on
//        //}
//    }
    
    @IBAction func СhartBoostChanged(sender: UISwitch) {
        
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"Chart")
        NSUserDefaults.standardUserDefaults().synchronize()
        isChart = sender.on
        
    }
    
    
    
    //timer 
    
    func timerAdmobFull(timer:NSTimer) {
        //var isShowFullAdmob = false
        //var isShowFllAmazon = false
        //var isShowChartboostFirst = false
        if(showAd())
        {
            if(isChart && isShowChartboostFirst == false)
            {
                
                Chartboost.showInterstitial("First stage")
                isShowChartboostFirst = true;
                //timerAdmobFull?.invalidate()
                
                
            }
            if(isAdmob && isShowFullAdmob == false)
            {
                
                if(self.interstitial.isReady)
                {
                    showAdmob()
                    //timerAdmobFull?.invalidate()
                    isShowFullAdmob = true;
                }
            }
        }
        
        
        
        
    }
    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            print("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            print("Stop showing Ad from admob......")
        }
    }
    
    
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        gBannerView?.hidden = false
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        gBannerView?.hidden = false
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    



}

