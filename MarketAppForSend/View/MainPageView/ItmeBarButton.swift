//
//  ItmeBarButton.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 24.06.2023.
//

import UIKit

final class ItemBarButtonView: UIView {
    
    private let title = UILabel()
    private let imageView = UIImageView()
    
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
private extension ItemBarButtonView {
    
    func configAppearance() {
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.contentMode = .scaleAspectFill
        
        title.text = "Москва"
        title.textColor = .black
        title.font = .systemFont(ofSize: 17, weight: .medium)
    }
}

// MARK: - Make Constraints
private extension ItemBarButtonView {
    
    func makeConstraints() {
        addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 8),
            imageView.heightAnchor.constraint(equalToConstant: 8),
            imageView.widthAnchor.constraint(equalToConstant: 14),
        ])
    }
}
