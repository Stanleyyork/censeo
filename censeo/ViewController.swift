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
                let string = String(data: data, encoding: String.Encoding.utf8)
                let currentRecord = self.convertToDictionary(text: string!)
                
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
            }
        }
        task.resume()
    }
    
    func setTitleText(text: String){
        expenseRecordDetails.text = ""
        expenseRecord.text = text
    }
    
    func setCostText(text: String){
        expenseRecordDetails.text = ""
        expenseRecordCost.text = text
    }
    
    func setDetailsText(){
        expenseRecordDetails.text = currentRecordDetails
    }
    
    func setRatedAs(text: String){
        ratedAs.text = text
    }
    
    func updateRecordViaApi(){
        // Update record via API (PUT)
    }
    
    func rateAsAOne(){
        setRatedAs(text: "1")
        getRecordViaApi()
    }
    
    func rateAsATwo(){
        setRatedAs(text: "2")
        getRecordViaApi()
    }
    
    func rateAsAThree(){
        setRatedAs(text: "3")
        getRecordViaApi()
    }
    
    func rateLater(){
        setRatedAs(text: "Later")
        getRecordViaApi()
    }
    
    func moreDetails(){
        setRatedAs(text: "...")
        setDetailsText()
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

