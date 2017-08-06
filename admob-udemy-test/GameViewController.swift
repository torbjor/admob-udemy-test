//
//  GameViewController.swift
//  admob-udemy-test
//
//  Created by Torbjorn schandall on 8/1/17.
//  Copyright © 2017 Torbjorn schandall. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Firebase

class GameViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerLandscape)

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeAds()
        
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func deviceOrientationDidChange() {
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
            bannerView.adSize = kGADAdSizeSmartBannerPortrait
        }
        else {
            bannerView.adSize = kGADAdSizeSmartBannerLandscape
        }
    }
    
    func initializeAds() {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        bannerView.isHidden = true
        
        bannerView.delegate = self
        
        bannerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        /* Admob test id from https://developers.google.com/admob/ios/banner */
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        bannerView.isHidden = false
        print("Error: \(error.localizedDescription)")
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .all
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
