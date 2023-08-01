//
//  UIView+Extension.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

extension UIView {
    @discardableResult
    func withConstraints(_ with: Bool = true) -> Self {
        translatesAutoresizingMaskIntoConstraints = !with
        return self
    }
}
