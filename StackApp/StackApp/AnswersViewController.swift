//
//  AnswersViewController.swift
//  StackApp
//
//  Created by John on 9/12/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    /// variables
    @IBOutlet weak var table: UITableView!
    
    var pageIndex: UInt = 1
    let pageSize: UInt = 100
    
    var currentQuestion: Question?
    
    fileprivate var answers = [Answer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.estimatedRowHeight = 40
        table.rowHeight = UITableViewAutomaticDimension
        
        requestAnswers(pageIndex: pageIndex, pageSize: pageSize)
    }
    
    /// requestAnswers()
    fileprivate func requestAnswers(pageIndex: UInt, pageSize: UInt) {
        StackManagerClosures.loadAnswers(forQuestion: currentQuestion!,
                                         pageIndex: pageIndex,
                                         pageSize: pageSize) { (answersOrNil, errorOrNil) in
                                            if let unwrappedAnswers = answersOrNil {
                                                self.answers.append(contentsOf: unwrappedAnswers)
                                                print("!!! Answers : \(unwrappedAnswers.count)")
                                                self.table.reloadData()
                                            }
        }
    }
    
}


extension AnswersViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AnswersTableViewCell
        let answer = answers[indexPath.row]
        cell.answerLabel.text = answer.body
        
        if (indexPath.row == answers.count - 1) {
            pageIndex += 1
            self.requestAnswers(pageIndex: pageIndex, pageSize: pageSize)
        }
        
        return cell
    }
    
}
