//
//  productSizeCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productSizeCell: UICollectionViewCell {

    @IBOutlet weak var sizeName: UILabel!
    @IBOutlet weak var sizeImage: UIImageView!
    @IBOutlet weak var sizePrice: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet{
            sizeImage.image =  isSelected ? UIImage(named: "Group 253-1") : UIImage(named: "Group 6")
            sizeName.textColor = isSelected ?  #colorLiteral(red: 0.1254901961, green: 0.6705882353, blue: 0.1725490196, alpha: 1) : #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
            sizePrice.textColor = isSelected ?  #colorLiteral(red: 0.1254901961, green: 0.6705882353, blue: 0.1725490196, alpha: 1) : #colorLiteral(red: 0.5450980392, green: 0.5450980392, blue: 0.5450980392, alpha: 1)
        }
    }
    
    func configureCell(sizes: dataSize){
           sizeName.text = sizes.size
           sizePrice.text = sizes.salePrice
       }

}
