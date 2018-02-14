//
//  TimeLineElement.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct Status: Codable {
    let account: Account
    let createdAt: Date?
    let postURL: String
    let textOfPost: String
    let reblogsCount: Int
    let attachments: [Attachments]?
    
    enum CodingKeys: String, CodingKey {
        case account = "account"
        case createdAt = "created_at"
        case postURL = "url"
        case textOfPost = "content"
        case reblogsCount = "reblogs_count"
        case attachments = "media_attachments"
    }
}

struct Account: Codable {
    let userName: String
    let nickName: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case nickName = "display_name"
        case avatarURL = "avatar"
    }
}


struct Attachments: Codable {
    let id: String
    let type: String
    let postImageURL: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case postImageURL = "url"
        case previewURL = "preview_url"
    }
}



