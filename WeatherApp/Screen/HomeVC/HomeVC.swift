//
//  HomeVC2.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 06/08/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import Kingfisher

class HomeVC: BaseViewController {
    // Main collectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Param dùng để GET Data từ API
    var paramCurrent: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",
                                    "city": "Ho Chi Minh"]
    var paramHourly: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",
                                   "city": "Ho Chi Minh",
                                   "hours": 24]
    var paramWeekly: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",
                                   "city": "Ho Chi Minh",
                                   "days": 10]
    // Data source cho collectionView, tableView
    var currentData: [Data] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var arrHourly: [DataHourly] = []
    var arrWeekly: [DataWeekly] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData()
        configCollectionView()
    
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "Cell1", bundle: nil), forCellWithReuseIdentifier: "cell1")
        collectionView.register(UINib(nibName: "Cell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        collectionView.register(UINib(nibName: "Cell3", bundle: nil), forCellWithReuseIdentifier: "cell3")
    }
    
    // Request cả 3 loại data: current, hourly forecast và weekly forecasat xong reload lại CollectionView
    func getWeatherData() {
        // GET Current Data
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/current?") else {
            self.view.makeToast("Error: URL không tồn tại !!!")
            return
        }
        
        startAnimating()
        // Request Current Data
        Alamofire.request(url, method: .get, parameters: paramCurrent, headers: nil).responseJSON { response in
            guard let value = response.result.value else {
                self.view.makeToast("No current data response")
                self.stopAnimating()
                return
            }
            
            self.currentData = Current(JSON(value)).data!
            self.stopAnimating()
            print("Đã lấy được Current Data")
            
        }
        
        // Get Hourly Data
        startAnimating()
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/hourly?") else {
            self.stopAnimating()
            return
        }
        // Request Hourly Data
        Alamofire.request(url, method: .get, parameters: paramHourly).responseJSON { response in
            guard let value = response.result.value else {
                self.view.makeToast("No hourly data response!!!")
                self.stopAnimating()
                return
            }
            let hourlyData = HourlyForecast(JSON(value))
            self.arrHourly = hourlyData.data!
            self.stopAnimating()
            print("Đã lấy được Hourly Data")
            self.collectionView.reloadData()
           
        }
        
        // GET Weekly Data
        startAnimating()
        guard let url = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily?") else {
            self.stopAnimating()
            return
        }
        // Request Weekly Data
        Alamofire.request(url, method: .get, parameters: paramWeekly).responseJSON { response in
            guard let value = response.result.value else {
                self.view.makeToast("No weekly data response!!!")
                self.stopAnimating()
                return
            }
            let weeklyData = WeeklyForecastModel(JSON(value))
            self.arrWeekly = weeklyData.data!
            self.stopAnimating()
            print("Đã lấy được weekly data")
            self.collectionView.reloadData()
            
        }
     
    }//
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.bounds.width
        switch indexPath.row {
        case 0:
            return CGSize(width: w, height: w*4/6)
        case 1:
            return CGSize(width: w, height: w*2/5)
        default:
            return CGSize(width: w, height: 620)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell 1: Đổ dữ liệu Current data
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! Cell1
            
            if currentData.count > 0 , let cityName = currentData[0].cityName {
                cell.cityLabel.text = cityName
            }
            if currentData.count > 0 ,let description = currentData[0].weather?.description {
                cell.discriptionLabel.text = description
            }
            if currentData.count > 0 ,let temp = currentData[0].temp {
                cell.tempLabel.text = "\(temp)°"
            }
            if currentData.count > 0 ,let wind = currentData[0].windSpd {
                cell.windLabel.text = "\(wind) km/h"
            }
            if currentData.count > 0 ,let feelsLike = currentData[0].appTemp {
                cell.feelsLikeLabel.text = "\(Int(feelsLike))°"
            }
            if currentData.count > 0 ,let humidity = currentData[0].rh {
                cell.humidityLabel.text = "\(humidity)%"
            }
            if currentData.count > 0 { cell.iconImage.image = .init(named: currentData[0].weather!.icon!) }
            
            // action Button City
            cell.handleCity = {
                let vc = AddCityVC()
                self.present(vc, animated: true)
            }
            
            return cell
        }
        // Cell2: là collectionView xoay ngang,  Đổ dữ liệu Hourly data vào
        if indexPath.row == 1 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Cell2
            cell2.arrData = arrHourly
            
            return cell2
        }
        
        let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! Cell3
        cell3.arrData = arrWeekly
        return cell3
        
    }
    
    
    
}
