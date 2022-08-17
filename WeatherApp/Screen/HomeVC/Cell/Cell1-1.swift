//
//  Cell1-1.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 13/08/2022.
//

import UIKit

class Cell1_1: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var humidity1Label: UILabel!
    @IBOutlet weak var feelLikeLabel: UILabel!
    @IBOutlet weak var feelsLike1Label: UILabel!
    @IBOutlet weak var wind1Label: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var descriptionLAbel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tempLabel.setTextColorToGradient(image: .init(named: DataManager.shared.checkIsDay ? "Day2" : "Night2")!)
    }

    func bindData(item: Data) {
        cityLabel.text = item.cityName
        descriptionLAbel.text = item.weather?.description
        tempLabel.text = "\(item.temp ?? 0)°"
        windLabel.text = "\(round1(a: item.windSpd ?? 0.0)) km/h"
        feelLikeLabel.text = "\(Int(item.appTemp ?? 0))°"
        humidityLabel.text = "\(item.rh ?? 0)%"
        iconImage.image = .init(named: item.weather!.icon!)
        // Chọn màu chữ theo day/night
        tempLabel.setTextColorToGradient(image: .init(named: DataManager.shared.checkIsDay ? "Day2" : "Night2")!)
        cityLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        descriptionLAbel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        windLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        feelLikeLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        humidityLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        wind1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        feelsLike1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        humidity1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
    }
}
