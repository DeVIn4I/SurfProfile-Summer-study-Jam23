//
//  UICollectionView+Extension.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        register(type.self, forCellWithReuseIdentifier: type.reuseId)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withReuseIdentifier: T.reuseId, for: indexPath) as? T {
            return cell
        } else {
            fatalError("Can't dequeue cell with identifier - \(T.reuseId)")
        }
    }
}
