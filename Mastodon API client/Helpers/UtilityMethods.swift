//
//  Functions.swift
//  Mastodon API client
//
//  Created by Danil on 12.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation

 func removeHtmlTags (inputText: String) -> String {
    
    var resultString = inputText
    
    resultString = inputText.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    
    return resultString
}

func calculateDateSinceTime (inputDate: Date?) -> (Int, Int) {
    
    let calendar = Calendar.current
    
    // Current date
    let date = Date()
    let currentSeconds = calendar.component(.second, from: date)
    let currentMinutes = calendar.component(.minute, from: date)

    // Post date
    let postSeconds = calendar.component(.second, from: inputDate!)
    let postMinutes = calendar.component(.minute, from: inputDate!)

    // Difference between time
    let diffInMinutes = Calendar.current.dateComponents([.minute], from: inputDate!, to: date).minute
    let diffInSeconds = Calendar.current.dateComponents([.second], from: inputDate!, to: date).second
    
    return (diffInMinutes!, diffInSeconds!)
    
    
}
