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
//import ObjectMapper

class StackManagerClosures {
    
    private static let baseStackOverflowURLString = "https://api.stackexchange.com/2.2/"
    private static let filterID = "!b0OfNenVjyled*"
    private static let maximumPageSize = 100
    
    class func loadAnswers(forQuestion: Question,
                           pageIndex: Int,
                           pageSize: Int,
                           completionHandler: @escaping (DataResponse<[Answer]>) -> Void) {
        
        let filter = StackManagerClosures.filterID
        let baseURLString = StackManagerClosures.baseStackOverflowURLString
        let maxPageSize = StackManagerClosures.maximumPageSize
        
        // The API has a 100 limit for the pagesize argument.
        let limitedPageSize = pageSize > maxPageSize ? maxPageSize : pageSize
        
        let answersAPI = baseURLString + "answers/\(String(describing: forQuestion.question_id))?page=\(pageIndex)&pagesize=\(limitedPageSize)&order=desc&sort=activity&site=stackoverflow&filter=\(filter)"
        let url = URL(string:answersAPI)!
        
        let dataRequest = Alamofire.request(url,
                                            method: HTTPMethod.get,
                                            parameters: nil,
                                            encoding: JSONEncoding.default,
                                            headers: nil)
        dataRequest.responseArray { (response: DataResponse<[Answer]>) in
            completionHandler(response)
        }
    }
}
