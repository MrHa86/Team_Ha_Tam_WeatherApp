//
//  TabBarViewController.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 09/08/2022.
//

import UIKit
import UIColor_Hex_Swift

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
  
        setUpController()
    }
    
    func setUpController() {
        let homeVC = HomeVC()
        let homeVCTabItem = UITabBarItem(title: "Home", image: .init(named: "home"), selectedImage: .init(named: "home") )
        homeVC.tabBarItem = homeVCTabItem
        
        let cityVC = AddCityVC()
        let cityVCTabItem = UITabBarItem(title: "Location", image: .init(named: "pin"), selectedImage: .init(named: "pin"))
        cityVC.tabBarItem = cityVCTabItem
        
//        let settingVC = SettingVC()
//        let settingVCTabItem = UITabBarItem(title: "Setting", image: .init(named: "User"), selectedImage: .init(named: "User"))
//        settingVC.tabBarItem = settingVCTabItem
        
        self.setViewControllers([homeVC, cityVC], animated: true)
        
        self.tabBar.tintColor = UIColor("#183b8a")
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.barTintColor = UIColor("#ce5b06")
        
        
    }

}

