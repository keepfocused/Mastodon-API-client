//
//  JSONResponseParser.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation

class JSONResponseParser {
    
    public func performTimeLineDataParse (inputData:Data?) -> [TimeLinePost] {
        
        var parsedTimeLinePosts = [TimeLinePost]()
        
        
        let decoder = JSONDecoder()
        
        let statuses = try? decoder.decode(TimeLinePost.self, from: inputData!)
        
        dump(statuses?.account)
        
        print(statuses)
        
        

        
        
        
        
        
        
        
        
        /*
        let json = try? JSONSerialization.jsonObject(with: inputData!) as? Array<Any>
        
        print(json!?.first)
        
        print("Array")
        print(json!?.first as? Array<Any>)
        
        print("Dictionary")
        let dict = json!?.first as? Dictionary<String,Any>
        print(dict)
        
        print("All keys")
        
        for key in (dict?.keys)! {
            print(key)
        }
        */
        
        
        
        
        
        /*
        for element in json
        {
            print(element as? Dictionary<String,Any>)
        }
        
        */
        
        
        
      return parsedTimeLinePosts
    }
}

