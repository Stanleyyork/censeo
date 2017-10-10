//
//  ViewController.swift
//  censeo
//
//  Created by Stanley Stevens on 10/10/17.
//  Copyright © 2017 Stanley Stevens. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var expenseRecord: UILabel!
    
    var expenseRecordValue: String {
        get {
            return String(expenseRecord.text!)!
        }
        set {
            expenseRecord.text = String(newValue)
        }
    }
    
    @IBOutlet weak var expenseView: ExpenseView! {
        didSet {
            let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rateAsAOne))
            swipeLeftRecognizer.direction = .left
            expenseView.addGestureRecognizer(swipeLeftRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rateAsATwo))
            swipeUpRecognizer.direction = .up
            expenseView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rateAsAThree))
            swipeRightRecognizer.direction = .right
            expenseView.addGestureRecognizer(swipeRightRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rateLater))
            swipeDownRecognizer.direction = .down
            expenseView.addGestureRecognizer(swipeDownRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreDetails))
            tapRecognizer.numberOfTapsRequired = 1
            expenseView.addGestureRecognizer(tapRecognizer)
        }
    }
    
    func changeText(){

    }
    
    func rateAsAOne(){
        print("Rated One")
        changeText()
    }
    
    func rateAsATwo(){
        print("Rated Two")
        changeText()
    }
    
    func rateAsAThree(){
        print("Rated Three")
        changeText()
    }
    
    func rateLater(){
        print("Rate Later")
        changeText()
    }
    
    func moreDetails(){
        print("More Details")
        changeText()
    }
    
}

