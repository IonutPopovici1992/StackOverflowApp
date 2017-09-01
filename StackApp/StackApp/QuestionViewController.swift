//
//  QuestionViewController.swift
//  StackApp
//
//  Created by John on 8/22/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StackManagerDelegate {

    @IBOutlet weak var table: UITableView!
    
    let stackManager = StackManagerDLG()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stackManager.arrayOfQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let question = self.stackManager.arrayOfQuestions[indexPath.row]
        cell.questionLabel.text = question.title
        
        if let unixTime = question.last_activity_date {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM yyyy, HH:mm"
            
            cell.dateLabel.text = dateFormatter.string(from: date)
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.delegate = self
        self.table.dataSource = self
        
        self.stackManager.delegate = self
        self.stackManager.loadQuestions()
    }
    
    func dataTaskHasCompleted() {
        table.reloadData()
    }
}
