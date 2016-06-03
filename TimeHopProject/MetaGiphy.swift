//
//  MetaGiphy.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import Gloss


struct MetaGiphy: Decodable {
    let status: Int?
    let msg: String?
    
    
    init?(json: JSON) {
        self.status = "status" <~~ json
        self.msg = "msg" <~~ json
    }
    
}