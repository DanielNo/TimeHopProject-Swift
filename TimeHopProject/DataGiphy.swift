//
//  DataGiphy.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import Gloss

struct DataGiphy: Decodable {
    
    let type: String?
    let id: String?
    let slug: String?
    let url: String?
    let bitly_gif_url: String?
    let bitly_url: String?
    let embed_url: String?
    let username: String?
    let source: String?
    let rating: String?
    let caption: String?
    let content_url: String?
//    let user : UserGyphy?
    let source_tld: String?
    let source_post_url: String?
    let import_datetime: String?
    let trending_datetime: String?
    let giphyImages: ImagesGiphy?
    
    init?(json: JSON) {
        type = "type" <~~ json
        id = "id" <~~ json
        slug = "slug" <~~ json
        url = "url" <~~ json
        bitly_gif_url = "bitly_gif_url" <~~ json
        bitly_url = "bitly_url" <~~ json
        embed_url = "embed_url" <~~ json
        username = "username" <~~ json
        source = "source" <~~ json
        rating = "rating" <~~ json
        caption = "caption" <~~ json
        content_url = "content_url" <~~ json
        source_tld = "source_tld" <~~ json
        source_post_url = "source_post_url" <~~ json
        import_datetime = "import_datetime" <~~ json
        trending_datetime = "trending_datetime" <~~ json
        giphyImages = "images" <~~ json
    }
    
    func getImage() -> String?{
        return self.giphyImages?.fixedHeight?.url
    }
    
}