//
//  productsAdditionsCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productsAdditionsCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var selctedImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = 8.0
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selctedImg.image = selected ? #imageLiteral(resourceName: "Group 19") : #imageLiteral(resourceName: "Group 19-1")
    }
    
//    override var isSelected: Bool {
//        didSet{
//            selctedImg.image =  isSelected ? UIImage(named: "Group 19-1") : UIImage(named: "Group 19")
//        }
//    }
    
    
    
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
        price.text = offer.priceGeneral	
        let urlWithoutEncoding = ("\(URLs.mainImage)\(offer.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
}
