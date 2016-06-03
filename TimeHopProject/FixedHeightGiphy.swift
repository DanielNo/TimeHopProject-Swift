//
//  FixedHeightGiphy.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation

import Gloss


 struct FixedHeightGiphy: Decodable {
    
    let url: String?
    let width: CGFloat?
    let height: CGFloat?
    let size: String?
    let mp4: String?
    let mp4_size: String?
    let webp: String?
    let webp_size: String?

    init?(json: JSON) {
        self.url = "url" <~~ json
        self.width = (("width" <~~ json)! as String).convertToFloat()
        self.height = (("height" <~~ json)! as String).convertToFloat()
        self.size = "size" <~~ json
        self.mp4 = "mp4" <~~ json
        self.mp4_size = "mp4_size" <~~ json
        self.webp = "webp" <~~ json
        self.webp_size = "webp_size" <~~ json
    }
    
}