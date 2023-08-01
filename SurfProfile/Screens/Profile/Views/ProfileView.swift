//
//  ProfileView.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

final class ProfileView: View {
    
    private lazy var stackView = UIStackView(axis: .vertical, spacing: 2, arrangedSubviews: [containerImageView, nameLabel, descLabel, locationLabel]).withConstraints()
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 60
        view.backgroundColor = .purple
        
        return view.withConstraints()
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Лупа Пупа Дотович Лупа Пупа Дотович"
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.textAlignment = .center

        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        label.text = "Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет Middle iOS-разработчик, опыт более 2-х лет"
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        label.attributedText = location
        
        return label
    }()

    @AttributedBuilder
    var location: NSAttributedString {
        UIImage(systemName: "location")!.toAttributedString(with: 16)
        "Москва".withAttr(font: .systemFont(ofSize: 14, weight: .regular), color: UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1))
    }
    
    private let containerImageView = View()
    
    override func setupView() {
        addSubview(stackView)
        containerImageView.addSubview(profileImageView)
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.topAnchor.constraint(equalTo: containerImageView.topAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: containerImageView.bottomAnchor, constant: -16),
            profileImageView.centerXAnchor.constraint(equalTo: containerImageView.centerXAnchor),
            
        ])
    }
    
}
