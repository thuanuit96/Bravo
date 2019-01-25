//
//  MusicData.swift
//  Demo
//
//  Created by asto on 1/7/19.
//  Copyright © 2019 asto. All rights reserved.
//

//
//  MusicData.swift
//  Demo
//
//  Created by asto on 1/6/19.
//  Copyright © 2019 asto. All rights reserved.
//
import Foundation
import UIKit

class MusicData {
    
    enum MusicType {
        case LOCAL, ONLINE, NONE
    }
    
    var musicName : String?
    var singer : String?
    var art :String?
    var imgAvatar : String?
    var linkUrl : String?
    var ext : String?
    var type : MusicType?
    
    func initMusicData(musicName : String, singer : String, art :String, imgAvatar : String, linkUrl : String, ext : String, type : MusicType)  {
        self.musicName = musicName
        self.singer = singer
        self.art = art
        self.imgAvatar = imgAvatar
        self.linkUrl = linkUrl
        self.ext = ext
        self.type = type
    }
}

