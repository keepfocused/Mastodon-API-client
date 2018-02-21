//
//  ImageCacheManager.swift
//  Mastodon API client
//
//  Created by Danil on 21.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation
import AlamofireImage

class ImageCacheManager {
    
    static let sharedInstance = ImageCacheManager()
    
    public let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    
}






