//
//  Double+StackApp.swift
//  StackApp
//
//  Created by John on 9/11/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

enum SADateFormat {
    case longDate
    case shortDate
    
    func dateFormat() -> String {
        switch self {
            case .longDate:
                return "dd MMMM yyyy, HH:mm"
            case .shortDate:
                return "dd MM yyyy"
        }
    }
    
}

extension Double {

    func unixFormattedTime(format: SADateFormat) -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.dateFormat()
        
        return dateFormatter.string(from: date)
    }
    
}
