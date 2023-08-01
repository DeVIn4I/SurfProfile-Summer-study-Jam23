//
//  View.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

class View: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {}
}
