//
//  ListViewControllerDelegate.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 19.10.2023.
//

import Foundation
import RealmSwift

protocol ListViewControllerDelegate : AnyObject {
    func getJokeList() -> [JokeListModel]
}

struct JokeListModel  {
    var value: String = ""
    var category : String = ""
    var created_at : Date? = nil
    
    init(value: String, category: String, created_at: String) {
        self.value = value
        self.category = category
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: created_at)
        self.created_at = date
    }
}

class ListInspector: ListViewControllerDelegate {
    var delegate: (ListViewControllerDelegate)?
   
    func getJokeList() -> [JokeListModel] {
        let realm = try! Realm()
        let allJokeModels = realm.objects(RealmJoke.self).sorted(byKeyPath: "created_at")
        //var returnArray : [JokeListModel] = []
        let Jokes = allJokeModels.map {_element in
            JokeListModel(value: _element.value, category: _element.category, created_at: _element.created_at)
        }
    return Array(Jokes)}
    }

protocol ListFactory {
     func makeListInspector () -> ListInspector
}


struct MyListFactory : ListFactory {
    func makeListInspector() -> ListInspector{
        let inspector = ListInspector()
        return inspector
    }
}
