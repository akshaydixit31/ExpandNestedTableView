//
//  CustomCellForCell.swift
//  ExpandNestedTableView
//
//  Created by Appinventiv Technologies on 07/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit

class CustomCellForCell: UITableViewCell {
//-------------- Outlet's -------------
    @IBOutlet weak var customCellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
