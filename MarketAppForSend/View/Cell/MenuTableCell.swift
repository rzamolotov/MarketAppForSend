import UIKit

final class MenuTableCell: UITableViewCell {
    
    static let id = String(describing: MenuTableCell.self)
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceView = PriceView()
    private let menuImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = subviews.first?.frame.width

        for view in subviews where view != contentView {
            if view.frame.width == width {
                view.removeFromSuperview()
            }
        }
    }
}

extension MenuTableCell {
    
    func setData(_ data: FoodViewModel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.restaurantChain
        priceView.text = "\(data.id)"
    }
    
    func setImageData(_ data: Data) {
        menuImageView.image = UIImage(data: data)
    }
}

// MARK: - Config Appearance
private extension MenuTableCell {
    
    func configAppearance() {
        backgroundColor = .white
        selectionStyle = .none
        
        menuImageView.backgroundColor = .darkGray
        
        titleLabel.numberOfLines = 0
//        titleLabel.font = FontFamily.display(size: 17).name
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6784313725, alpha: 1)
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
    }
}

// MARK: - Make Constraints
private extension MenuTableCell {
    
    func makeConstraints() {
        menuImageViewConstraints()
        titleLabelConstraints()
        priceViewConstraints()
        descriptionLabelConstraints()
    }
    
    func menuImageViewConstraints() {
        contentView.addSubview(menuImageView)
        menuImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            menuImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            menuImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuImageView.widthAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    func titleLabelConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    func priceViewConstraints() {
        contentView.addSubview(priceView)
        priceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            priceView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            priceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            priceView.heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    
    func descriptionLabelConstraints() {
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: priceView.topAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: menuImageView.trailingAnchor, constant: 32),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
        ])
    }
}
