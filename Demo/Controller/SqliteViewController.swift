//
//  SqliteViewController.swift
//  Demo
//
//  Created by asto on 1/15/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import Foundation
import SQLite

class SqliteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let departmentEntity = DepartmentEntity()
        
        do {
            let insert = try departmentEntity.tblDepartment.insert(departmentEntity.name <- "Alice", departmentEntity.address <- "alice@mac.com",departmentEntity.city <- "Alice",departmentEntity.zipCode <- "Alice")
            let sqlInsert =  "INSERT INTO \"tblDepartment\" (\"name\", \"address\", \"city\", \"zipCode\") VALUES (\"aaaaaa\", \"ádads\",\"ádad\",\"d\")"
            let rowid =  try departmentEntity.connection?.run(sqlInsert)
    
            print(rowid)
//            let row : AnySequence<Row> =  (try departmentEntity.connection?.prepare(departmentEntity.tblDepartment))!
            //get row
//            let alice = departmentEntity.tblDepartment.filter( departmentEntity.id == rowid!)
//            try departmentEntity.connection?.run(alice.update(departmentEntity.address <- "Thuan test "))
            //Insert row
//
//            let row  =  (try departmentEntity.connection?.prepare(alice))!
//            for object in row {
//                departmentEntity.toString(department: object)
//            }
            var sql = "UPDATE \"tblDepartment\" SET \"address\" = \"HoangVanThuan\""
//            var sql = "select * from tblDepartment join test on tblDepartment.id = test.dpmId"
           var result =  try departmentEntity.connection?.prepare(sql)
            dump(result)

        }
        catch {
//            let nserror =  error as NSError
            print("Can not save. 1 Error is : \(error)")

//            print("Can not save. Error is : \(nserror),\(nserror.userInfo)")
        }
       
          
        
//        let rowid = try db.run(insert)
        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
