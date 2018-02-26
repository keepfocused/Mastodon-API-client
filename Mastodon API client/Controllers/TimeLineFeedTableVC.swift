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
    
    let cacheManager = ImageCacheManager.sharedInstance
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        } else {
            
            let storyboard = UIStoryboard(name:"Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "noInternetPopUp") as! PopUpNoConnectionVC
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: Private methods
    
    private func configureCell (cell: TimeLineCell, forPath:IndexPath) {//-> TimeLineCell {
        
        cell.selectionStyle = .none
        
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
        
        let cachedAvatar = cacheManager.imageCache.image(withIdentifier: avatarCacheId)
        
        if (cachedAvatar != nil) {
            
            cell.avatarImageView.image = cachedAvatar
        } else {
            
            let avatarURL = cellData.account.avatarURL
            
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in
                
                DispatchQueue.main.async {
                    
                    cell.avatarImageView.image = avatarImage
                    self.cacheManager.imageCache.add(avatarImage!, withIdentifier: avatarCacheId)
                }
            })
        }

        // Set post image
        
        cell.postImageView.image = nil
        
        if (cellData.attachments?.count != 0) {
            
            let postImageCacheId = "postImage" + String(forPath.row)
            
            let cachedPostImage = cacheManager.imageCache.image(withIdentifier: postImageCacheId)
            
            if (cachedPostImage != nil) {
                
                cell.postImageView.image = cachedPostImage
            } else {
                
                let postImageURL = cellData.attachments!.first!.postImageURL
                NetworkManager.sharedInstance.getImageByURL(imageURL: postImageURL, completion: { (postImage) in
                    
                    if postImage != nil {
                        
                        DispatchQueue.main.async {
                            
                            cell.postImageView.image = postImage
                            self.cacheManager.imageCache.add(postImage!, withIdentifier: postImageCacheId)
                            self.reloadCell(forRow:forPath)
                        }
                    }
                })
            }
        }
    }
    
    private func reloadCell (forRow: IndexPath) {
        self.tableView.reloadRows(at: [forRow], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! TimeLineCell
        
        let indexPath = self.tableView!.indexPath(for: cell)
        let selectedCellNumber = indexPath?.row
        let passedTimeLineStatus = self.statuses[selectedCellNumber!]
        
        
        if let destinationViewController = segue.destination as? DetailPostTableVC {
            
            destinationViewController.selectedPost = passedTimeLineStatus
            let avatarCacheId = "avatar" + String(selectedCellNumber!)
            destinationViewController.avatarCacheId = avatarCacheId
            
            if (cell.postImageView.image != nil) {
                
                let postImageCacheId = "postImage" + String(selectedCellNumber!)
                destinationViewController.postImageCacheId = postImageCacheId
            }
        }
    }
}














