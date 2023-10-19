//
//  MainTabBarController.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

final class MainTabBarController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControlles()
    }
    
    private func setControlles() {
       
        let donwloadNavController = UINavigationController()
        let listNavController = UINavigationController()
        let categoryNavController = UINavigationController()
        
        let downloadVC = Factory(flow: .download, category: "", navigation: donwloadNavController)
        let listVC = Factory(flow: .list, category: "",  navigation: listNavController)
        let categoryVC = Factory(flow: .category, category: "",  navigation: categoryNavController)
        
        viewControllers = [downloadVC.navigationController, listVC.navigationController, categoryVC.navigationController]
    }
}

