//
//  InterfaceController.swift
//  LohmanSean_CE02 WatchKit Extension
//
//  Created by Sean Lohman on 5/13/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var itemArray = [Item]()
    fileprivate let watchSession: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    @IBOutlet var tableView: WKInterfaceTable!
    
    override init() {
        super.init()
        watchSession?.delegate = self
        watchSession?.activate()
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
//        tableView.setNumberOfRows(PersonArray().personArray.count, withRowType: rowID)
        getItems()
        
        tableView.setNumberOfRows(10, withRowType: "customRow")
        
        for i in 0 ..< dataArray().arrayOfItems.count {
            let row = tableView.rowController(at: i) as! CustomRow
            row.rowImage.setImageNamed(dataArray().arrayOfItems[i].Pic)
        }
        
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if segueIdentifier != "segueToDetail"{
            return nil
        }
        
        let contextForSegue = dataArray().arrayOfItems[rowIndex]
        
        return contextForSegue
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    func getItems(){
        let myValues:[String:Any] = ["getData":true]
        
        if let session = watchSession, session.isReachable{
            session.sendMessage(myValues, replyHandler: {
                replyData in
                print(replyData)
                
                DispatchQueue.main.async {
                    if let data = replyData["newItem"] as? Data{
                        NSKeyedUnarchiver.setClass(Item.self, forClassName: "Item")
                        if let itemObject = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Item]{
                            self.itemArray = itemObject
                        }
                    }
                }
                
            }, errorHandler: nil)
        }
    }

}
