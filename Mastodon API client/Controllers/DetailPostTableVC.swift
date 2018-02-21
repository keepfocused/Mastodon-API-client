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


    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.navigationController?.navigationBar.isHidden = false
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        
        self.tableView.reloadData()
        

    }
    
 


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        
        
     
        
        return detailTimeLineCell
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    func configureCell (cell: TimeLineCell, forPath:IndexPath) -> TimeLineCell {
        
        /*
         let passedCell = selectedCell!
        
        print(passedCell.nickNameLabel.text)
        print(passedCell.userNameLabel.text)
        
        cell.userNameLabel.text = passedCell.userNameLabel.text
        
        */
        //cell = selectedCell
        
        /*
        
        if (selectedCell != nil) {
            
            
            cell.nickNameLabel.text = selectedCell!.nickNameLabel.text
            cell.userNameLabel.text = selectedCell!.userNameLabel.text
            cell.textOfPostLabel.text = selectedCell!.textOfPostLabel.text
            
            
        }
        */
        
       // cell.textOfPostLabel.text = " хуй пизда"
        
      

        
        return cell
        
        
    }


}
