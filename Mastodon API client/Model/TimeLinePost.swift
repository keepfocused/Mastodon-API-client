//
//  TimeLineElement.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import Foundation

//  Приходит в реквесте массив статусов

//struct Statuses: Codable {
//    let statuses: [TimeLinePost]
//}


struct TimeLinePost: Codable {
    let account: Account
    let createdAt: Date // Date fix
    let postURL: Bool // enum accord
    let textOfPost: String //enum accord
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

//media_attachments
struct Attachments: Codable {
    let id: String
    let type: String //One of: "image", "video", "gifv", "unknown"
    let url: String
    let previewURL: String
    let meta: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case url
        case previewURL = "preview_url"
        case meta
    }
}

