//
//  StackManagerClosures.swift
//  StackApp
//
//  Created by John on 9/1/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class StackManagerClosures {
    
    private static let baseStackOverflowURLString = "https://api.stackexchange.com/2.2/"
    private static let maximumPageSize: UInt = 100
    
    class func loadQuestions(pageIndex: UInt,
                             pageSize: UInt,
                             completionHandler: @escaping ([Question]?, Error?) -> Void) {
        
        let maxPageSize = StackManagerClosures.maximumPageSize
        
        // The API has a 100 limit for the pagesize argument.
        let limitedPageSize = pageSize > maxPageSize ? maxPageSize : pageSize
        
        let questionsAPI = baseStackOverflowURLString + "questions?page=\(pageIndex)&pagesize=\(limitedPageSize)&order=desc&sort=creation&site=stackoverflow"
        let url = URL(string: questionsAPI)!
        
        Alamofire.request(url).validate().responseData { (dataResponse) in
            if let unwrappedData = dataResponse.result.value {
                do {
                    let jsonDecoder = JSONDecoder()
                    let questionsList = try jsonDecoder.decode(QuestionList.self, from: unwrappedData)
                    let questionsArray = questionsList.items
                    completionHandler(questionsArray, nil)
                }
                catch {
                    completionHandler(nil, error)
                }
            } else {
                completionHandler(nil, dataResponse.error)
            }
        }

    }
}
