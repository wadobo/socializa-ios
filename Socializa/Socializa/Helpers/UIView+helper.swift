//
//  UIView+helper.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/04/2019.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraints(format: String, views: UIView...) {
        var viewsDicitonary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDicitonary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDicitonary))
    }
}
