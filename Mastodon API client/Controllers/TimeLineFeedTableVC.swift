//
//  TimeLineFeedTableVC.swift
//  Mastodon API client
//
//  Created by Danil on 07.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit
import AlamofireImage



class TimeLineFeedTableVC: UITableViewController {
    
    private var statuses = [Status]()
    
    private let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.white
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        

        
        if (NetworkManager.isConnectedToInternet()) {
            
            let networkManager = NetworkManager.sharedInstance
            
            networkManager.getTimeLineData() { data in
                
                let parser = JSONResponseParser()
                
                self.statuses = parser.performTimeLineDataParse(inputData: data)
                
                self.tableView.reloadData()
            }
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


        
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // Mark: Private methods
    
    func configureCell (cell: TimeLineCell, forPath:IndexPath) -> TimeLineCell {
        
        // Model for cell
        
        let cellData = self.statuses[forPath.row]
        
        // Set username & nickname
        
            cell.userNameLabel.text = "@" + cellData.account.userName
            cell.nickNameLabel.text = cellData.account.nickName
        
        
        
        // Set post text
        
            var postText = cellData.textOfPost
            
            // Format text, remove html tags
            
            postText = removeHtmlTags(inputText: postText)
            cell.textOfPostLabel.text = postText
            
        
        // Set & calculate date
        
            var differenceTime:(minutes:Int, seconds:Int)? = nil
            differenceTime = calculateDateSinceTime(inputDate: cellData.createdAt)
            
            
            if (differenceTime?.minutes != 0) {
                cell.dateLabel.text = String(describing: differenceTime!.minutes) + "m"
            } else {
                cell.dateLabel.text = String(describing: differenceTime!.seconds) + "s"
            }
        
        
     // Set avatar image
        
        let avatarCacheId = "avatar" + String(forPath.row)
        
        let cachedAvatar = imageCache.image(withIdentifier: avatarCacheId)
        
        if (cachedAvatar != nil) {
            
            cell.avatarImageView.image = cachedAvatar
            print("image set from cache")
        } else {
            
            let avatarURL = cellData.account.avatarURL
            
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in

                DispatchQueue.main.async {
                    
                    cell.avatarImageView.image = avatarImage
                }
                self.imageCache.add(avatarImage!, withIdentifier: avatarCacheId)
            })
        }
        

        
     // Get post image
        
        cell.postImageView.image = nil
        
        if (cellData.attachments?.count != 0) {
            
            let postImageCacheId = "postImage" + String(forPath.row)
            
            let cachedPostImage = imageCache.image(withIdentifier: postImageCacheId)
            
            if (cachedPostImage != nil) {
                
                cell.postImageView.image = cachedPostImage
            } else {
                
                let postImageURL = cellData.attachments!.first!.postImageURL
                NetworkManager.sharedInstance.getImageByURL(imageURL: postImageURL, completion: { (postImage) in
   
                    DispatchQueue.main.async {
                        
                        cell.postImageView.image = postImage
                        
                        self.reloadCell(forRow:forPath)
                        
                    }
                    self.imageCache.add(postImage!, withIdentifier: postImageCacheId)
                    
                    
                })
            }
        }
            
        cell.selectionStyle = .none
        
        return cell
    }
    
    func reloadCell (forRow: IndexPath) {
        
        self.tableView.reloadRows(at: [forRow], with: UITableViewRowAnimation.none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! TimeLineCell

        if let destinationViewController = segue.destination as? DetailPostTableVC {
           // destinationViewController.basicInfo = passAlbumBasicData
        }
    }
}














