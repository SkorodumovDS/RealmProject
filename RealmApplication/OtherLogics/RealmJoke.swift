//
//  RealmJoke.swift
//  RealmApplication
//
//  Created by Skorodumov Dmitry on 19.10.2023.
//

import Foundation
import RealmSwift

class RealmJoke : Object {
    @Persisted var value = ""
    @Persisted var  category = ""
    @Persisted var  created_at  = ""
    
    override class func primaryKey() -> String? {
        "value"
    }
}
