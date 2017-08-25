//
//  StackManager.swift
//  StackApp
//
//  Created by John on 8/24/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

class StackManager {
    
    func loadQuestions() {

        let stackoverflow = "https://api.stackexchange.com/2.2/questions?page=1&pagesize=50&order=desc&sort=creation&site=stackoverflow"
        let url = URL(string: stackoverflow)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let sessionDataTask = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print("You've got an error: \(error!)")
            } else {
                if let content = data {
                    do {
                        let questionsDictionary = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                        if let unwrappedQuestionsDictionary = questionsDictionary {
                            let questions: Array<Dictionary<String, Any>> = unwrappedQuestionsDictionary["items"] as! Array<Dictionary<String, Any>>
                            print("**********")
                            print(questions)
                            
                            for question in questions {
                                var currentQuestion = Question()
                                currentQuestion.title = unwrappedQuestionsDictionary["title"] as? String
                                currentQuestion.last_activity_date = unwrappedQuestionsDictionary["last_activity_date"] as? Double
                                currentQuestion.question_id = unwrappedQuestionsDictionary["question_id"] as? Double
                                print(currentQuestion.title)
                            }
                        }
                        
                        print(questionsDictionary)
                    }
                    catch {}
                    print(content)
                }
                print("**********")
            }
        }
        
        sessionDataTask.resume()
    }
}

struct Question {
    var title: String?
    var last_activity_date: Double?
    var question_id: Double?
}
