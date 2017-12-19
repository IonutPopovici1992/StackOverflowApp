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
        
        table.tableHeaderView = UIView(frame: .zero)
        
        requestAnswers(pageIndex: pageIndex, pageSize: pageSize)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sizeHeaderToFit()
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
    
    /// sizeHeaderToFit()
    fileprivate func sizeHeaderToFit() {
        let headerView = table.tableHeaderView!
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        
        table.tableHeaderView = headerView
    }
    
}


extension AnswersViewController: UITableViewDataSource, UITableViewDelegate {
    
    // numberOfRowsInSection
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.answers[section].comments?.count)!
    }
    
    // titleForHeaderInSection
    // func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {}
    
    // numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.answers.count
    }
    
    // cellForRowAt
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
