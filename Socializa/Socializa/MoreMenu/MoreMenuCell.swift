//
//  MoreMenuCell.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/04/2019.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class MoreMenuCell: BaseCell {
    var caption: String? {
        didSet {
            captionLabel.text = caption
        }
    }
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign out"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            captionLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(captionLabel)
        
        addConstraints(format: "H:|-8-[v0]|", views: captionLabel)
        addConstraints(format: "V:|[v0]|", views: captionLabel)
    }
}
