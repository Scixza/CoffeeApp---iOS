//
//  DetailInterfaceController.swift
//  LohmanSean_CE02 WatchKit Extension
//
//  Created by Sean Lohman on 5/14/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {

    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var powerLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        
        if let item = context as? Item{
            nameLabel.setText(item.Name)
            powerLabel.setText(item.Power)
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
