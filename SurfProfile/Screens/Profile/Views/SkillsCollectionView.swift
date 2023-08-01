//
//  SkillsCollectionView.swift
//  SurfProfile
//
//  Created by Pavel Razumov on 01.08.2023.
//

import UIKit
typealias VoidBlock = () -> Void

final class SkillsCollectionView: View {
    enum ActionType {
        case removeSkillOn(index: Int)
        case addSkill
    }
    
    var isEditing = false {
        didSet {
            renderState()
        }
    }
    
    private var items: [String] = [] {
        didSet {
            collection.reloadData()
            collection.layoutIfNeeded()
        }
    }
    
    var actionBlock: ((ActionType) -> Void)?
    
    private let headerView = HeaderForCollection()
    private lazy var stackView = UIStackView(axis: .vertical, arrangedSubviews: [headerView, collection]).withConstraints()
    
    private lazy var collection: ContentSizedCollectionView = {
        
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = ContentSizedCollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.dataSource = self
        collection.isScrollEnabled = false
        collection.register(SkillCell.self)
        collection.register(AddSkillCell.self)
        return collection
    }()
    
    override func setupView() {
        addSubview(stackView)
        backgroundColor = .white
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
//        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(didTap))
//        collection.addGestureRecognizer(longTap)
        
        setupActions()
    }
    
    func renderState() {
        collection.reloadData()
        headerView.renderState(isEditing)
    }
    
    func setupActions() {
        headerView.didTapButton = { [weak self] in
            self?.isEditing.toggle()
        }
    }
    
    func render(_ items: [String]) {
        self.items = items
    }
    
    @objc private func didTap(_ gesture: UILongPressGestureRecognizer) {
        
        let location = gesture.location(in: collection)
    
        
        switch gesture.state {
        case .began:
            
            guard let index = collection.indexPathForItem(at: location) else { return }
            collection.beginInteractiveMovementForItem(at: index)
        case .changed: collection.updateInteractiveMovementTargetPosition(location)
        case .ended: collection.endInteractiveMovement()
        default: collection.cancelInteractiveMovement()
        }
        
    }
}

extension SkillsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        !isEditing ? items.count : items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEditing, indexPath.row == items.count {
            let cell: AddSkillCell = collectionView.dequeueCell(indexPath)
            cell.didTapPlus = { [weak self] in
                self?.actionBlock?(.addSkill)
            }
            return cell
        }
        
        let cell: SkillCell = collectionView.dequeueCell(indexPath)
        cell.render(items[indexPath.row], isEditing: isEditing)
        cell.didTapRemove = { [weak self] in
            self?.actionBlock?(.removeSkillOn(index: indexPath.row))
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let item = items.remove(at: sourceIndexPath.row)
//        items.insert(item, at: destinationIndexPath.row)
//    }
    
}


final class SkillCell: CollectionCell {
    
    private lazy var stackView = UIStackView(axis: .horizontal, spacing: 10, arrangedSubviews: [label, removeButton]).withConstraints()

    var didTapRemove: VoidBlock?
    
    let label = UILabel().withConstraints()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button.withConstraints()
    }()
    
    override func setUp() {
        addSubview(stackView)
        layer.cornerRadius = 12
        stackView.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        stackView.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)

        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width-32)
        ])
    }
    
    func render(_ text: String, isEditing: Bool) {
        removeButton.isHidden = !isEditing
        label.text = text
        
        layoutIfNeeded()
    }
    
    @objc func tapButton() {
        didTapRemove?()
    }

}

final class AddSkillCell: CollectionCell {
    
    let label = UILabel().withConstraints()
    
    var didTapPlus: VoidBlock?
    
    override func setUp() {
        
        label.text = "+"
        
        contentView.addSubview(label)
        layer.cornerRadius = 12
    
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    @objc private func didTap() {
        didTapPlus?()
    }
}

final class HeaderForCollection: View {
    
    private lazy var stackView = UIStackView(axis: .horizontal, arrangedSubviews: [textlabel, button]).withConstraints()
    var didTapButton: VoidBlock?
    
    private lazy var textlabel: UILabel = {
        let label = UILabel()
        label.text = "My skills"
        return label.withConstraints()
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "swift"), for: .normal)
        button.addTarget(self, action: #selector(didTapEditingButton), for: .touchUpInside)
        return button.withConstraints()
    }()
 
    override func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 40),
            
//            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func renderState(_ isEditing: Bool) {
        button.setImage(isEditing ? UIImage(systemName: "checkmark") : UIImage(systemName: "swift"), for: .normal)
    }
    
    @objc private func didTapEditingButton() {
        didTapButton?()
    }
    
}
