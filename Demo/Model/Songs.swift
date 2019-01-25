//
//  Songs.swift
//  Demo
//
//  Created by asto on 1/17/19.
//  Copyright © 2019 asto. All rights reserved.
//

//
//  DepartmentEntity.swift
//  Demo
//
//  Created by asto on 1/15/19.
//  Copyright © 2019 asto. All rights reserved.
//

import Foundation
import SQLite
class Songs : Database {
    //    static let getInstance = DepartmentEntity()
    let tblSongs = Table("tblSongs")
    let id = Expression<Int64>("id")
    let name = Expression<String>("name")
    let singer = Expression<String>("singer")
    let art = Expression<String>("art")
    let playListId = Expression<Int64>("playListId")
    let avata = Expression<String>("avata")
    let url = Expression<String>("url")
    
    
    
    
    override init () {
        super.init()
        do {
            if let connection = self.connection {
                try connection.run(tblSongs.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id,primaryKey : true)
                    table.column(self.name)
                    table.column(self.singer)
                    table.column(self.art)
                    table.column(self.playListId)
                    table.column(self.avata)
                    table.column(self.url)
                }))
                print("create table songs successfully")
            } else
            {
                print("create table songs failed")
                
            }
        }
        catch {
            let nserror =  error as NSError
            print("Can not connect to database. Error is : \(nserror),\(nserror.userInfo)")
        }
    }
    func toString(song :Row)  {
        print("id: \(song[id]), name: \(song[name]), email: \(song[singer])")
    }
    func getAll() -> [song] {
       var listMusicData = [song]()
        do {
            print("dasdadasdas")
            var listSong = try self.connection?.prepare(tblSongs)
            for item in listSong! {
                let songObject : song = song(id: item[id], name: item[name], singer: item[singer], art: item[art], playListId: item[playListId], url: item[url], avata: item[avata])
                listMusicData.append(songObject)
            }
        }
        catch {
            
        }
        dump(listMusicData)
        return listMusicData
    }
    
}

