//
//  QuestionViewController.swift
//  StackApp
//
//  Created by John on 8/22/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StackManagerDelegate {
    
    let stackManager = StackManagerDLG()
    @IBOutlet weak var table: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stackManager.arrayOfQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let questionArray = self.stackManager.arrayOfQuestions
        let cellQuestion = questionArray[indexPath.row]
        cell.questionLabel.text = cellQuestion.title
        
        let dateOfQuestion = Date(timeIntervalSince1970: cellQuestion.last_activity_date!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY, HH:mm"
        let localDate = dateFormatter.string(from: dateOfQuestion as Date)
        cell.dateLabel.text = localDate
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
}
