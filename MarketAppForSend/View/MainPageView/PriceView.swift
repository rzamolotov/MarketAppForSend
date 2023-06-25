import UIKit

final class PriceView: UIView {
    
    private let titleLabel = UILabel()
    
    var text: String? {
        get {
            nil
        }
        set {
            titleLabel.text = newValue! + " p"
        }
    }
    
    init() {
        super.init(frame: .zero)
        configAppearance()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension PriceView {
    
    func configAppearance() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1).cgColor
        layer.cornerRadius = 6
        
//        titleLabel.font = FontFamily.display(size: 13).name
        titleLabel.textAlignment = .center
        titleLabel.textColor = #colorLiteral(red: 0.9921568627, green: 0.2274509804, blue: 0.4117647059, alpha: 1)
    }
}

// MARK: - Make Constraints
private extension PriceView {
    
    func makeConstraints() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
        ])
    }
}
