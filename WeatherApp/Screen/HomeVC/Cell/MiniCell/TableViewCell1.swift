//
//  TableViewCell1.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 07/08/2022.
//

import UIKit

class TableViewCell1: UITableViewCell {

    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        minTempLabel.alpha = 0.6
    }

    func bindData(item: DataWeekly) {
        iconImage.image = .init(named: DataManager.shared.checkIsDay ? item.weather!.icon! : item.weather!.icon!.prefix(3)+"n")
        maxTempLabel.text = "\(Int( item.maxTemp ?? 0))°"
        minTempLabel.text = "\(Int( item.minTemp ?? 0))°"
        dayLabel.text = getDayOfWeek(item.datetime!)
        humidityLabel.text = "\(item.rh ?? 0)%"
        // Set Color
        dayLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        maxTempLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        minTempLabel.textColor = .init(named: DataManager.shared.checkIsDay ? "Color1" : "Color2")
        
    }

    
}
extension UITableViewCell {
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        switch weekDay {
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return "Sunday"
        }
        
    }
}
