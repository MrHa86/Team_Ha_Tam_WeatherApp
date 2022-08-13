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
        setBorderColorToGradient(image: .init(named: "Day")!)
    }
    func setBorderColorToGradient(image: UIImage) {
        UIGraphicsBeginImageContext(frame.size)
        image.draw(in: bounds)
        let myGradient = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.borderView.borderColor = UIColor(patternImage: myGradient!)
    }
}
