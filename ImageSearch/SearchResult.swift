//
//  Image.swift
//  ImageSearch
//
//  Created by Андрей Букша on 08.12.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import Foundation
import Alamofire

class SearchResult {
    
    private var _imgLink: String!
    private var _imageName: String!
    private var _searchRequest: String!
    private var _searchUrl: String!
    
    var imgLink: String {
        return _imgLink
    }
    
    var imageName: String {
        return _imageName
    }
    
    var searchRequest: String {
        return _searchRequest
    }
    
    init(dictionary: Dictionary<String,AnyObject>) {
        if let imgLink = dictionary["link"] as? String {
            self._imgLink = imgLink
        }
        
        if let imageName = dictionary["snippet"] as? String {
            self._imageName = imageName
        }
    }
    
}