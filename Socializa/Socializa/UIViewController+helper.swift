//
//  UIViewController+helper.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 14/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Socializa error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
