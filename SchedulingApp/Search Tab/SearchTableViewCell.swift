//
//  SearchTableViewCell.swift
//  SchedulingApp
//
//  Created by Seth Roller on 1/19/18.
//  Copyright © 2018 Seth Roller. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var businessName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
