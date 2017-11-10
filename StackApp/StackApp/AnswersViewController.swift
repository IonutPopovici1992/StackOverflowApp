//
//  AnswersViewController.swift
//  StackApp
//
//  Created by John on 9/12/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    var pageIndex: UInt = 1
    let pageSize: UInt = 100
    
    var currentQuestion: Question?
    
    fileprivate var answers = [Answer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAnswers(pageIndex: pageIndex, pageSize: pageSize)
    }
    
    fileprivate func requestAnswers(pageIndex: UInt, pageSize: UInt) {
        StackManagerClosures.loadAnswers(forQuestion: currentQuestion!,
                                         pageIndex: pageIndex,
                                         pageSize: pageSize) { (answersOrNil, errorOrNil) in
                                            if let unwrappedAnswers = answersOrNil {
                                                self.answers.append(contentsOf: unwrappedAnswers)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        let answer = answers[indexPath.row]
        cell.questionLabel.text = answer.body
        
        return cell
    }
    
}
