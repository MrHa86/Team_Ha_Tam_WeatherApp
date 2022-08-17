//
//  MiniCell.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 07/08/2022.
//

import UIKit

class MiniCell: UICollectionViewCell {

    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }

    func bindData(item: DataHourly) {
        hourLabel.text = localTimeToHour(time: item.timestampLocal!)
        iconImage.image = .init(named: item.weather!.icon!)
        tempLabel.text = "\(Int(item.temp ?? 0))°"
        humidityLabel.text = "\(item.rh ?? 0)%"
        
        // set gradient border và color theo Day Night
        setBorderColorToGradient(image: .init(named: DataManager.shared.checkIsDay ? "Day2" : "Night2")!)
        tempLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        hourLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
    }
}

extension MiniCell {
    func setBorderColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.borderView.borderColor = UIColor(patternImage: myGradient!)
    }
    
    func localTimeToHour(time: String) -> String {
        let a = time.suffix(8)
        let b = a.prefix(2)
        return String(b)
    }
}
