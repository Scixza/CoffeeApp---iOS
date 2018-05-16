//
//  ViewController.swift
//  LohmanSean_CoffeeApp
//
//  Created by Sean Lohman on 5/12/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import UIKit
import CircleMenu

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var coffeeArray = [Coffee]()
    var coffeeConsumed = [Coffee]()
    var ozDrank = 0
    var sugarDrank = 0
    var caffeineDrank = 0
    var cupsDrank = 0
    
    let items: [(icon: String, color: UIColor)] = [
        ("minus", UIColor(red: 1, green: 0.22, blue: 0.19, alpha: 1)),
        ("add", UIColor(red: 0.40, green: 1, blue: 0.50, alpha: 1)),
        ]
    
    @IBOutlet weak var caffeineLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var ozLabel: UILabel!
    @IBOutlet weak var cupLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var circleMenuButton: CircleMenu!
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        
        if segue.source is AddCoffeeController{
            if let senderVC = segue.source as? AddCoffeeController{
                print("Adding coffee to add and refreshing tableView")
                coffeeConsumed.append(senderVC.coffeeToAdd)
                
                updateUI()
                
                tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        circleMenuButton.delegate = self
        createDefaults()
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coffeeConsumed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeID", for: indexPath)
        cell.textLabel?.text = coffeeConsumed[indexPath.row].name
        cell.detailTextLabel?.text = coffeeConsumed[indexPath.row].size
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func createDefaults(){
        coffeeArray.append(Coffee.init(name: "Caramel Frappucino", size: "24oz", caffeine: "130mg", sugar: "84g"))
        coffeeArray.append(Coffee.init(name: "Caramel Frappucino", size: "16oz", caffeine: "100mg", sugar: "66g"))
        coffeeArray.append(Coffee.init(name: "Caramel Frappucino", size: "12oz", caffeine: "70mg", sugar: "46g"))
        coffeeArray.append(Coffee.init(name: "Mocha Frappucino", size: "24oz", caffeine: "140mg", sugar: "80g"))
        coffeeArray.append(Coffee.init(name: "Mocha Frappucino", size: "16oz", caffeine: "110mg", sugar: "61g"))
        coffeeArray.append(Coffee.init(name: "Mocha Frappucino", size: "12oz", caffeine: "75mg", sugar: "42g"))
    }
    
    func updateUI(){
        ozDrank = 0
        caffeineDrank = 0
        cupsDrank = 0
        sugarDrank = 0
        for i in coffeeConsumed{
            let size = (Int) (i.size.dropLast(2))
            let sugar = (Int) (i.sugar.dropLast(2))
            let caffeine = (Int) (i.sugar.dropLast(2))
            
            ozDrank += size!
            sugarDrank += sugar!
            caffeineDrank += caffeine!
            cupsDrank += 1
            
            ozLabel.text = "Oz of coffee consumed: \(ozDrank)oz"
            cupLabel.text = "Cups of coffee consumed: \(cupsDrank) cups"
            caffeineLabel.text = "Caffeine consumed: \(caffeineDrank)mg"
            sugarLabel.text = "Sugar consumed: \(sugarDrank)g"
        }
    }
    
    
}

extension ViewController: CircleMenuDelegate {
    
    // MARK: <CircleMenuDelegate>
    
    func circleMenu(_: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    }
    
    func circleMenu(_: CircleMenu, buttonDidSelected _: UIButton, atIndex: Int) {
        switch atIndex {
        case 1:
            //segue
            performSegue(withIdentifier: "addCoffeeSegue", sender: self)
            break
        case 2:
            //segue
            
            break
        default:
            print("button did click: \(items[atIndex].icon)")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "addCoffeeSegue"{
            if let addCoffeeView = segue.destination as? AddCoffeeController{
                addCoffeeView.coffeeArray = self.coffeeArray
            }
        }
    }
}

