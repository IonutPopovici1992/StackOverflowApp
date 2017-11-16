//
//  QuestionTableViewController.swift
//  StackApp
//
//  Created by John on 11/16/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class QuestionTableViewController: UIViewController {
    
    var questions = [Question]()
    var tappedQuestion: Question?
    var tableRefreshControl = UIRefreshControl()
    
    @IBOutlet weak var table: UITableView!
    
    var pageIndex: UInt = 0
    let pageSize: UInt = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTable()
        requestNextQuestions(resetPrevious: false)
        
        setupRefreshControlForTable()
    }
    
    /// configTable()
    fileprivate func configTable() {
        self.table.delegate = self
        self.table.dataSource = self
    }
    
    /// requestNextQuestions()
    fileprivate func requestNextQuestions(resetPrevious: Bool) {
        pageIndex += 1
        StackManagerClosures.loadQuestions(pageIndex: pageIndex,
                                           pageSize: pageSize) { (questionsOrNil, errorOrNil) in
                                            self.handleQuestionsResponse(questionsOrNil: questionsOrNil,
                                                                         errorOrNil: errorOrNil,
                                                                         reset: resetPrevious)
        }
    }
    
    /// handleQuestionsResponse()
    fileprivate func handleQuestionsResponse(questionsOrNil: [Question]?, errorOrNil: Error?, reset: Bool) {
        if let unwrappedQuestions = questionsOrNil {
            if reset == true {
                questions.removeAll()
            }
            
            self.questions.append(contentsOf: unwrappedQuestions)
            self.table.reloadData()
        } else {
            self.showAlert(error: errorOrNil)
        }
        
        self.tableRefreshControl.endRefreshing()
    }
    
    /// showAlert()
    fileprivate func showAlert(error: Error?) {
        let title = "Oupsss!"
        let message = "There was an issue while trying to obtain the latest questions: \(error.debugDescription)"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (alertAction) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// setupRefreshControlForTable()
    func setupRefreshControlForTable() {
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableRefreshControl.addTarget(self,
                                      action: #selector(refreshQuestions),
                                      for: UIControlEvents.valueChanged)
        table.addSubview(tableRefreshControl)
    }
    
    /// refreshQuestions()
    @objc fileprivate func refreshQuestions() {
        pageIndex = 0
        requestNextQuestions(resetPrevious: true)
    }
    
    /// prepare()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let answersViewController = segue.destination as? AnswersViewController {
            answersViewController.currentQuestion = self.tappedQuestion
        }
    }

}


extension QuestionTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of rows
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    // Populate row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        
        let question = questions[indexPath.row]
        cell.questionLabel.text = question.title
        cell.dateLabel.text = question.last_activity_date.unixFormattedTime(format: SADateFormat.shortDate)
        
        if (indexPath.row == questions.count - 1) {
            self.requestNextQuestions(resetPrevious: false)
        }
        
        return cell
    }
}
