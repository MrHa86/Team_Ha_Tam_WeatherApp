//
//  Cell4.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 10/08/2022.
//

import UIKit

class Cell4: UICollectionViewCell {

    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var airQualityLabel: UILabel!
    @IBOutlet weak var sunRise1Label: UILabel!
    @IBOutlet weak var sunSet1Label: UILabel!
    @IBOutlet weak var uv1Label: UILabel!
    @IBOutlet weak var precip1Label: UILabel!
    
    @IBOutlet weak var airQuality1Label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindData(item: Data) {
        airQualityLabel.text = "\(item.aqi ?? 0)"
        sunRiseLabel.text = item.sunrise ?? "00:00"
        sunSetLabel.text = item.sunset ?? "00:00"
        uvLabel.text = "\(item.uv ?? 0)"
        precipLabel.text = "\(Int(item.precip ?? 0)) mm"
        
        // Set Color
        airQualityLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        sunRiseLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        sunSetLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        uvLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        precipLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        airQuality1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        sunSet1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        sunRise1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        uv1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        precip1Label.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
    }

}
