//
//  AnswersViewController.swift
//  StackApp
//
//  Created by John on 9/12/17.
//  Copyright © 2017 John. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController, StackManagerDelegate {
    
    var currentQuestion: Question?
    
    fileprivate var answers: [Answer]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let unwrappedQuestion = currentQuestion {
            // StackManagerClosures.loadAnswers(forQuestion: unwrappedQuestion,
                                             // pageIndex: 1,
                                             // pageSize: 100,
                                             // completionHandler: { response in
                                                // if let error = response.error {
                                                    // print("[\(self.description)] loadAnswers error : \(error)")
                                                // }
                                        // })
        }
    }
    
    
    //            StackManagerClosures.loadAnswers(forQuestion: unwrappedQuestion,
    //                                             pageIndex: 1,
    //                                             pageSize: 100,
    //                                             completionHandler: {response in
    //                                                if let error = response.error {
    //                                                    print("[\(self.description)] loadAnswers error : \(error)")
    //                                                }
    //            })
    
    func dataTaskHasCompleted() {
        
    }

}

extension AnswersViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answers?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuestionsTableViewCell
        
        let answer = answers![indexPath.row]
        
        return cell
    }
    
}
