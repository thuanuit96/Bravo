//
//  DepartmentEntity.swift
//  Demo
//
//  Created by asto on 1/15/19.
//  Copyright © 2019 asto. All rights reserved.
//

import Foundation
import SQLite
class DepartmentEntity : Database {
//    static let getInstance = DepartmentEntity()
    let tblDepartment = Table("tblDepartment")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let address = Expression<String>("address")
    let city = Expression<String>("city")
    let zipCode = Expression<String>("zipCode")
    override init () {
        super.init()
        do {
            if let connection = self.connection {
                try connection.run(tblDepartment.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id,primaryKey : true)
                    table.column(self.name)
                    table.column(self.address)
                    table.column(self.city)
                    table.column(self.zipCode)
                }))
                print("create table department successfully")
            } else
            {
                print("create table department failed")
                
            }
        }
        catch {
            let nserror =  error as NSError
            print("Can not connect to database. Error is : \(nserror),\(nserror.userInfo)")
        }
    }
    func toString(department :Row)  {
        print("Department details .name =\(department[name]),address = \(department[address]),city = \(department[city]),zipCode = \(department[zipCode])")
    }
    
}
