//
//  SearchingTableViewCell.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/29/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class SearchingTableViewCell: UITableViewCell {

    @IBOutlet weak var stylistLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
