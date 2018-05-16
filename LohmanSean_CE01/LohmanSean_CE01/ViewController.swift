//
//  ViewController.swift
//  LohmanSean_CE01
//
//  Created by Sean Lohman on 4/30/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    let SUUID = CBUUID(string: "06B280C1-419D-4D87-810E-00D88B506717")
    let CUUID = CBUUID(string: "CD570797-087C-4008-B692-7835A1246377")
    var tag:Int!
    var advertisingData:Dictionary<String, Any>!
    var transferCharacteristic:CBMutableCharacteristic!
    //var peripheral:CBPeripheral!
    var manager:CBPeripheralManager!
    
    @IBOutlet weak var button_1: UIButton!
    @IBOutlet weak var button_2: UIButton!
    @IBOutlet weak var button_3: UIButton!
    @IBOutlet weak var button_4: UIButton!
    @IBOutlet weak var button_: UIButton!
    @IBOutlet weak var button_6: UIButton!
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        print("state: \(peripheral.state)")
        
        if peripheral.state == .poweredOn{
            
            for btn in [button_1, button_2, button_3, button_4, button_, button_6]{
                btn?.isEnabled = true
            }
            
            transferCharacteristic = CBMutableCharacteristic.init(type: CUUID, properties: CBCharacteristicProperties.notify, value: nil, permissions: CBAttributePermissions.readable)
            
            let myService = CBMutableService.init(type: SUUID, primary: true)
            
            myService.characteristics = [transferCharacteristic]
            
            self.manager.add(myService)
            
            self.advertisingData = [CBAdvertisementDataLocalNameKey : "LohmanSeanCE01", CBAdvertisementDataServiceUUIDsKey: [SUUID]]
            
            self.manager.startAdvertising(self.advertisingData)
        }else {
            for btn in [button_1, button_2, button_3, button_4, button_, button_6]{
                btn?.isEnabled = false
            }
        }
        
    }
    
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {

    }
    
    @IBAction func button_clicked(_ sender: Any) {
    
        tag = (sender as! UIButton).tag + 1 //.TAG to know which button was pressed
        
        let sentData = String(tag).data(using: .utf8)
        
        self.manager.updateValue(sentData!, for: self.transferCharacteristic, onSubscribedCentrals: nil)
        
    }
    
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if let error = error{
            print("Failed with error: \(error)")
            return
        }
        print("succeeded!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for btn in [button_1, button_2, button_3, button_4, button_, button_6]{
            btn?.isEnabled = false
        }
            
        
        
        //Initializing Pheripheral Manager
        manager = CBPeripheralManager.init(delegate: self, queue: nil)
    }
    
}

