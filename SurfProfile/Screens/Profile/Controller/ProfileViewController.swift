//
//  ProfileViewController.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var skills: [String] = []
    
    private lazy var scrollView = UIScrollView().withConstraints()
    private lazy var stackView = UIStackView(axis: .vertical, arrangedSubviews: [profileView, collection, descView]).withConstraints()
    private lazy var topSpaceView: View = {
       let view = View()
        view.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        return view.withConstraints()
    }()
    private let profileView = ProfileView()
    private let collection = SkillsCollectionView()
    private let descView = DescView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        setupUI()
        setupActions()
    }

    private func setupUI() {
        view.addSubview(topSpaceView)
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.delegate = self
        NSLayoutConstraint.activate([
            topSpaceView.topAnchor.constraint(equalTo: view.topAnchor),
            topSpaceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topSpaceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topSpaceView.heightAnchor.constraint(equalToConstant: view.frame.height/2),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
        ])
    }
    
    func setupActions() {
        collection.actionBlock = { [weak self] action in
            switch action {
            case .addSkill: self?.showAler()
            case .removeSkillOn(index: let index): print(index)
            }
        }
    }
    
    func showAler() {
        skills.append("123")
        collection.render(skills)
    }
    
}

// MARK: - UIScrollViewDelegate
extension ProfileViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 { scrollView.contentOffset = .init(x: 0, y: 0) }
    }
}
