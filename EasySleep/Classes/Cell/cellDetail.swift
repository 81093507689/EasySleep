//
//  cellDetail.swift
//  EasySleep
//
//  Created by developer on 31/03/19.
//  Copyright © 2019 EasySleep. All rights reserved.
//

import UIKit

class cellDetail: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
