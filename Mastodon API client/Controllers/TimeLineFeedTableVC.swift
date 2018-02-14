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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor.white
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 400
        

        
        
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
            
            timeLineCell.cellData = self.statuses[indexPath.row]
            
            let status = self.statuses[indexPath.row]
        
        
        timeLineCell.avatarImageView.image = nil
            let avatarURL = status.account.avatarURL
            
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in
                
                DispatchQueue.main.async {
                    timeLineCell.avatarImageView.image = avatarImage
                }
            })
            timeLineCell.postImageView.image = nil
timeLineCell.postImageView.isHidden = true
        
        
            if (self.statuses[indexPath.row].attachments?.count != 0) {
                
                timeLineCell.postImageView.isHidden = false
                
                
                let postImageURL = status.attachments!.first!.postImageURL
                NetworkManager.sharedInstance.getImageByURL(imageURL: postImageURL, completion: { (postImage) in
                    
                    DispatchQueue.main.async {
                        timeLineCell.postImageView.image = postImage
                    }
                })
        }
                
                
                
        
            
            

            timeLineCell.selectionStyle = .none
            
            
            return timeLineCell

        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1.0
        }
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
}









