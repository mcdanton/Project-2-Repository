//
//  TableViewCell.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/1/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
   
   
   @IBOutlet weak var cellImage: UIImageView!
   @IBOutlet weak var cellLabel: UILabel!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
