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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        if let cellData = self.cellData {
            self.textOfPostLabel.adjustsFontSizeToFitWidth = true
            self.userNameLabel.text = "@" + cellData.account.userName
            self.nickNameLabel.text = cellData.account.nickName
            var postText = cellData.textOfPost
            
            //Format text, remove html tags
            
            postText = removeHtmlTags(inputText: postText)
            
            self.textOfPostLabel.text = postText
            
            //Calculate date
            
            var differenceTime:(minutes:Int, seconds:Int)? = nil
            differenceTime = calculateDateSinceTime(inputDate: cellData.createdAt)
            
            
            if (differenceTime?.minutes != 0) {
                self.dateLabel.text = String(describing: differenceTime!.minutes) + "m"
            } else {
                self.dateLabel.text = String(describing: differenceTime!.seconds) + "s"
            }
            
        }
    }
    
}


