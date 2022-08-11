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
        
        let settingVC = SettingVC()
        let settingVCTabItem = UITabBarItem(title: "Setting", image: .init(named: "User"), selectedImage: .init(named: "User"))
        settingVC.tabBarItem = settingVCTabItem
        
        self.setViewControllers([homeVC, cityVC, settingVC], animated: true)
        
        self.tabBar.tintColor = UIColor("#183b8a")
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.barTintColor = UIColor("#ce5b06")
    }

}


extension TabBarViewController{
    
 func hexStringToUIColor (_ hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
 }
    
}
