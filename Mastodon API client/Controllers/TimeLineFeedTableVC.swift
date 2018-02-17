//
//  TimeLineFeedTableVC.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit
import Alamofire



class TimeLineFeedTableVC: UITableViewController {
    
    private var statuses = [Status]()
    
    private var cachePostImages = [String: UIImage]()
    private var cacheAvatarImages = [String: UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.white
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        

        
        
        let networkManager = NetworkManager.sharedInstance
        
        networkManager.getTimeLineData() { data in
            
            let parser = JSONResponseParser()
            
            self.statuses = parser.performTimeLineDataParse(inputData: data)
            
            self.tableView.reloadData()
            
            
        }
       
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.statuses.count
    }
    
    private let timeLineCellIdentifier = "timeLineCellIdentifier"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let timeLineCell = tableView.dequeueReusableCell(withIdentifier: timeLineCellIdentifier, for: indexPath) as! TimeLineCell
        
        configureCell(cell: timeLineCell, forPath: indexPath)
        
        return timeLineCell
            
           // timeLineCell.cellData = self.statuses[indexPath.row]
            
           // let status = self.statuses[indexPath.row]
        
       // timeLineCell.textOfPostLabel.text = status.textOfPost
        
        
        
        
        
        
        
       // timeLineCell.avatarImageView.image = nil
        
        /*
            let avatarURL = status.account.avatarURL
            
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in
                
                DispatchQueue.main.async {
                    timeLineCell.avatarImageView.image = avatarImage
                }
            })
        */
        
        
timeLineCell.postImageView.image = nil
        
        /*
            if (self.statuses[indexPath.row].attachments?.count != 0) {
                
            
                
            //    let imageKey = String(indexPath.row)
                
            //    if (self.cachePostImages[imageKey] != nil) {
                    
            //        timeLineCell.postImageView.image = self.cachePostImages[imageKey]
                    
            //    } else {
                    let postImageURL = status.attachments!.first!.previewURL
                    NetworkManager.sharedInstance.getImageByURL(imageURL: postImageURL, completion: { (postImage) in
                        
                        DispatchQueue.main.async {
                            timeLineCell.postImageView.image = postImage
                            
                            //let imageKey = String(indexPath.row)
                            
                       //     self.cachePostImages[imageKey] = postImage
                        }
                    })
                    
                    
                    
              //  }
                
                

          //  } else {
               // timeLineCell.postImageView.image = nil
        }
    
                
            */
                
        
            
            

            timeLineCell.selectionStyle = .none
            
            
        

        
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Mark: Private methods
    
    func configureCell (cell: TimeLineCell, forPath:IndexPath) -> TimeLineCell {
        
        let cellData = self.statuses[forPath.row]
            //self.textOfPostLabel.adjustsFontSizeToFitWidth = true
            cell.userNameLabel.text = "@" + cellData.account.userName
            cell.nickNameLabel.text = cellData.account.nickName
        
        
        
        // Post text
        
            var postText = cellData.textOfPost
            
            // Format text, remove html tags
            
            postText = removeHtmlTags(inputText: postText)
            cell.textOfPostLabel.text = postText
            
            
            
            // Calculate date
            
            var differenceTime:(minutes:Int, seconds:Int)? = nil
            differenceTime = calculateDateSinceTime(inputDate: cellData.createdAt)
            
            
            if (differenceTime?.minutes != 0) {
                cell.dateLabel.text = String(describing: differenceTime!.minutes) + "m"
            } else {
                cell.dateLabel.text = String(describing: differenceTime!.seconds) + "s"
            }
        
        
        // Get post image
        
        cell.postImageView.image = nil
        
        if (cellData.attachments?.count != 0) {
            
            
            
            //    let imageKey = String(indexPath.row)
            
            //    if (self.cachePostImages[imageKey] != nil) {
            
            //        timeLineCell.postImageView.image = self.cachePostImages[imageKey]
            
            //    } else {
            let postImageURL = cellData.attachments!.first!.postImageURL
            NetworkManager.sharedInstance.getImageByURL(imageURL: postImageURL, completion: { (postImage) in
                
                DispatchQueue.main.async {
                    cell.postImageView.image = postImage
                    
                    //let imageKey = String(indexPath.row)
                    
                    //     self.cachePostImages[imageKey] = postImage
                }
            })
            
            
            
            //  }
            
            
            
            //  } else {
            // timeLineCell.postImageView.image = nil
        }
            
        
        
        return cell
        
    }
    
    
    
    
    
    

}









