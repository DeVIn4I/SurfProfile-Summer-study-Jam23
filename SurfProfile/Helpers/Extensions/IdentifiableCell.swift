//
//  IdentifiableCell.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

protocol IdentifiableCell {
    static var reuseId: String { get }
}

extension IdentifiableCell {
    static var reuseId: String { "\(self)" }
}

extension UICollectionViewCell: IdentifiableCell {}
