//
//  ImageButton.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 14/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

class ImageButton: UIButton {
    init(image: UIImage, target: Any?, action: Selector) {
        super.init(frame: .zero)
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
