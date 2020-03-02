//
//  prodectsCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class prodectsCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var offerDescripation: UILabel!
    //    @IBOutlet weak var typeOfMeil: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var favBTN: UIButton!
    
    override func awakeFromNib() {
        img.layer.cornerRadius = 10
        //img.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func configureCell(product: offfersData){
        title.text = product.title
        price.text = product.salePrice
        
        offerDescripation.text = product.shortDescription
        let urlWithoutEncoding = ("\(URLs.mainImage)\(product.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
