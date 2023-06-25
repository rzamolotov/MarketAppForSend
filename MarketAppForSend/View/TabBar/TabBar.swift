//
//  TabBar.swift
//  MarketAppForSend
//
//  Created by Роман Замолотов on 24.06.2023.
//

import UIKit

final class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createMenuViewController(),
                           createContactViewController(),
                           createProfileViewController(),
                           createCartViewController()]
        
        tabBar.tintColor = .red
        tabBar.backgroundColor = .white
    }
}

private extension TabBar {
    
    func createMenuViewController() -> UIViewController {
        let vc = MenuAssembly.build()
        let image = ImageFamily.menu.name
        vc.tabBarItem = UITabBarItem(title: "Меню",
                                     image: image,
                                     tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createContactViewController() -> UIViewController {
        let vc = UIViewController()
        let image = ImageFamily.contact.name
        vc.tabBarItem = UITabBarItem(title: "Контакты",
                                     image: image,
                                     tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createProfileViewController() -> UIViewController {
        let vc = UIViewController()
        let image = ImageFamily.profile.name
        vc.tabBarItem = UITabBarItem(title: "Профиль",
                                     image: image,
                                     tag: 2)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createCartViewController() -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        let image = ImageFamily.cart.name
        vc.tabBarItem = UITabBarItem(title: "Корзина",
                                     image: image,
                                     tag: 3)
        
        return UINavigationController(rootViewController: vc)
    }
}

class MenuAssembly {
    
    static func build() -> UIViewController {
        
        let network = NetworkService()
        let interactor = MenuInteractor(network: network)
        let presenter = MenuPresenter(interactor: interactor)
        let controller = ViewController(presenter: presenter)
        
        return controller
    }
}
