//
//  GifViewerModel.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/21/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import Foundation
import Gloss
import Alamofire

class GifViewerModel{
    var trendingFeed : GiphyFeed?
    var gifArray : [DataGiphy]?
    var searchArray : [DataGiphy]?
    
    init(){
        self.trendingFeed = nil
        self.gifArray = nil
        self.searchArray = nil
        }
    
    func getSearchArray () ->[DataGiphy]?{
        return searchArray
    }
    
    func getGifsArray () ->[DataGiphy]?{
        return gifArray
    }

    func getGifHeight (indexPath: NSIndexPath)-> CGFloat?{
        let dataObj : DataGiphy? = gifArray?[indexPath.row]
        let height = dataObj?.giphyImages?.fixedHeight?.height
        return height
    }

    func getGifWidth (indexPath: NSIndexPath)-> CGFloat?{
        let obj : DataGiphy? = gifArray?[indexPath.row]
        let width = (obj!.giphyImages?.fixedHeight?.height)!
        return width
    }
    
    func getGifUrl (indexpath: NSIndexPath, giphyArray:[DataGiphy]?) ->String?{
        return giphyArray?[indexpath.row].giphyImages?.fixedHeight?.url
    }
    
    // MARK : Network
    
    func fetchGifData(){
        self.fetchTrendingGifs("http://api.giphy.com/v1/gifs/trending?", params: ["api_key":"dc6zaTOxFJmzC"])
    }
    
    private func mapJson(json:JSON) -> Void {
        self.trendingFeed = GiphyFeed(json: json)
        self.gifArray = trendingFeed?.giphyData
        NSNotificationCenter.defaultCenter().postNotificationName("GifDataReceived", object: nil)
    }
    
    private func fetchTrendingGifs(baseUrl: String, params: [String:String]){
        //        http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC
        Alamofire.request(.GET, baseUrl, parameters: params)
            .responseJSON { response in
                
                guard response.result.isSuccess else {
                    print("fetching gifs error \(response.result.error)")
                    return
                }
                guard let responseJSON = response.result.value as? NSDictionary else {
                    print("No json data")
                    return
                }
                self.mapJson(responseJSON as! JSON)
        }
    }


    
}
