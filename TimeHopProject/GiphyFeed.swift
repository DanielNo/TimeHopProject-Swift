//
//  GiphyFeed.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import Gloss

//data is an array of datagiphys

struct GiphyFeed: Decodable {
    let giphyData: [DataGiphy]?
    let giphyPagination : PaginationGiphy?
    let giphyMeta : MetaGiphy?
    
    init?(json: JSON) {
        self.giphyData = "data" <~~ json
        self.giphyPagination = "pagination" <~~ json
        self.giphyMeta = "meta" <~~ json

    }
    
}