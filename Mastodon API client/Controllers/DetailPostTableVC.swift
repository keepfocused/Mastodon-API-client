//
//  DetailPostTableVC.swift
//  Mastodon API client
//
//  Created by Danil on 18.02.2018.
//  Copyright © 2018 @Danil. All rights reserved.
//

import UIKit

class DetailPostTableVC: UITableViewController {
    
    public var selectedCell:TimeLineCell? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("entered in view did load")
        
        if (selectedCell != nil) {
            
            print("selected cell exist")
        } else {
            
            print("selected cell not set")
        }
        
        self.navigationController?.navigationBar.isHidden = false
        
        
      //  self.tableView.reloadData()
        

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
        
        let detailTimeLineCell = tableView.dequeueReusableCell(withIdentifier: detailTimeLineIdentifier, for: indexPath) as! TimeLineCell
        
        //detailTimeLineCell = selectedCell
        
      // configureCell(cell: detailTimeLineCell, forPath: indexPath)
        
         detailTimeLineCell.nickNameLabel.text = " pizda"
        
        return detailTimeLineCell
    }
    
    
    func configureCell (cell: TimeLineCell, forPath:IndexPath) -> TimeLineCell {
        
        /*
         let passedCell = selectedCell!
        
        print(passedCell.nickNameLabel.text)
        print(passedCell.userNameLabel.text)
        
        cell.userNameLabel.text = passedCell.userNameLabel.text
        
        */
        
        if (selectedCell != nil) {
            
            
            cell.nickNameLabel.text = selectedCell!.nickNameLabel.text
            cell.userNameLabel.text = selectedCell!.userNameLabel.text
            cell.textOfPostLabel.text = selectedCell!.textOfPostLabel.text
            
            
        }
        
        
        cell.textOfPostLabel.text = " хуй пизда"
        
      

        
        return cell
        
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
