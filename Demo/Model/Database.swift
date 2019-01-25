//
//  Database.swift
//  Demo
//
//  Created by asto on 1/15/19.
//  Copyright © 2019 asto. All rights reserved.
//

import Foundation
import SQLite
class Database {
    static let getInstance = Database()
    public let connection : Connection?
    public let databaseFileName = "sqliteExample.sqlite3"
    public init () {
        let dbPatch = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String!
        do {
//             connection = try Connection("\(dbPatch!)/\(databaseFileName))")
            connection = try Connection("/Users/asto/Desktop/Demo/music.db")

            print(connection)
        }
        catch {
            connection = nil
            let nserror =  error as NSError
            print("Can not connect to database. Error is : \(nserror),\(nserror.userInfo)")
        }
        
    
    }
   
    
    
}
