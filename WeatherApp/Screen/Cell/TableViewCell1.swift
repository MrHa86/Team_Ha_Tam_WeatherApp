//
//  TableViewCell1.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 07/08/2022.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        minTempLabel.alpha = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
