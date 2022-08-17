//
//  AddCityVC.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 07/08/2022.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON


class AddCityVC: BaseViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResult: [String] = []                 // mảng để lưu các city trả về khi search
   
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTBV()
        setupUI()
        hideKeyboardWhenTappedAround() 
        DataManager.shared.arrCity = UserDefaults.standard.stringArray(forKey: DataManager.shared.KEY_SAVE_ARRAY_CITY) ?? []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if DataManager.shared.arrCurrentData.count > 0 && DataManager.shared.arrCurrentData[0].cityName == "" {
            print("Chưa có DL")
            // chờ 2s cho data về rồi reload TableView
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.tableView.reloadData()
            }

        }

    }
    
    func setupUI() {
        searchTextField.layer.cornerRadius = searchTextField.bounds.height/2
        searchTextField.clipsToBounds = true
        searchTextField.leftViewMode = .always
        searchTextField.leftView = UIView(frame: .init(x: 0, y: 0, width: searchTextField.bounds.height/2, height: searchTextField.bounds.height))
        searchTextField.delegate = self
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search for a city",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    func configTBV() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CityTableCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        tableView.tableFooterView = UIView()
  
    }
    //MARK: -Tap on Search Button
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
        searchRequest.resultTypes = .address
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
    //MARK: - Delegate, Datasource
extension AddCityVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DataManager.shared.checkIsSearch {
            tableView.separatorStyle = .singleLine
            return searchResult.count
        } else {
            tableView.separatorStyle = .none
            return DataManager.shared.arrCity.count
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
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = searchResult[indexPath.row]
            
            return cell
        } else {                // Nếu là TBV Recent City
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableCell
            cell.bindData(item: DataManager.shared.arrCurrentData[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if DataManager.shared.checkIsSearch {      // nếu là TBV Search thì bắn Notification về Home
            let city = searchResult[indexPath.row]
            let data = ["userInfo": city]
            NotificationCenter.default.post(name: NSNotification.Name("did.select.city"), object: nil, userInfo: data)
            
            // Thêm City vào mảng Recent City
            DataManager.shared.arrCity = UserDefaults.standard.stringArray(forKey: DataManager.shared.KEY_SAVE_ARRAY_CITY) ?? []
            if DataManager.shared.arrCity.contains(city) {
                print("city vừa search đã có sẵn nên ko add vào arrCity")
            } else {
                DataManager.shared.arrCity.append(city)
                print("Vừa append City \(city) vào arrCity")
            }
            
            UserDefaults.standard.setValue(DataManager.shared.arrCity, forKey: DataManager.shared.KEY_SAVE_ARRAY_CITY)
            searchTextField.text = ""
            searchResult = []
            DataManager.shared.checkIsSearch = false
            tableView.reloadData()
            tabBarController?.selectedIndex = 0
        } else {                // nếu đang là TBV RecentCity
            let data = ["userInfo": DataManager.shared.arrCity[indexPath.row]]
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
                DataManager.shared.arrCity.remove(at: indexPath.row)
                UserDefaults.standard.setValue(DataManager.shared.arrCity, forKey: DataManager.shared.KEY_SAVE_ARRAY_CITY)
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
        
        if searchTextField.text == "" {
            self.view.makeToast("Please enter a City or location !!!")
            return true
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
        return true
    }
}

    // MARK: - Extension
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false                        // vẫn nhận sự kiện tap vào content của CollectionView
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

