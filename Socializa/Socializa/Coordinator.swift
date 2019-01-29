//
//  Coordinator.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 29/1/19.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
