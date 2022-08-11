//
//  AddCityVC.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 07/08/2022.
//

import UIKit
import MapKit


class AddCityVC: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResult: [String] = []                 // mảng để lưu các city trả về khi search
    var handleSelectCity: ((String) -> Void)?       // Closure để truyền City đã chọn về màn Home
    
    var arrCity: [String] = []
    let KEY_SAVE_ARRAY_CITY = "Array City"
    // Set để lưu các city đã từng chọn
    var checkIsSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTBV()
        setupUI()
        
        arrCity = UserDefaults.standard.stringArray(forKey: KEY_SAVE_ARRAY_CITY) ?? []
        
    }
    
    func setupUI() {
        searchTextField.layer.cornerRadius = searchTextField.bounds.height/2
        searchTextField.clipsToBounds = true
        searchTextField.leftViewMode = .always
        searchTextField.leftView = UIView(frame: .init(x: 0, y: 0, width: searchTextField.bounds.height, height: searchTextField.bounds.height))
        searchTextField.delegate = self
    }
    func configTBV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CityTableCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        tableView.tableFooterView = UIView()
        
    }
    
    @IBAction func actionSearch(_ sender: UIButton) {
        // mỗi lần search thì reset lại tableViewSearch
        searchResult = []
        view.endEditing(true)
        
        if searchTextField.text == "" {
            self.view.makeToast("Please enter a City or location !!!")
            return
        }
        startAnimating()
        DataManager.shared.checkIsSearch = true
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchTextField.text
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard let response = response else {
                print("No data response")
                self.stopAnimating()
                return
            }
            
            for item in response.mapItems {
                if let name = item.name,
                   let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    self.searchResult.append(name)
                    
                }
            }
            self.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    
}

extension AddCityVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.checkIsSearch {
            return searchResult.count
        } else {
            return arrCity.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if DataManager.shared.checkIsSearch {
            return 45
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if DataManager.shared.checkIsSearch {      // nếu là TBV search
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = searchResult[indexPath.row]
            
            return cell
        } else {                // Nếu là TBV Recent City
//            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//            cell.textLabel?.text = arrCity[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableCell
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if DataManager.shared.checkIsSearch {      // nếu là TBV Search
            let city = searchResult[indexPath.row]
            let data = ["userInfo": city]
            NotificationCenter.default.post(name: NSNotification.Name("did.select.city"), object: nil, userInfo: data)
            
            // Thêm City vào mảng Recent City
            if arrCity.contains(city) {
                print("city vừa search trùng lặp")
            } else {
                arrCity.append(city)
            }
            
            UserDefaults.standard.setValue(arrCity, forKey: KEY_SAVE_ARRAY_CITY)
            searchTextField.text = ""
            searchResult = []
            DataManager.shared.checkIsSearch = false
            tableView.reloadData()
            tabBarController?.selectedIndex = 0
        } else {                // nếu đang là TBV RecentCity
            let data = ["userInfo": arrCity[indexPath.row]]
            NotificationCenter.default.post(name: NSNotification.Name("did.select.city"), object: nil, userInfo: data)
            searchTextField.text = ""
            
            DataManager.shared.checkIsSearch = false
            tableView.reloadData()
            tabBarController?.selectedIndex = 0
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if DataManager.shared.checkIsSearch {
            return UISwipeActionsConfiguration(actions: [])
        } else {
            let deleteButton = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
                self.arrCity.remove(at: indexPath.row)
                UserDefaults.standard.setValue(self.arrCity, forKey: self.KEY_SAVE_ARRAY_CITY)
                tableView.reloadData()
            }
            deleteButton.backgroundColor = .red
            return UISwipeActionsConfiguration(actions: [deleteButton])
        }
    }
    
}

extension AddCityVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        // mỗi lần search thì reset lại tableViewSearch
        searchResult = []
        view.endEditing(true)
        
        startAnimating()
        DataManager.shared.checkIsSearch = true
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchTextField.text
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (response, error) in
            guard let response = response else {
                print("No data response")
                self.stopAnimating()
                return
            }
            
            for item in response.mapItems {
                if let name = item.name,
                   let location = item.placemark.location {
                    print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                    self.searchResult.append(name)
                    
                }
            }
            self.stopAnimating()
            self.tableView.reloadData()
        }
        return true
    }
}
