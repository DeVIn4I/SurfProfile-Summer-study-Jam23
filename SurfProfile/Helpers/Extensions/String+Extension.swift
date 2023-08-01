//
//  String+Extension.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

@resultBuilder
struct AttributedBuilder {
    static func buildBlock(_ components: NSAttributedString...) -> NSAttributedString {
        let result = NSMutableAttributedString()
        components.forEach { result.append($0) }
        return result
    }
}

extension String {
    func withAttr(font: UIFont? = UIFont.systemFont(ofSize: 16),
                  color: UIColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1),
                  withUnderline: Bool = false) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(
            NSMutableAttributedString(string: self,
                                      attributes:
                                        [NSAttributedString.Key.font :font ?? UIFont.systemFont(ofSize: 16),
                                         NSAttributedString.Key.foregroundColor : color]))
        if withUnderline {
            attributedString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue ], range: NSRange(location: 0, length: attributedString.length))
        }
        return attributedString
    }
}
