//
//  HistoryCell.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
