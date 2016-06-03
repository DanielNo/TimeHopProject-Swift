//
//  PaginationGiphy.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import Gloss

struct PaginationGiphy: Decodable {
    let count: Int?
    let offset: Int?

    
    // 2
    init?(json: JSON) {
        self.count = "pagination" <~~ json
        self.offset = "offset"  <~~ json
    }
    
}