//
//  ViewController.swift
//  TimeHopProject
//
//  Created by Daniel No on 5/13/16.
//  Copyright © 2016 Daniel No. All rights reserved.
//

import UIKit
import Gloss
import Kingfisher



class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate{
    var viewModel : GifViewerModel = GifViewerModel()
    let gifCellIdentifier = "gifCell"
    var searchController : UISearchController!
    
    @IBOutlet weak var gifTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupObservers()
        self.setupTableView()
        self.setupSearchController()
        self.viewModel.fetchGifData()
        self.navigationItem.title = "Gif Searcher"
        
    }
    
    // MARK : View Controller Setup
    
    func setupObservers(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(refreshTable),
            name: "GifDataReceived",
            object: nil)
    }
    
    func setupSearchController(){
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        self.gifTableView.tableHeaderView = searchController.searchBar
        self.searchController.searchBar.scopeButtonTitles = ["Url","Source","Username"]
        searchController.dimsBackgroundDuringPresentation = false // default is YES
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false

    }
    
    func setupTableView(){
        self.gifTableView.registerClass(GifTableViewCell.self, forCellReuseIdentifier: gifCellIdentifier)
        self.gifTableView.registerNib(UINib.init(nibName: "GifTableViewCell", bundle: nil), forCellReuseIdentifier: gifCellIdentifier)
        self.gifTableView.rowHeight = UITableViewAutomaticDimension;
        self.gifTableView.estimatedRowHeight = 200.0;
    }
    
    // MARK: UISearchResultsUpdating
    
    func updateSearchResultsForSearchController(searchController: UISearchController){
        filterContentForSearchText(searchController.searchBar.text!, scope: searchController.searchBar.selectedScopeButtonIndex)
    }
    
    func filterContentForSearchText(searchText: String, scope: Int) {
        let searchText = searchController.searchBar.text?.lowercaseString
        switch scope {
        case 0:
            self.viewModel.searchArray = viewModel.getGifsArray()!.filter{ gif in
                return (gif.url?.containsString(searchText!))!
            }
            break
        case 1:
            self.viewModel.searchArray = viewModel.getGifsArray()!.filter{ gif in
                return (gif.source?.containsString(searchText!))!
            }

            break
        case 2:
            self.viewModel.searchArray = viewModel.getGifsArray()!.filter{ gif in
                return (gif.username?.containsString(searchText!))!
            }
            break
        default:
            break
            
        }
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if searchBar.text != "" {
            filterContentForSearchText(searchBar.text!, scope: searchBar.selectedScopeButtonIndex)
            self.gifTableView.reloadData()

        }
    }

    
    // MARK: UISearchBarDelegate

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        self.navigationItem.title = "Gif Searcher"
        searchBar.resignFirstResponder()
        self.filterContentForSearchText("",scope: 0)
        self.searchController.searchBar.selectedScopeButtonIndex = 0
        self.gifTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.gifTableView.reloadData()
        self.navigationItem.title = searchBar.text
    }
    
    // MARK: UITableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(gifCellIdentifier, forIndexPath: indexPath) as! GifTableViewCell
        
        if searchController.active && searchController.searchBar.text != "" {
            if let url = viewModel.getGifUrl(indexPath, giphyArray: viewModel.searchArray){
                cell.gifImageView.kf_setImageWithURL(NSURL(string:url)!,placeholderImage: nil)
            }
            
        } else {
            if let url = viewModel.getGifUrl(indexPath, giphyArray: viewModel.gifArray){
                cell.gifImageView.kf_setImageWithURL(NSURL(string:url)!,placeholderImage: nil)
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        guard let height = self.viewModel.getGifHeight(indexPath) else{
            return 0.0
        }
        return height
        }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if (viewModel.gifArray != nil || viewModel.searchArray != nil){
            return 1
        }
        else{
            return 0
        }

    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if searchController.active && searchController.searchBar.text != "" {
            print("rows : ",viewModel.searchArray!.count)
            if let filteredGifs = viewModel.getSearchArray() {
                return filteredGifs.count
            }
            else{
                return 0
            }
        }
        else{
            if let gifsArray = viewModel.getGifsArray(){
                print("rows : ",gifsArray.count)
                return gifsArray.count
            }
            else{
                print("rows : 0")
                return 0
            }
        }
    }
    
    func refreshTable(){
        self.gifTableView.reloadData()
    }


}

