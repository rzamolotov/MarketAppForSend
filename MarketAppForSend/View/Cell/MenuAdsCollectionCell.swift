import UIKit

final class MenuAdsCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: MenuAdsCollectionCell.self)
    
    private let adsImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension MenuAdsCollectionCell {
    
    func configAppearance() {
        adsImageView.image = ImageFamily.banner.name
        adsImageView.layer.cornerRadius = 20
        adsImageView.contentMode = .scaleAspectFill
        adsImageView.clipsToBounds = true
    }
}

// MARK: - Make Constraints
private extension MenuAdsCollectionCell {
    
    func makeConstraints() {
        addSubview(adsImageView)
        adsImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            adsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            adsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            adsImageView.topAnchor.constraint(equalTo: topAnchor),
            adsImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
