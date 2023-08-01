//
//  UIStackView+Extension.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubview(views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
    
    convenience init(axis: NSLayoutConstraint.Axis,
                     alignment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill,
                     spacing: CGFloat = 0,
                     arrangedSubviews: [UIView]? = nil) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        if let arrangedSubviews {
            addArrangedSubview(views: arrangedSubviews)
        }
    }
    
}
