import Foundation

struct FoodMenuSettings: Codable {
    let type: String?
    let menuItems: [MenuItem]?
}

struct MenuItem: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let restaurantChain: String?
}
