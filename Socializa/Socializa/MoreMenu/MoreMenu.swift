//
//  MoreMenuController.swift
//  Socializa
//
//  Created by Jose Luis Fernandez-Mayoralas on 10/04/2019.
//  Copyright © 2019 wadobo. All rights reserved.
//

import UIKit

protocol MoreMenuDelegate {
    func didSelectMenu(option: MenuOption)
}

class MenuOption: NSObject {
    var name: MenuOptionValue
    
    init(name: MenuOptionValue) {
        self.name = name
    }
}

class MoreMenu: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var delegate: MoreMenuDelegate?
    
    fileprivate let blackView = UIView()
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    fileprivate let cellId = "cellId"
    fileprivate let cellHeight: CGFloat = 50
    fileprivate let options: [MenuOption]
    fileprivate var selectedOption: MenuOption?
    
    init(options: [MenuOption]) {
        self.options = options
        
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MoreMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func show() {
        if let window = UIApplication.shared.keyWindow {
            selectedOption = nil
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = cellHeight * CGFloat(options.count) + 50
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut
                , animations: { [unowned self] in
                    self.blackView.alpha = 1
                    self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc fileprivate func dismissMenu() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { [unowned self] (isCompleted) in
            if let option = self.selectedOption {
                self.delegate?.didSelectMenu(option: option)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MoreMenuCell
        
        cell.caption = options[indexPath.item].name.rawValue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedOption = options[indexPath.item]
        dismissMenu()
    }
}
