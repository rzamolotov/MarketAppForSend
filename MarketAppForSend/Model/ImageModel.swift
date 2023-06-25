//
//  ImageModel.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 25.06.2023.
//

import UIKit

enum ImageFamily {
    case arrow
    case menu
    case contact
    case profile
    case cart
    case banner
    
    var name: UIImage? {
        switch self {
        case .arrow: return UIImage(named: "arrow")
        case .menu: return UIImage(named: "menu")
        case .contact: return UIImage(named: "contact")
        case .profile: return UIImage(named: "profile")
        case .cart: return UIImage(named: "cart")
        case .banner: return UIImage(named: "Banner")
        }
    }
}
