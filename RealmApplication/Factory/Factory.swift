//
//  Factory.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//

import UIKit

final class Factory {
    enum Flow {
        case download
        case list
        case category
        case quoteOfCategory
    }
    
    private let flow : Flow
    private (set) var category : String?
    private (set) var navigationController = UINavigationController()
    private (set) var viewController : UIViewController?
    
    init(flow: Flow, category: String, navigation: UINavigationController) {
        self.flow = flow
        self.category = category
        self.navigationController = navigation
        startModule()
    }
    
    private func startModule() {
        
        switch flow {
        case .download:
            let downloadFactory = MyDownloadFactory()
            let downloadInspector = downloadFactory.makeDownloadInspector()
            let downloadViewController = DownloadViewController(downloadDelegate: downloadInspector)
            
            let downloadInspectorObject = downloadInspector
            downloadInspectorObject.delegate = downloadViewController as? any DownloadViewControllerDelegate
            
            downloadViewController.title = "Download"
            downloadViewController.view.backgroundColor = .systemBackground
            downloadViewController.tabBarItem.title = "Download"
            downloadViewController.tabBarItem.image = UIImage(systemName: "tray.and.arrow.down.fill")
            navigationController.setViewControllers([downloadViewController], animated: true)
            viewController = downloadViewController
            
        case .list:
            let listFactory = MyListFactory()
            let listInspector = listFactory.makeListInspector()
            let listViewController = ListViewController(listDelegate: listInspector)
            
            let listInspectorObject = listInspector
            listInspectorObject.delegate = listViewController as? any ListViewControllerDelegate
            
            listViewController.title = "List"
            listViewController.view.backgroundColor = .systemBackground
            listViewController.tabBarItem.title = "List"
            listViewController.tabBarItem.image = UIImage(systemName: "folder")
            navigationController.setViewControllers([listViewController], animated: true)
            
        case .category:
           
            let categoryFactory = MyCategoryFactory()
            let categoryInspector = categoryFactory.makeCategoryInspector()
            let categoryViewController = CategoryViewController(categoryDelegate: categoryInspector)
            
            let categoryInspectorObject = categoryInspector
            categoryInspectorObject.delegate = categoryViewController as? any CategoryViewControllerDelegate
            
            categoryViewController.title = "Category"
            categoryViewController.view.backgroundColor = .systemBackground
            categoryViewController.tabBarItem.title = "Category"
            categoryViewController.tabBarItem.image = UIImage(systemName: "folder")
            navigationController.setViewControllers([categoryViewController], animated: true)
            
        case .quoteOfCategory:
            
            let quoteOfCategoryFactory = MyQuoteOfCategoryFactory()
            let quoteOfCategoryInspector = quoteOfCategoryFactory.makeQuoteOfCategoryInspector()
            let quoteOfCategoryViewController = QuoteOfCategoryViewController(quoteOfCategoryDelegate: quoteOfCategoryInspector, nameOfCategory: category!)
            
            let quoteOfCategoryInspectorObject = quoteOfCategoryInspector
            quoteOfCategoryInspectorObject.delegate = quoteOfCategoryViewController as? any QuoteOfCategoryViewControllerDelegate
            
            quoteOfCategoryViewController.title = category!
            quoteOfCategoryViewController.view.backgroundColor = .systemBackground
            quoteOfCategoryViewController.tabBarItem.title = category!
            quoteOfCategoryViewController.tabBarItem.image = UIImage(systemName: "folder")
            //navigationController.setViewControllers([quoteOfCategoryViewController], animated: true)
            viewController = quoteOfCategoryViewController
        }
    }
    
}

