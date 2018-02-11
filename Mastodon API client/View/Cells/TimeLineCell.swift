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
    @IBOutlet weak var postImageView: UIImageView!
    
    public var cellNumber = Int()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if let cellData = self.cellData {
            self.userNameLabel.text = "@" + cellData.account.userName
            self.nickNameLabel.text = cellData.account.nickName
            self.nickNameLabel.text = cellData.account.nickName
            var postText = cellData.textOfPost
           postText = postText.replacingOccurrences(of: "<br />", with: "\n\n")
           postText =  postText.replacingOccurrences(of: "</p>", with: "\n\n")
            postText =  postText.replacingOccurrences(of: "<p>", with: "")
            postText =  postText.replacingOccurrences(of: "<br>", with: "\n")
            postText =  postText.replacingOccurrences(of: "<a", with: "\n\n")
            postText =  postText.replacingOccurrences(of: "a>", with: "\n\n")
            postText =  postText.replacingOccurrences(of: "href=", with: "\n\n")
           postText = postText.replacingOccurrences(of: "&lt", with: "<")
           postText = postText.replacingOccurrences(of: "&gt", with: ">")
           postText = postText.replacingOccurrences(of: "&apos", with: "\"")
           postText = postText.replacingOccurrences(of: "&quot", with: "'")
           postText = postText.replacingOccurrences(of: "&amp", with: "&")
            
            self.textOfPostLabel.text = postText

            var tempDate = cellData.createdAt
            
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: tempDate!)
           // print(tempDate)
          //  print(hour)
            
            self.dateLabel.text = String(hour) + " h"
   /*
            let avatarURL = cellData.account.avatarURL
            self.avatarImageView.image = nil
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in
                
                DispatchQueue.main.async {
                    self.avatarImageView.image = avatarImage
                }
            })
      */
            
            print("Cell controller \(cellNumber)")
            
      /*
            if (cellData.attachments?.count != 0) {
                
                let attachments = cellData.attachments!
                
                let postImageViewURL = attachments.first!.postImageURL
            
                self.postImageView.image = nil
                
            NetworkManager.sharedInstance.getImageByURL(imageURL: postImageViewURL, completion: { (postImage) in
                
                DispatchQueue.main.async {
                    self.postImageView.image = postImage
                }
            })
            }
            */
            


        }
    }

}
