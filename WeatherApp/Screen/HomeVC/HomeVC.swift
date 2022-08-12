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
                                    "city": ""]
    var paramHourly: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",
                                   "city": "",
                                   "hours": 24]
    var paramWeekly: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",
                                   "city": "",
                                   "days": 10]
    // Biến để hứng City do người dùng chọn bên AddCityVC, hứng xong lưu vào UserDefault
    var localParamCity: String = "" {
        didSet {
            print(" UserDefault city là : \(localParamCity)")
            UserDefaults.standard.setValue(localParamCity, forKey: KEY_SAVE_CITY)
            
        }
    }
    var KEY_SAVE_CITY = "city"
    
    
    // Data source cho collectionView, tableView
    var currentData: [Data] = [] {
        didSet {
            if currentData.count > 0 {
                collectionView.reloadData()
            }
        }
    }
    var arrHourly: [DataHourly] = []
    var arrWeekly: [DataWeekly] = []
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherData()
        configCollectionView()
        
        // Nhận Notification city vừa chọn
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectCity(_:)), name: NSNotification.Name("did.select.city"), object: nil)
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Lấy dữ liệu sẵn chuẩn bị trước cho AddCityVC
        DataManager.shared.getCurrentDataForAddCityVC()
    }
   
    
    // Xử lý khi nhận Notification
    @objc func didSelectCity(_ notification: Notification) {
        print(notification.userInfo!["userInfo"] as Any)
        let city = notification.userInfo!["userInfo"]
        let strCity = stringFromAny(city)
        if self.localParamCity == strCity {
            print("Vừa chọn city hiện tại, không cần Get data ")
        } else {
            self.localParamCity = strCity
            self.getWeatherData()       // nếu đã lấy dl trước thì bỏ
        }
    }
    
    func configCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "Cell1", bundle: nil), forCellWithReuseIdentifier: "cell1")
        collectionView.register(UINib(nibName: "Cell2", bundle: nil), forCellWithReuseIdentifier: "cell2")
        collectionView.register(UINib(nibName: "Cell3", bundle: nil), forCellWithReuseIdentifier: "cell3")
        collectionView.register(UINib(nibName: "Cell4", bundle: nil), forCellWithReuseIdentifier: "cell4")
    }
    
    // Request cả 3 loại data: current, hourly forecast và weekly forecasat xong reload lại CollectionView
    func getWeatherData() {
        // Lấy city lưu trong UserDefault, nếu chưa có thì lấy "Ha Noi"
        localParamCity = UserDefaults.standard.string(forKey: KEY_SAVE_CITY) ?? "Ha Noi"
        paramCurrent["city"] = localParamCity
        paramHourly["city"] = localParamCity
        paramWeekly["city"] = localParamCity
        
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
            print("Đã lấy được Current Data của \(self.paramCurrent["city"]!)")
            
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
            print("Đã lấy được Hourly Data của \(self.paramHourly["city"]!)")
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
            print("Đã lấy được weekly data của \(self.paramWeekly["city"]!)")
            self.collectionView.reloadData()
            
        }
        
    }//
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = collectionView.bounds.width
        switch indexPath.row {
        case 0:
            return CGSize(width: w, height: w*4/6)
        case 1:
            return CGSize(width: w, height: w*1/3)
        case 2:
            return CGSize(width: w, height: 620)
        default:
            return CGSize(width: w, height: 180)
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cell 1: Đổ dữ liệu Current data
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! Cell1
            
            if currentData.count > 0 {
                cell.cityLabel.text = currentData[0].cityName
                cell.discriptionLabel.text = currentData[0].weather?.description
                cell.tempLabel.text = "\(currentData[0].temp ?? 0)°"
                cell.windLabel.text = "\(round1(a: currentData[0].windSpd ?? 0.0)) km/h"
                cell.feelsLikeLabel.text = "\(Int(currentData[0].appTemp ?? 0))°"
                cell.humidityLabel.text = "\(currentData[0].rh ?? 0)%"
                cell.iconImage.image = .init(named: currentData[0].weather!.icon!)
            }
            
            // action khi bấm vào kính lúp bên cạnh tên City
            cell.handleSearchCity = {
                self.tabBarController?.selectedIndex = 1
                
            }
            
            return cell
        }
        // Cell2: là collectionView xoay ngang,  Đổ dữ liệu Hourly data vào
        if indexPath.row == 1 {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Cell2
            cell2.arrData = arrHourly
            
            return cell2
        }
        if indexPath.row == 2 {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! Cell3
            cell3.arrData = arrWeekly
            return cell3
        }
        
        // Cell 4: Đổ dữ liệu Curent Data
        let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as! Cell4
        let item = currentData[0]

        cell4.airQualityLabel.text = "\(item.aqi ?? 0)"
        cell4.sunRiseLabel.text = item.sunrise ?? "00:00"
        cell4.sunSetLabel.text = item.sunset ?? "00:00"
        cell4.uvLabel.text = "\(item.uv ?? 0)"
        cell4.precipLabel.text = "\(Int(item.precip ?? 0)) mm"
        
        
        return cell4
        
    }
    
    
    
}

extension HomeVC {
    func round1(a:Double)->Double {                          // func lấy bao nhiêu số sau dấu , của Float
        let mu = pow(10.0,1.0)                // chỉnh số 2.0 thành 3.0, 4.0….
        let r=round(a*mu)/mu
        return r
    }
    
    func stringFromAny(_ value:Any?) -> String {
        
        if let nonNil = value, !(nonNil is NSNull) {
            
            return String(describing: nonNil) // "Optional(12)"
        }
        return ""
    }
}
