//
//  Double+StackApp.swift
//  StackApp
//
//  Created by John on 9/11/17.
//  Copyright © 2017 John. All rights reserved.
//

import Foundation

extension Double {
    
    func unixFormattedTime() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy, HH:mm"
        
        return dateFormatter.string(from: date)
    }
}
