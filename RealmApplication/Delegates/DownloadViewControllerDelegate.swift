//
//  DownloadViewControllerDelegate.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 18.10.2023.
//
import Foundation
import RealmSwift

protocol DownloadViewControllerDelegate : AnyObject {
     
    func getRandomJoke(completion: @escaping(String) ->Void ) -> Void
}

struct JokeModel : Decodable {
    let value: String
    let categories : [String]
    let created_at : String
}

class DownloadInspector: DownloadViewControllerDelegate {
    var delegate: (DownloadViewControllerDelegate)?
    func getRandomJoke(completion: @escaping (String) -> Void) {
       
            let url = URL(string: "https://api.chucknorris.io/jokes/random")!
            let task  = URLSession.shared.dataTask(with: url) { (data: Data? ,response: URLResponse?, error: Error?) -> Void in
                if let data = data {
                    let jsonData = try! JSONDecoder().decode(JokeModel.self, from: data)
                    
                    let realm = try! Realm()
                    let realmJoke = RealmJoke()
                    realmJoke.value = jsonData.value
                    realmJoke.created_at = jsonData.created_at
                    if jsonData.categories.isEmpty {
                        realmJoke.category = "empty"
                    }else {
                        realmJoke.category = jsonData.categories.first!
                    }
                    
                    try! realm.write{
                        realm.add(realmJoke, update: .modified)
                    }
                    
                    DispatchQueue.main.async { completion(jsonData.value)}
                }
            }
            task.resume()
        }
    }

protocol DownloadFactory {
     func makeDownloadInspector () -> DownloadInspector
}


struct MyDownloadFactory : DownloadFactory {
    func makeDownloadInspector() -> DownloadInspector{
        let inspector = DownloadInspector()
        return inspector
    }
}
