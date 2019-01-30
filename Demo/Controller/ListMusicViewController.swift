//
//  ListMusicViewController.swift
//  Demo
//
//  Created by asto on 1/6/19.
//  Copyright © 2019 asto. All rights reserved.
//

import UIKit
import SQLite

class ListMusicViewController: UIViewController {
    
    // MARK : Properties
    
    @IBOutlet weak var tableView: UICollectionView!
//    var listMusicData = [MusicData]()
        var listMusicData = [song]()
    var musicDataToPass: MusicData?
    var test2 :MusicData?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Management", comment: "")

    }
    
    static func loadData()  {

        
    }
        
        
        
//
//        let song =  Songs()
//        let db = song.connection
//        do {
////             for i in 1...9 {
////            let insert = song.tblSongs.insert(song.name <-  "song\(i)", song.singer <- "singer", song.art <- "Alice", song.playListId <- 1, song.avata <- "aaaa", song.url <- "/music")
//////            let sqlInsert =  "INSERT INTO \"tblSongs\" (\"name\", \"singer\", \"art\", \"playListId\",\"avata\",\"url\") VALUES (\"song\", \"ádads\",\"ádad\",\"d\")"
////            let rowid =  try db?.run(insert)
////                print(rowid)
////
////            }
//            self.listMusicData = song.getAll()
//
////            var listMusic = try db?.prepare()
//
////            for rowSong in  listMusic! {
////
////
////                listMusicData.append(rowSong as! Songs)
////                song.toString(song:rowSong)
////
////            }
//
//
//
//
//            //            let row : AnySequence<Row> =  (try departmentEntity.connection?.prepare(departmentEntity.tblDepartment))!
//            //get row
//            //            let alice = departmentEntity.tblDepartment.filter( departmentEntity.id == rowid!)
//            //            try departmentEntity.connection?.run(alice.update(departmentEntity.address <- "Thuan test "))
//            //Insert row
//            //
//            //            let row  =  (try departmentEntity.connection?.prepare(alice))!
//            //            for object in row {
//            //                departmentEntity.toString(department: object)
//            //            }
////            var sql = "UPDATE \"tblDepartment\" SET \"address\" = \"HoangVanThuan\""
////            //            var sql = "select * from tblDepartment join test on tblDepartment.id = test.dpmId"
////            var result =  try departmentEntity.connection?.prepare(sql)
////            dump(result)
//
//        }
//        catch {
//            //            let nserror =  error as NSError
//            print("Can not save. 1 Error is : \(error)")
//
//            //            print("Can not save. Error is : \(nserror),\(nserror.userInfo)")
//        }
//
////        for i in 1...9 {
////            let data = MusicData()
////            data.initMusicData(musicName: "Song \(i)", singer: "Singer \(i)", art: "AAA", imgAvatar: "Album_\(i)", linkUrl: "song\(i)", ext: "mp3", type : MusicData.MusicType.LOCAL)
////            listMusicData.append(data)
////        }
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        self.tableView.reloadData()
//    }
}

//extension ListMusicViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (self.listMusicData.count)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "libraryCell", for: indexPath) as! ListMusicCollectionViewCell
////        cell.musicName.text = musicData.musicName
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width / 2 - 1
//
//        return CGSize(width: width, height: 223)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let musicData = listMusicData[indexPath.row]
//        let detailcontroller = storyboard?.instantiateViewController(withIdentifier: "detailcontroller") as? DetailMusicViewController
//            detailcontroller?.data = listMusicData[indexPath.row]
//        detailcontroller?.listMusicData = listMusicData
//        detailcontroller?.songIndex = indexPath.row
//        dump(detailcontroller?.listMusicData)
//        self.navigationController?.pushViewController(detailcontroller!, animated: true)
//    }
//}

