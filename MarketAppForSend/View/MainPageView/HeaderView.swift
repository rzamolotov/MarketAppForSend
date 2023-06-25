//
//  HeaderView.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 24.06.2023.
//

import UIKit

final class HeaderView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        clipsToBounds = true
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
