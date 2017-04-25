//
//  CellVCTableViewCell.swift
//  RadioStreaming
//
//  Created by kin on 09.03.17.
//  Copyright © 2017 kin. All rights reserved.
//

import UIKit

class CellTB: UITableViewCell {

    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var button: UIButton!
  
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
