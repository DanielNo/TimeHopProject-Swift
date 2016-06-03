//
//  ImagesGiphy.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation

import Gloss

struct ImagesGiphy: Decodable {
    
    let fixedHeight: FixedHeightGiphy?
//    fixed_height
//    fixed_height_still
//    fixed_height_downsampled
//    fixed_width
//    fixed_width_still
//    fixed_width_downsampled
//    fixed_height_small
//    fixed_height_small_still
//    fixed_width_small
//    fixed_width_small_still
//    downsized
//    downsized_still
//    downsized_large
//    downsized_medium
//    original
//    original_still
//    looping
//    mp4
    

    
    init?(json: JSON) {
        fixedHeight = "fixed_height" <~~ json
    }
    
}