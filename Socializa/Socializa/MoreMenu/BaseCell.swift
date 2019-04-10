//
//  BaseCell.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/04/2019.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
