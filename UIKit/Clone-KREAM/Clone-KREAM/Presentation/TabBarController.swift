//
//  TabBarController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    ///ViewController
    private let homeVC = HomeViewController()
    private let styleVC = StyleViewController()
    private let shopVC = ShopViewController()
    private let savedVC = SavedViewController()
    private let myVC = MyViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        appearance()
    }
    
    private func setTabBar() {
        self.tabBar.backgroundColor = .white
        self.tabBar.isTranslucent = false
        
        homeVC.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(named: "homeIcon"), tag: 0)
        styleVC.tabBarItem = UITabBarItem(title: "STYLE", image: UIImage(named: "styleIcon"), tag: 1)
        shopVC.tabBarItem = UITabBarItem(title: "SHOP", image: UIImage(named: "shopIcon"), tag: 2)
        savedVC.tabBarItem = UITabBarItem(title: "SAVED", image: UIImage(named: "savedIcon"), tag: 3)
        myVC.tabBarItem = UITabBarItem(title: "MY", image: UIImage(named: "myIcon"), tag: 4)
        
        self.viewControllers = [homeVC, styleVC, shopVC, savedVC, myVC]
    }
    
    /// 클릭 시, 검은색으로 칠해지도록 Aprrearance 조정 함수
    private func appearance() {
        let barAppearance = UITabBarAppearance()
        barAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.black
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        barAppearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.black
        barAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.black
        
        self.tabBar.standardAppearance = barAppearance
        self.tabBar.backgroundColor = .clear
    }
}
