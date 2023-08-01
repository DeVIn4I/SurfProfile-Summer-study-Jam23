//
//  DescView.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

final class DescView: View {
    
    private lazy var stackView = UIStackView(axis: .vertical, spacing: 8, arrangedSubviews: [titleLabel, descLabel]).withConstraints()

    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.text = "О себе"
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .left

        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        label.text = "Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет iddle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет iddle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет iddle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет iddle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет "
        return label
    }()
    
    override func setupView() {
        addSubview(stackView)

        backgroundColor = .white
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            

        ])
    }
    
}

