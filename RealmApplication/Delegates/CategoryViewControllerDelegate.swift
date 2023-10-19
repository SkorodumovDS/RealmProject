//
//  CategoryViewControllerDelegate.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 19.10.2023.
//


import Foundation
import RealmSwift

protocol CategoryViewControllerDelegate : AnyObject {
    func getJokeList() -> [String]
}


class CategoryInspector: CategoryViewControllerDelegate {
    var delegate: (CategoryViewControllerDelegate)?
   
    func getJokeList() -> [String] {
        let realm = try! Realm()
        let allJokeModels = realm.objects(RealmJoke.self).sorted(byKeyPath: "created_at")
        //var returnArray : [JokeListModel] = []
        let jokeCategory = allJokeModels.map {_element in
            _element.category
        }
        let nofiltredCategory =  Array(jokeCategory)
        let filteredCategory = Array(NSOrderedSet(array: nofiltredCategory)) as! [String]
        return filteredCategory}
    }

protocol CategoryFactory {
     func makeCategoryInspector () -> CategoryInspector
}


struct MyCategoryFactory : CategoryFactory {
    func makeCategoryInspector() -> CategoryInspector{
        let inspector = CategoryInspector()
        return inspector
    }
}

