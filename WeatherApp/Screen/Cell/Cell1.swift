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
    
    var handleCity : (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func actionChooseCity(_ sender: UIButton) {
        handleCity?()
        
    }
}
