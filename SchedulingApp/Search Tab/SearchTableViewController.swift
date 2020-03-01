//
//  SearchTableViewController.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/19/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        //search
    }
    
    @IBOutlet var findBusinessesTable: UITableView!
    var docRef : DocumentReference!
    
    
    var BusinessList = ["Business 1","Business 2","Business 3","Business 4","Business 5"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        

       // docRef = Firestore.firestore().document("Businesses")
        
        
        let background = UIImageView(image: UIImage(named: "barber-wallpaper-20"))
       
        background.alpha = 0.8
        background.contentMode = UIViewContentMode.scaleAspectFill
        
        self.tableView.backgroundView = background
        
        
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        //tableView.tableHeaderView = searchController.searchBar

        
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
        return BusinessList.count //this needs to be a count of the var list from the database
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> (UITableViewCell) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! SearchTableViewCell
        
        
        cell.businessName.text = BusinessList[indexPath.row]
        
        
        //cell.locationInfo.text = LocationList[indexPath.row]
        //cell.hrsOfOp.text = HoursList[indexPath.row]

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showDetail") {
            
            let dvc = segue.destination as! SearchViewController
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                dvc.sentData = BusinessList[indexPath.row] as String
        
        
    }
    

}
}

   
  
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
