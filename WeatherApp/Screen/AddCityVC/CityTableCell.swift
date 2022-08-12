//
//  CityTableCell.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 10/08/2022.
//

import UIKit

class CityTableCell: UITableViewCell {


 
    @IBOutlet weak var wallPaperImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
