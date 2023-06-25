import UIKit

final class MenuCategoryCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: MenuCategoryCollectionCell.self)
    
    private let titleLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            isSelected(bool: oldValue)
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize,
                                          withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
                                          verticalFittingPriority: UILayoutPriority) -> CGSize {
        
        return CGSize(width: configCellWidth(),
                      height: targetSize.height)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDidNotSelect()
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuCategoryCollectionCell {
    
    func config(_ category: String) {
        self.titleLabel.text = category
    }
}

// MARK: - Logic
private extension MenuCategoryCollectionCell {
    
    func isSelected(bool: Bool) {
        switch isSelected {
        case true:
            cellDidSelect()
        case false:
            cellDidNotSelect()
        }
    }
    
    func cellDidSelect() {
        titleLabel.textColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: 13,
                                            weight: UIFont.Weight(700))
        
        backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).withAlphaComponent(0.2)
        
        layer.borderWidth = 0
    }
    
    func cellDidNotSelect() {
        backgroundColor = UIColor.white
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.withAlphaComponent(0.4).cgColor
        
        titleLabel.textColor = UIColor.red.withAlphaComponent(0.4)
    }
    
    func configCellWidth() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 13)
        let attributes = [NSAttributedString.Key.font : font as Any]
        
        return titleLabel.text!
            .size(withAttributes: attributes).width + 50
    }
}

// MARK: - Config Appearance
private extension MenuCategoryCollectionCell {
    
    func configAppearance() {
        layer.cornerRadius = 16
        
        titleLabel.textAlignment = .center
    }
}

// MARK: - Make Constraints
private extension MenuCategoryCollectionCell {
    
    func makeConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
