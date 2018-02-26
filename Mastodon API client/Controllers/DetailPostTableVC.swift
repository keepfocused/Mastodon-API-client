//
//  DetailPostTableVC.swift
//  Mastodon API client
//
//  Created by Danil on 18.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit

class DetailPostTableVC: UITableViewController {
    
    public var selectedPost:Status? = nil
    public var avatarCacheId = ""
    public var postImageCacheId = ""
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.navigationController?.navigationBar.isHidden = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 411
        
        
        self.tableView.reloadData()
        
        
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let detailTimeLineIdentifier = "detailTimeLineCellIdentifier"
        
        var detailTimeLineCell = tableView.dequeueReusableCell(withIdentifier: detailTimeLineIdentifier, for: indexPath) as! TimeLineCell
        
        
        detailTimeLineCell.textOfPostLabel.text = self.selectedPost?.textOfPost
        detailTimeLineCell.nickNameLabel.text = self.selectedPost?.account.nickName
        detailTimeLineCell.userNameLabel.text = self.selectedPost?.account.userName
        
        let avatarImage = ImageCacheManager.sharedInstance.imageCache.image(withIdentifier: self.avatarCacheId)
        detailTimeLineCell.avatarImageView.image = avatarImage
        
        if (postImageCacheId != "") {
            let postImage = ImageCacheManager.sharedInstance.imageCache.image(withIdentifier: self.postImageCacheId)
            
            detailTimeLineCell.postImageView.image = postImage
        }
        
        
        
        
        
        
        return detailTimeLineCell
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    // MARK: - Private methods
    
    
    private func configureCell (cell: TimeLineCell, forPath:IndexPath) -> TimeLineCell {
        
        return cell
        
        
    }
    
    
}
