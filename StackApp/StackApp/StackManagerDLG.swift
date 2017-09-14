//
//  StackManagerDLG.swift
//  StackApp
//
//  Created by John on 8/24/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

protocol StackManagerDelegate {
    func dataTaskHasCompleted()
}

class StackManagerDLG {
    
    var delegate: StackManagerDelegate?
    
    var arrayOfQuestions = [Question]()
    
    func loadQuestions() {

        let stackoverflow = "https://api.stackexchange.com/2.2/questions?page=1&pagesize=50&order=desc&sort=creation&site=stackoverflow"
        let url = URL(string: stackoverflow)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let sessionDataTask = session.dataTask(with: url!) { [weak self] data, response, error in
                if let content = data {
                    do {
                        let questionsDictionary = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                        if let unwrappedQuestionsDictionary = questionsDictionary {
                            let questions: Array<Dictionary<String, Any>> = unwrappedQuestionsDictionary["items"] as! Array<Dictionary<String, Any>>

                            for question in questions {
                                var currentQuestion = Question()
                                currentQuestion.title = question["title"] as? String
                                currentQuestion.last_activity_date = question["last_activity_date"] as? Double
                                currentQuestion.question_id = question["question_id"] as? UInt
                                // print(currentQuestion)
                                
                                self?.arrayOfQuestions.append(currentQuestion)
                            }
                            
                            DispatchQueue.main.async {
                                self?.delegate?.dataTaskHasCompleted()
                            }

                        }
                    }
                     
                    catch {}
                }
        }
        
        sessionDataTask.resume()
    }
}
