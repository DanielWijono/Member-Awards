//
//  AwardsTableViewCell.swift
//  MemberAwards
//
//  Created by Jac'ks Labs on 02/10/19.
//  Copyright © 2019 testing. All rights reserved.
//

import UIKit

class AwardsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var awardsTypeLabel: UILabel!
    @IBOutlet weak var awardsPointLabel: UILabel!
    @IBOutlet weak var awardsNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
