//
//  NetworkManager.swift
//  Mastodon API client
//
//  Created by Danil on 08.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class NetworkManager {
    
    //NetworkManager Singleton
    
    static let sharedInstance = NetworkManager()

    
    public func passDataForParse (completion: @escaping (Data?) -> Void)  {
        
        Alamofire.request("https://mastodon.technology/api/v1/timelines/public").responseJSON(){(data) in
            
            let json:Data? = data.data
            
            completion (json)
        }
    }
    
    public func getImageByURL (imageURL:String, completion: @escaping (UIImage?) -> Void) {
        
        Alamofire.request(imageURL).responseImage(){(data)
            in
            
            let image = data.result.value
            
            completion (image)
        }
    }
}

