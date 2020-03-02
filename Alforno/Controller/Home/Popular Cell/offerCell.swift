//
//  bopularCell.swift
//  Alforno
//
//  Created by Ahmed farid on 2/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class offerCell: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var offerDescripation: UILabel!
//    @IBOutlet weak var typeOfMeil: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var favBTN: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = 8.0
        
    }	
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    func configureCell(offer: offfersData){
        title.text = offer.title
        price.text = offer.salePrice
        oldPrice.text = offer.priceGeneral
        offerDescripation.text = offer.shortDescription
        let urlWithoutEncoding = ("\(URLs.mainImage)\(offer.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
