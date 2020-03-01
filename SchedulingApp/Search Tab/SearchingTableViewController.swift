//
//  SearchingTableViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/29/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class SearchingTableViewController: UITableViewController {
    
    var timeList = ["9:30-10:00","4:00-4:30","12:00-12:30"]
    
    var dateData: String!
    var stylistData: String!
    var stylistData2: String!
    var businessData: String!
    var dateData2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let background = UIImageView(image: UIImage(named: "barber-wallpaper-20"))
        
        background.alpha = 0.8
        background.contentMode = UIViewContentMode.scaleAspectFill

        self.tableView.backgroundView = background
        
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
        return timeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! SearchingTableViewCell
        
            // these aren't working maybe an if statement?
            // cell.dateLabel.text = dateData2
           // cell.stylistLabel.text = stylistData2
        
            cell.dateLabel.text = dateData
            cell.hourLabel.text = timeList[indexPath.row]
            cell.stylistLabel.text = stylistData
            
            // Configure the cell...
            
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

    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
