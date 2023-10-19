//
//  QuoteOfCategoryViewControllerDelegate.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 19.10.2023.
//


import Foundation
import RealmSwift

protocol QuoteOfCategoryViewControllerDelegate : AnyObject {
    func getJokeList(ofCategory: String) -> [String]
}


class QuoteOfCategoryInspector: QuoteOfCategoryViewControllerDelegate {
    var delegate: (QuoteOfCategoryViewControllerDelegate)?
   
    func getJokeList(ofCategory: String) -> [String] {
        let realm = try! Realm()
        let allJokeModels = realm.objects(RealmJoke.self).filter("category == %@", ofCategory).sorted(byKeyPath: "created_at")
        //var returnArray : [JokeListModel] = []
        let jokes = allJokeModels.map {_element in
            _element.value
        }
        let nofiltredCategory =  Array(jokes)
        let filteredCategory = Array(NSOrderedSet(array: nofiltredCategory)) as! [String]
        return filteredCategory}
    }

protocol QuoteOfCategoryFactory {
     func makeQuoteOfCategoryInspector () -> QuoteOfCategoryInspector
}


struct MyQuoteOfCategoryFactory : QuoteOfCategoryFactory {
    func makeQuoteOfCategoryInspector() -> QuoteOfCategoryInspector{
        let inspector = QuoteOfCategoryInspector()
        return inspector
    }
}

