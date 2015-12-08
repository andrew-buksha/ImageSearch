//
//  ImageCell.swift
//  ImageSearch
//
//  Created by Андрей Букша on 08.12.15.
//  Copyright © 2015 Андрей Букша. All rights reserved.
//

import UIKit
import Alamofire

class ImageCell: UITableViewCell {

    @IBOutlet weak var imageNameLbl: UILabel!
    @IBOutlet weak var googleImage: UIImageView!
    
    var searchResult: SearchResult!
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(searchResult: SearchResult) {
        self.searchResult = searchResult
        
        self.imageNameLbl.text = searchResult.imageName
        
        request = Alamofire.request(.GET, searchResult.imgLink).validate(contentType: ["image/*"]).response(completionHandler: { request, response, data, err in
            if err == nil {
                let googleImage = UIImage(data: data!)!
                self.googleImage.image = googleImage
                ViewController.vcCache.setObject(googleImage, forKey: self.searchResult.imgLink)
            }
        })
    }

}
