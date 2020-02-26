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
    
}
