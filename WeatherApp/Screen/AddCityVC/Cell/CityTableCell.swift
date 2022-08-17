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

    func bindData(item: Data) {
        cityLabel.text = item.cityName
        tempLabel.text = "\(item.temp ?? 0)°"
        iconImage.image = .init(named: item.weather!.icon!+"2")
        let a = item.weather!.icon!.suffix(1)
        wallPaperImage.image = .init(named: a == "d" ? "Day2" : "Night2")
    }
    
}
