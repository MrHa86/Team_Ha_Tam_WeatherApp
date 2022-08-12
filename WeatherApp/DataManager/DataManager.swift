//
//  DataManager.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 10/08/2022.
//

import Foundation
import SwiftyJSON
import Alamofire

class DataManager {
    static let shared = DataManager()
    
    var checkIsSearch: Bool = false
    
    var arrCity: [String] = []                      // Mảng để lưu các City đã chọn gần đây
    
    var arrCurrentData: [Data] = []                 // Mảng để chứa dữ liệu các city gần đây, đổ vào TableView của AddCityVC
    let zeroDataTemp: Data = Data()
    
    let KEY_SAVE_ARRAY_CITY = "Array City"             // Key lưu các Recent City

    var paramCurrent: Parameters = ["key": "745e4fb30356479f90eb88f6c5020641",          // param để get Current Data
                                    "city": ""]

    
    
    // Lấy Dl trước cho AddCityVC
    func getCurrentDataForAddCityVC() {
        arrCity = UserDefaults.standard.stringArray(forKey: KEY_SAVE_ARRAY_CITY) ?? []
        print("ArrCity có \(arrCity.count) thành phố là: ")
        
        // append số phần tử ứng với số city để lấy index cho arrCurrentData
        for _ in 0..<arrCity.count {
            arrCurrentData.append(zeroDataTemp)
        }
        
        for i in 0..<arrCity.count {
            print(arrCity[i])
            paramCurrent["city"] = arrCity[i]
            // GET Current Data
            guard let url = URL(string: "https://api.weatherbit.io/v2.0/current?") else {
                print("URL không tồn tại")
                return
            }
            
            
            // Request Current Data
            Alamofire.request(url, method: .get, parameters: paramCurrent, headers: nil).responseJSON { response in
                guard let value = response.result.value else {
                    print("No data response")
                    return
                }
                
                let data = Current(JSON(value)).data!
                self.arrCurrentData[i] = (data[0])                // Đã có index lấy trước, ko là bị lỗi. Do data trả về ko theo thứ tự nên phải làm vậy.
                print("Đã lấy trước Current Data của \(self.arrCity[i])")
                
            }
        }
       
        
    }
    
    // Lấy DL trước cho HomeVC
    
    
}
