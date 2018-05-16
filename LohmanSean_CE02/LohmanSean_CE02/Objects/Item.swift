//
//  Item.swift
//  LohmanSean_CE02
//
//  Created by Sean Lohman on 5/13/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding  {
    
    var Name: String?
    var Pic: String?
    var Power: String?
    
    init(name: String, pic: String, power: String) {
        self.Name = name
        self.Pic = pic
        self.Power = power
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Name, forKey: "nameString")
        aCoder.encode(Pic, forKey: "picString")
        aCoder.encode(Power, forKey: "powerString")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(name: "Broken", pic: "Broken", power: "Broken")
        
        Name = aDecoder.decodeObject(forKey: "nameString") as? String
        Pic = aDecoder.decodeObject(forKey: "picString") as? String
        Power = aDecoder.decodeObject(forKey: "powerString") as? String
        
    }
    
}

class dataArray: NSObject{
    var arrayOfItems = [Item]()

    override init() {
        arrayOfItems.append(Item.init(name: "Burner Inserter", pic: "Burner", power: "188kw"))
        arrayOfItems.append(Item.init(name: "Inserter", pic: "Inserter", power: "220kw"))
        arrayOfItems.append(Item.init(name: "Long Inserter", pic: "Long", power: "280kw"))
        arrayOfItems.append(Item.init(name: "Fast Inserter", pic: "Fast", power: "315kw"))
        arrayOfItems.append(Item.init(name: "Filter Inserter", pic: "Filter", power: "400kw"))
        arrayOfItems.append(Item.init(name: "Express Transporter Belt", pic: "Express", power: "380kw"))
        arrayOfItems.append(Item.init(name: "Stack Inserter", pic:"Stack", power: "450kw"))
        arrayOfItems.append(Item.init(name: "Stack Filter Inserter", pic: "Stack_filter", power: "420kw"))
        arrayOfItems.append(Item.init(name: "Transporter Belt", pic: "Transport", power: "70kw"))
        arrayOfItems.append(Item.init(name: "Fast Transporter Belt", pic: "Fast_transport", power: "120kw"))
        
    }
    
}
