//
//  song.swift
//  Demo
//
//  Created by asto on 1/18/19.
//  Copyright © 2019 asto. All rights reserved.
//

import Foundation
struct song {
    let id :Int64
    let name : String
    let singer: String
    let art : String
    let playListId: Int64
    let avata : String
    let url : String
    
    init(id :Int64, name: String , singer:String, art: String ,playListId: Int64, url: String ,avata :String) {
        self.id = id
        self.name = name
        self.singer = singer
        self.art = art
        self.playListId = playListId
        self.url = url
        self.avata = avata
    }
    
    
}
