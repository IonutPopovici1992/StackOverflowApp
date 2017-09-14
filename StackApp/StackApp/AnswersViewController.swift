//
//  AnswersViewController.swift
//  StackApp
//
//  Created by John on 9/12/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController, StackManagerDelegate {
    
    let stackManager = StackManagerDLG()

    var currentQuestion: Question?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let unwrappedQuestion = currentQuestion {
            self.stackManager.loadAnswers(forQuestion: unwrappedQuestion)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dataTaskHasCompleted() {
        
    }

}

extension AnswersViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stackManager.arrayOfQuestions.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        
        let question = self.stackManager.arrayOfQuestions[indexPath.row]
        cell.questionLabel.text = question.title
        
        return cell
    }
}
