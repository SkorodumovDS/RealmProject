//
//  MainCoordinator.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

protocol MainCoordinator {
    func startApplication() -> UIViewController
}

final class MainCoordinatorImp : MainCoordinator {
    func startApplication() -> UIViewController {
        return MainTabBarController()
    }
}

