//
//  TimeLineCell.swift
//  Mastodon API client
//
//  Created by Danil on 08.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit

class TimeLineCell: UITableViewCell {
    
    public var cellData:Status? = nil
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textOfPostLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


