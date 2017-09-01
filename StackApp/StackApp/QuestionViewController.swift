//
//  QuestionViewController.swift
//  StackApp
//
//  Created by John on 8/22/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StackManagerDelegate{
    
    let stackManager = StackManager()
    // let listQuestions: [Question] = []
//    var listOfQuestions = [Question]()
    
    @IBOutlet weak var table: UITableView!
    
    // let list = ["Milk", "Honey", "Bread", "Tacos", "Tomatoes"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("<---------- listOfQuestions.count = \(listOfQuestions.count)")
//        return listOfQuestions.count
        return self.stackManager.arrayOfQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
//        let cellQuestion = listOfQuestions[indexPath.row]
        let questionArray = self.stackManager.arrayOfQuestions
        let cellQuestion = questionArray[indexPath.row]
//        cell.textLabel?.text = cellQuestion.title
        cell.questionLabel.text = cellQuestion.title
        
        let dateOfQuestion = Date(timeIntervalSince1970: cellQuestion.last_activity_date!)
        
        let dateFormatter = DateFormatter()
        // dateFormatter.timeStyle = DateFormatter.Style.medium // Set time style
        // dateFormatter.dateStyle = DateFormatter.Style.medium // Set date style
//        dateFormatter.locale = Locale(identifier: "en_GB")
//        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMddYYYY, hh:mm")
        dateFormatter.dateFormat = "dd MMMM YYYY, HH:mm"
        
        let localDate = dateFormatter.string(from: dateOfQuestion as Date)
        
        cell.dateLabel.text = localDate
        
        print("<---------- listOfQuestions[indexPath.row] = \(indexPath.row)")
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        stackManager.delegate = self
        
        stackManager.loadQuestions()
        table.reloadData()
    }
    
    func dataTaskHasCompleted() {
        self.table.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
