//
//  Cell1.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 06/08/2022.
//

import UIKit

class Cell1: UICollectionViewCell {
    
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var wind1Label: UILabel!
    @IBOutlet weak var feelsLike1Label: UILabel!
    @IBOutlet weak var humidity1Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    func bindData(item: Data) {
        cityLabel.text = item.cityName
        discriptionLabel.text = item.weather?.description
        tempLabel.text = "\(item.temp ?? 0)°"
        windLabel.text = "\(round1(a: item.windSpd ?? 0.0)) km/h"
        feelsLikeLabel.text = "\(Int(item.appTemp ?? 0))°"
        humidityLabel.text = "\(item.rh ?? 0)%"
        iconImage.image = .init(named: item.weather!.icon!)
        // Chọn màu chữ theo day/night
        tempLabel.setTextColorToGradient(image: .init(named: DataManager.shared.checkIsDay ? "Day2" : "Night2")!)
        cityLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        discriptionLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        windLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        feelsLikeLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        humidityLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        wind1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        feelsLike1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        humidity1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
    }
}

extension UICollectionViewCell {
    func round1(a:Double)->Double {                          // func lấy bao nhiêu số sau dấu , của Float
        let mu = pow(10.0,1.0)                // chỉnh số 2.0 thành 3.0, 4.0….
        let r=round(a*mu)/mu
        return r
    }
}
