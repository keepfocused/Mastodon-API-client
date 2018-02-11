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
    
    private var timeLineElements = [TimeLinePost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        

        let networkManager = NetworkManager()
        
        networkManager.passDataForParse() { data in
            
            let parser = JSONResponseParser()
            
            self.timeLineElements = parser.performTimeLineDataParse(inputData: data)
            
            self.tableView.reloadData()
            
        }
        
       // networkManager.pass
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  self.timeLineElements.count
        
   
      
    }

    private let timeLineCellIdentifier = "timeLineCellIdentifier"
   // private let timeLinePostImageCellIdentifier = "timeLinePostImageCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0) {
            let celll = tableView.dequeueReusableCell(withIdentifier: timeLineCellIdentifier, for: indexPath) as! TimeLineCell
            
            celll.cellData = self.timeLineElements[indexPath.row]
            
            
            
            
            let data = self.timeLineElements[indexPath.row]
            
            
            
            let avatarURL = data.account.avatarURL
            celll.avatarImageView.image = nil
            celll.cellNumber = indexPath.row
            print("cell for row method indexpath = \(indexPath.row)")
            
            NetworkManager.sharedInstance.getImageByURL(imageURL: avatarURL, completion: { (avatarImage) in
                
                DispatchQueue.main.async {
                    celll.avatarImageView.image = avatarImage
                }
            })

            
            
            
            
            
            return celll
            
        }
        

        
        let cell = tableView.dequeueReusableCell(withIdentifier:"reuseIdentifier", for: indexPath)
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            cell.alpha = 1.0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if (self.timeLineElements[indexPath.row].attachments?.count != 0) {
            return 165 + 165
        } else {
            return 165
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}
 







    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

