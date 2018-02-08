//
//  TimeLineCell.swift
//  Mastodon API client
//
//  Created by Danil on 08.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit


class TimeLineCell: UITableViewCell {
    
    public var cellData:TimeLinePost? = nil
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textOfPostLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if let cellData = self.cellData {
            self.userNameLabel.text = "@" + cellData.account.userName
            self.nickNameLabel.text = cellData.account.nickName
            self.textOfPostLabel.text = cellData.textOfPost
            self.nickNameLabel.text = cellData.account.nickName
        }
    }

}
