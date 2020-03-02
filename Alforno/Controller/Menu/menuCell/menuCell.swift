//
//  menuCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class menuCell: UITableViewCell {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   func configureCell(menus: catData){
       title.text = menus.title
       let urlWithoutEncoding = ("\(URLs.mainImage)\(menus.image!)")
       let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
       let encodedURL = NSURL(string: encodedLink!)! as URL
       img.kf.indicatorType = .activity
       if let url = URL(string: "\(encodedURL)") {
           img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
       }
   }
    
}
