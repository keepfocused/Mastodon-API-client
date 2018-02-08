//
//  JSONResponseParser.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation

extension Formatter {
    static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    static let iso8601noFS = ISO8601DateFormatter()
}

extension JSONDecoder.DateDecodingStrategy {
    static let customISO8601 = custom { decoder throws -> Date in
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        if let date = Formatter.iso8601.date(from: string) ?? Formatter.iso8601noFS.date(from: string) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: \(string)")
    }
}

class JSONResponseParser {
    
    public func performTimeLineDataParse (inputData:Data?) -> [TimeLinePost] {
        
        var parsedTimeLinePosts = [TimeLinePost]()
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .customISO8601
            let statuses = try! decoder.decode([TimeLinePost].self, from: inputData!)
            
            parsedTimeLinePosts = statuses
        }
        catch {
            print("timeLine parse failed: \(error)")
        }
        
        return parsedTimeLinePosts
    }
}

