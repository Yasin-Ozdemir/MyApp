//
//  CELL.swift
//  MyApp
//
//  Created by Yasin Özdemir on 13.03.2023.
//

import UIKit

class CELL: UITableViewCell {

    
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
