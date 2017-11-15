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
    
    var arrayOfQuestions = [Question]()
    var delegate: StackManagerDelegate?
    
    let baseStackOverflowURLString = "https://api.stackexchange.com/2.2/"
    let filterID = "!b0OfNenVjyled*"
    
    private let maximumPageSize = 100
    
    // loadQuestions functionality
    func loadQuestions(pageIndex: Int, pageSize: Int) {

        // The API has a 100 limit for the pagesize argument.
        let limitedPageSize = pageSize > maximumPageSize ? maximumPageSize : pageSize
        
        let questionsAPI = baseStackOverflowURLString + "questions?page=\(pageIndex)&pagesize=\(limitedPageSize)&order=desc&sort=creation&site=stackoverflow"
        let url = URL(string: questionsAPI)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let sessionDataTask = session.dataTask(with: url!) { [weak self] data, response, error in
                if let content = data {
                    do {
                        let questionsDictionary = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, Any>
                        
                        if let unwrappedQuestionsDictionary = questionsDictionary {
                            if let questions = unwrappedQuestionsDictionary["items"] as? Array<Dictionary<String, Any>> {
                                for question in questions {
                                    let title = question["title"] as! String
                                    let lastActivityDate = question["last_activity_date"] as! Double
                                    let questionID = question["question_id"] as! UInt
                                    let creationDate = question["creation_date"] as! Double

                                    let ownerDict = question["owner"] as! Dictionary<String, Any>
                                    let userId = ownerDict["user_id"] as! Int
                                    let displayName = ownerDict["display_name"] as! String
                                    let userType = ownerDict["user_type"] as? String
                                    let reputation = ownerDict["reputation"] as? Int
                                    let profileImage = ownerDict["profile_image"] as? String
                                    let acceptRate = ownerDict["accept_rate"] as? Int

                                    let owner = Owner(display_name: displayName,
                                                      profile_image: profileImage,
                                                      user_id: userId,
                                                      user_type: userType,
                                                      reputation: reputation,
                                                      accept_rate: acceptRate)

                                    let currentQuestion = Question(title: title,
                                                                   question_id: questionID,
                                                                   creation_date: creationDate,
                                                                   last_activity_date: lastActivityDate,
                                                                   owner: owner)

                                    self?.arrayOfQuestions.append(currentQuestion)
                                }
                                
                                DispatchQueue.main.async {
                                    self?.delegate?.dataTaskHasCompleted()
                                }
                            }
                        }
                    }
                     
                    catch {}
                }
        }
        
        sessionDataTask.resume()
    }
    
    // loadAnswers functionality
    func loadAnswers(forQuestion question: Question) {
        
        let answersAPI = baseStackOverflowURLString + "questions/\(String(describing: question.question_id))/answers?page=1&pagesize=50&order=desc&sort=creation&site=stackoverflow&filter=\(self.filterID)"
        let url = URL(string: answersAPI)
        
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let sessionDataTask = session.dataTask(with: url!) { [weak self] data, response, error in
            if let content = data {
                do {
                    
                }
            }
        }
        
        sessionDataTask.resume()
    }
    
    
}
