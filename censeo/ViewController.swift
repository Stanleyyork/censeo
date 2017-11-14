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
    @IBOutlet weak var expenseRecordCost: UILabel!
    @IBOutlet weak var expenseRecordDetails: UILabel!
    @IBOutlet weak var ratedAs: UILabel!
    
    var currentRecordId: String = "0"
    var currentRecordDetails: String = ""
    var expenses = [[String:AnyObject]]()
    var expenseArray = [[[String:AnyObject]]]();
    var i = 1
    
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
            
            getRecordViaApi()
        }
    }
    
    func getRecordViaApi(){
        // Get record via API (GET)
        let session = URLSession.shared
        let url = URL(string: "http://www.alexandriaai.com/api/expenses")!
        let task = session.dataTask(with: url) { (data, _, _) -> Void in
            if let data = data {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:AnyObject]
                    let expenses = parsedData["expenses_array"] as? [[String:AnyObject]]
                    let currentRecord = expenses?.first
                    let currentRecordIdCasted = currentRecord?["id"] as? String ?? "Null"
                    self.currentRecordId = currentRecordIdCasted
                    
                    let currentRecordTitle = currentRecord?["description"] as? String ?? "Null"
                    self.setTitleText(text: currentRecordTitle)
                        
                    let currentRecordCost = currentRecord?["amount"] as? String ?? "Null"
                    self.setCostText(text: currentRecordCost)
                        
                    let orig_description: String? = currentRecord?["original_description"] as? String ?? "Null"
                    let category: String? = currentRecord?["category"] as? String ?? "Null"
                    let date: String? = currentRecord?["date"] as? String ?? "Null"
                        
                    self.currentRecordDetails = String("\(orig_description!), \(category!), \(date!)")
                    
                    self.expenseArray.append(expenses!)
                } catch  {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func setNext(){
        let currentRecord = expenseArray[0][i]
        setTitleText(text: (currentRecord["description"] as? String)!)
        setCostText(text: (currentRecord["amount"] as? String)!)
        i = i + 1
    }
    
    func setTitleText(text: String){
        expenseRecordDetails.text = ""
        expenseRecord.text = text
    }
    
    func setCostText(text: String){
        expenseRecordDetails.text = ""
        expenseRecordCost.text = text
    }
    
    func setDetailsText(text: String){
        expenseRecordDetails.text = text
    }
    
    func setRatedAs(text: String){
        ratedAs.text = text
    }
    
    func updateRecordViaApi(){
        // Update record via API (PUT)
    }
    
    func rateAsAOne(){
        setRatedAs(text: "1")
        //updateRecordViaApi()
        setNext()
    }
    
    func rateAsATwo(){
        setRatedAs(text: "2")
        //updateRecordViaApi()
        setNext()
    }
    
    func rateAsAThree(){
        setRatedAs(text: "3")
        //updateRecordViaApi()
        setNext()
    }
    
    func rateLater(){
        setRatedAs(text: "Later")
        setNext()
    }
    
    func moreDetails(){
        setRatedAs(text: "...")
        let currentRecord = i == 0 ? expenseArray[0][i] : expenseArray[0][i-1]
        let orig_description: String? = currentRecord["original_description"] as? String ?? "Null"
        let category: String? = currentRecord["category"] as? String ?? "Null"
        let date: String? = currentRecord["date"] as? String ?? "Null"
        
        let detail = String("\(orig_description!), \(category!), \(date!)")
        setDetailsText(text: detail!)
    }
}

