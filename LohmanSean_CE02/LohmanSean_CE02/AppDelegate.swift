//
//  AppDelegate.swift
//  LohmanSean_CE02
//
//  Created by Sean Lohman on 5/13/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var session: WCSession? {
        didSet{
            if let session = session{
                session.delegate = self
                session.activate()
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if WCSession.isSupported() {
            session = WCSession.default
        }
        
        return true
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
        func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
            DispatchQueue.main.async {
    
                if(message["getData"] as? Bool) != nil{
                    NSKeyedArchiver.setClassName("Item", for: Item.self)
                    let itemObject = dataArray().arrayOfItems
                    let data = NSKeyedArchiver.archivedData(withRootObject: itemObject)
                    replyHandler(["newItem": data])
                }
            }
        }
    
}

