//
//  ViewController.swift
//  ImageSearch
//
//  Created by Андрей Букша on 08.12.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchField: MaterialTextField!
    @IBOutlet weak var tableView: UITableView!
    
    static var vcCache = NSCache()
    
    var searchTxt = ""

    
    
    var searchResults = [SearchResult]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell") as? ImageCell {
            
            cell.request?.cancel()
            
            var img: UIImage?
            
            img = ViewController.vcCache.objectForKey(searchResult.imgLink) as? UIImage
            
            cell.configureCell(searchResult)
            return cell
        } else {
            return ImageCell()
        }
    }

    @IBAction func searchBtnPressed(sender: AnyObject) {
        if let txt = searchField.text where txt != "" {
            
            if txt.rangeOfString(" ") != nil {
                let newStr = txt.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                searchTxt = newStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            } else {
                searchTxt = txt.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                
            }
            
            let url = NSURL(string: "\(BASE_URL)q=\(searchTxt)\(API_KEY)\(FORMAT)")!
            
            Alamofire.request(.GET, url).responseJSON { (response) -> Void in
                self.searchResults = []
                if let dictArr = response.result.value as? Dictionary<String,AnyObject> {
                    if let items = dictArr["items"] as? [Dictionary<String,AnyObject>] {
                        for item in items {
                            let googleImage = SearchResult(dictionary: item)
                            self.searchResults.append(googleImage)
                        }
                    }
                }
                self.tableView.reloadData()
            }
            
            
        
        }
        
    }
    
}

