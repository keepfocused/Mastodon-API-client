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
        
        print("view did load started")
        
        /*
        Alamofire.request("https://mastodon.technology/api/v1/timelines/public").responseJSON(){(data) in
            
            let json:Data? = data.data
            
            let parser = JSONResponseParser()
            
            self.timeLineElements = parser.performTimeLineDataParse(inputData: json)
            
            self.tableView.reloadData()
            
            print("view did load finished")
        }
 */
        
        
        passDataForParse() { data in
            
            let parser = JSONResponseParser()
            
            self.timeLineElements = parser.performTimeLineDataParse(inputData: data)
            
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.timeLineElements.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    private let timeLineCellIdentifier = "timeLineCellIdentifier"
    private let timeLinePostImageCellIdentifier = "timeLinePostImageCell"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let celll = tableView.dequeueReusableCell(withIdentifier: timeLineCellIdentifier, for: indexPath) as! TimeLineCell
            
            celll.cellData = self.timeLineElements[indexPath.section]
            
            return celll
            
        }
        
        if (indexPath.row == 1) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: timeLinePostImageCellIdentifier, for: indexPath) as! TimeLinePostImageCell
            
            
            return cell
            
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"reuseIdentifier", for: indexPath)
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row == 0) {
            return 336
        }
        if (indexPath.row == 1) {
            
            if (self.timeLineElements[indexPath.section].attachments?.count != 0) {
                return 336
            }
        }
        return 40
    }
    
    
    func passDataForParse (completion: @escaping (Data?) -> Void)  {
        
        Alamofire.request("https://mastodon.technology/api/v1/timelines/public").responseJSON(){(data) in
            
            let json:Data? = data.data
            
            
            completion (json)
    }

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

