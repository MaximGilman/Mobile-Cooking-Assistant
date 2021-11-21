//
//  MockDataService.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import Foundation
import UIKit

protocol MockDataService: AnyObject {
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void)
    func fetchCategories(completion: @escaping ([Category]) -> Void)
}

final class BaseMockDataService: MockDataService {
    func fetchRecipes(completion: @escaping ([Recipe]) -> Void) {
        let recipe1 = Recipe(id: 1, title: "Shrimp Soup", type: .lunch, note: "", numberOfPortions: 1, photo: .init(imageLiteralResourceName: "ShrimpSoup"), steps: [], ingredients: [])
        
        let recipe2 = Recipe(id: 2, title: "Coconut Ice Cream", type: .dessert, note: "", numberOfPortions: 5, photo: .init(imageLiteralResourceName: "CoconutIceCream"), steps: [], ingredients: [])
        
        let recipe3 = Recipe(id: 3, title: "Fish & Chips", type: .lunch, note: "", numberOfPortions: 2, photo: .init(imageLiteralResourceName: "FishAndChips"), steps: [], ingredients: [])
        
        completion([recipe1, recipe2, recipe3])
    }
    
    func fetchCategories(completion: @escaping ([Category]) -> Void) {
        let category1 = Category(id: 1, title: "Breakfast", image: .init(imageLiteralResourceName: "Breakfast"), recipes: [])
        let category2 = Category(id: 2, title: "Dessert", image: .init(imageLiteralResourceName: "Dessert"), recipes: [])
        let category3 = Category(id: 3, title: "Main course", image: .init(imageLiteralResourceName: "MainCourse"), recipes: [])
        let category4 = Category(id: 4, title: "Salads", image: .init(imageLiteralResourceName: "Salads"), recipes: [])
        
        completion([category1, category2, category3, category4])
    }
}
