//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by Clive Liu on 10/5/20.
//

import Foundation


extension Date {
    
    func convertToMonthDayYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
