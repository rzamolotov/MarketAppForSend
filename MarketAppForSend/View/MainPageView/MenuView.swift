//
//  MenuView.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 24.06.2023.
//

import UIKit

enum ScrollState {
    case up
    case down
}

final class MenuView: UIView {
    
    private let sections: [ListSections]
    
    private var topTableConstraint = NSLayoutConstraint()
    private var estimated: CGFloat = 1
    private var bottomHeight: CGFloat = 24
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: createLayout())
    
    var collectionViewDelegate: UICollectionViewDelegate? {
        get {
            nil
        }
        set {
            self.collectionView.delegate = newValue
        }
    }
    
    var collectionViewDataSource: UICollectionViewDataSource? {
        get {
            nil
        }
        set {
            self.collectionView.dataSource = newValue
        }
    }
    
    var tableViewDelegate: UITableViewDelegate? {
        get {
            nil
        }
        set {
            self.tableView.delegate = newValue
        }
    }
    
    var tableViewDataSource: UITableViewDataSource? {
        get {
            nil
        }
        set {
            self.tableView.dataSource = newValue
        }
    }
    
    init(sections: [ListSections]) {
        self.sections = sections
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuView {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func scrollTo(row: Int, section: Int) {
        tableView.scrollToRow(at: IndexPath(row: row, section: section),
                              at: .top,
                              animated: true)
    }
    
    func didScroll(state: ScrollState) {
        switch state {
        case .up:
            UIView.animate(withDuration: 0.5) {
                self.topTableConstraint.constant = -132
                self.estimated = 0
                self.bottomHeight = 0
                self.collectionView.reloadSections(IndexSet(integer: 0))
                self.layoutIfNeeded()
            }
        case .down:
            UIView.animate(withDuration: 0.5) {
                self.topTableConstraint.constant = 0
                self.estimated = 1
                self.bottomHeight = 24
                self.collectionView.reloadSections(IndexSet(integer: 0))
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: - Config Appearance
private extension MenuView {
    
    func configAppearance() {
        configView()
        configTableView()
        configCollectionView()
    }
    
    func configView() {
        backgroundColor = #colorLiteral(red: 0.9623988271, green: 0.9691058993, blue: 0.981377542, alpha: 1)
    }
    
    func configTableView() {
        tableView.backgroundColor = .clear
        tableView.register(MenuTableCell.self,
                           forCellReuseIdentifier: MenuTableCell.id)
    }
    
    func configCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.9623988271, green: 0.9691058993, blue: 0.981377542, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuAdsCollectionCell.self,
                                forCellWithReuseIdentifier: MenuAdsCollectionCell.id)
        collectionView.register(MenuCategoryCollectionCell.self,
                                forCellWithReuseIdentifier: MenuCategoryCollectionCell.id)
    }
}

// MARK: - Make Constraints
private extension MenuView {
    
    func makeConstraints() {
        collectionViewConstraints()
        tableViewConstraints()
    }
    
    func collectionViewConstraints() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 192)
        ])
    }
    
    func tableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        topTableConstraint = tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor)
        topTableConstraint.isActive = true
    }
}

// MARK: - Make Compositional Layout
private extension MenuView {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.sections[sectionIndex] {
            case .ads:
                return self.createAdsSection()
            case .category(_):
                return self.createCategorySection()
            }
        }
        
        return layout
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(1),
                                              heightDimension: .absolute(32))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: itemSize.widthDimension,
                                               heightDimension: itemSize.heightDimension)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 8
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = .init(top: 0,
                                      leading: 16,
                                      bottom: 24,
                                      trailing: 16)
        
        return section
    }
    
    func createAdsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(112))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                               heightDimension: .estimated(estimated))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.interGroupSpacing = 16
        
        section.contentInsets = .init(top: 0,
                                      leading: 16,
                                      bottom: bottomHeight,
                                      trailing: 16)
        return section
    }
}
