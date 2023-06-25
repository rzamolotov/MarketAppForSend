//
//  ViewController.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 22.06.2023.
//

import UIKit

protocol ItemViewController: AnyObject {
    func reloadData()
    func scrollTo(row: Int, section: Int)
    func didScroll(state: ScrollState)
}

final class ViewController: UIViewController {
    
    private lazy var mainView = MenuView(sections: presenter.sections)
    private let leftBarButtonView = ItemBarButtonView()
    
    private let presenter: IMenuPresenter
    
    init(presenter: IMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(controller: self)
        configAppearance()
    }
}

extension ViewController: ItemViewController {
    
    func scrollTo(row: Int, section: Int) {
        mainView.scrollTo(row: row, section: section)
    }
    
    func reloadData() {
        mainView.reloadData()
    }
    
    func didScroll(state: ScrollState) {
        mainView.didScroll(state: state)
    }
}

// MARK: - TableView Delegate & DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        170
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter.didScroll(scrollView.contentOffset.y)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        HeaderView()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableCell.id,
                                                       for: indexPath) as? MenuTableCell
        else { return UITableViewCell() }
        
        let food = presenter.getFoodByIndex(indexPath.row)
        
        presenter.loadImageData(food.image) { data in
            cell.setImageData(data)
        }
        
        cell.setData(food)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView Delegate & DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        presenter.sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch presenter.sections[indexPath.section] {
            
        case .ads: break
        case .category(let array):
            collectionView.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
            presenter.didSelectCategory(array[indexPath.item].rawValue)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch presenter.sections[indexPath.section] {
        case .ads:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuAdsCollectionCell.id, for: indexPath) as? MenuAdsCollectionCell
            else { return UICollectionViewCell() }
            
            return cell
        case .category(let array):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCategoryCollectionCell.id, for: indexPath) as? MenuCategoryCollectionCell
            else { return UICollectionViewCell() }
            
            let category = array[indexPath.row].rawValue
            cell.config(category)
            
            return cell
        }
    }
}

// MARK: - Config Appearance
private extension ViewController {
    
    func configAppearance() {
        mainView.tableViewDelegate = self
        mainView.tableViewDataSource = self
        
        mainView.collectionViewDelegate = self
        mainView.collectionViewDataSource = self
        
        let item = UIBarButtonItem(customView: leftBarButtonView)
        navigationItem.leftBarButtonItem = item
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(),
                                                               for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}


