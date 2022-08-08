//
//  Cell3.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 06/08/2022.
//

import UIKit

class Cell3: UICollectionViewCell {

    @IBOutlet weak var tableView: UITableView!
    
    var arrData: [DataWeekly] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        configTBV()
    }

    func configTBV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        tableView.tableFooterView = UIView()
    }
}

extension Cell3: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tbvCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell1
        let item = arrData[indexPath.row]
        tbvCell.iconImage.image = .init(named: item.weather!.icon!)
        tbvCell.maxTempLabel.text = "\(Int( item.maxTemp ?? 0))°"
        tbvCell.minTempLabel.text = "\(Int( item.minTemp ?? 0))°"
        tbvCell.dayLabel.text = getDayOfWeek(item.datetime!)
        
        return tbvCell
    }
    
    
}


extension Cell3 {
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
