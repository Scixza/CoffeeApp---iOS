//
//  AddCoffeeController.swift
//  LohmanSean_CoffeeApp
//
//  Created by Sean Lohman on 5/14/18.
//  Copyright © 2018 Sean Lohman. All rights reserved.
//

import UIKit
import GravitySliderFlowLayout

class AddCoffeeController: UIViewController, UINavigationControllerDelegate {

    let gradientFirstColor = UIColor(hex: "c4923e").cgColor
    let gradientSecondColor = UIColor(hex: "6a3005").cgColor
    let cellsShadowColor = UIColor(hex: "2a002a").cgColor
    
    var coffeeArray = [Coffee]()
    var coffeeToAdd:Coffee!
    var indexPathFirstRow = 0
    
    let collectionViewCellHeightCoefficient: CGFloat = 0.85
    let collectionViewCellWidthCoefficient: CGFloat = 0.55
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coffeeButton: UIButton!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var coffeeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureCollectionView()
        coffeeButton.layer.cornerRadius = 10
        coffeeLabel.text = coffeeArray[0].name
        navigationController?.delegate = self
        
        print("Segue Success! Add Coffee Screen!")
    }
    
    @IBAction func AddCoffee(_ sender: Any) {
        coffeeToAdd = coffeeArray[indexPathFirstRow]
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }
    
    
}

extension AddCoffeeController{
    private func configureCollectionView() {
        let gravitySliderLayout = GravitySliderFlowLayout(with: CGSize(width: collectionView.frame.size.height * collectionViewCellWidthCoefficient, height: collectionView.frame.size.height * collectionViewCellHeightCoefficient))
        
        collectionView.collectionViewLayout = gravitySliderLayout
        collectionView.dataSource = self
        collectionView.delegate = self
        
        pageController.numberOfPages = coffeeArray.count
    }
    
    private func configureProductCell(_ cell: CoffeeViewCell, for indexPath: IndexPath) {
        cell.clipsToBounds = false
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [gradientFirstColor, gradientSecondColor]
        gradientLayer.cornerRadius = 21
        gradientLayer.masksToBounds = true
        cell.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.layer.shadowColor = cellsShadowColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 30)
        
        cell.coffeeImage.image = UIImage.init(named: "cup")
        
        cell.sizeLabel.text = coffeeArray[indexPath.row].size
        cell.sizeLabel.layer.cornerRadius = 8
        cell.sizeLabel.clipsToBounds = true
        cell.sizeLabel.layer.borderColor = UIColor.white.cgColor
        cell.sizeLabel.layer.borderWidth = 1.0
    }
    
    private func animateChangingTitle(for indexPath: IndexPath) {
        
        UIView.transition(with: coffeeLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.coffeeLabel.text = self.coffeeArray[indexPath.row % self.coffeeArray.count].name
        }, completion: nil)
    }
}

extension AddCoffeeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coffeeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoffeeView", for: indexPath) as! CoffeeViewCell
        self.configureProductCell(cell, for: indexPath)
        return cell
    }
}

extension AddCoffeeController: UICollectionViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationFirst = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationSecond = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x + 20, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationThird = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x - 20, y: collectionView.center.y + scrollView.contentOffset.y)
        
        if let indexPathFirst = collectionView.indexPathForItem(at: locationFirst), let indexPathSecond = collectionView.indexPathForItem(at: locationSecond), let indexPathThird = collectionView.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageController.currentPage {
            indexPathFirstRow = indexPathFirst.row
            pageController.currentPage = indexPathFirst.row
            self.animateChangingTitle(for: indexPathFirst)
        }
    }
    
}





