//
//  Coffee.swift
//  LohmanSean_CoffeeApp
//
//  Created by Sean Lohman on 5/12/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import Foundation

class Coffee{
    var name: String
    var size: String
    var caffeine: String
    var sugar: String
    
    init(name: String, size: String, caffeine: String, sugar:String) {
        self.name = name
        self.caffeine = caffeine
        self.sugar = sugar
        self.size = size
    }
}
