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
        let recipe1 = Recipe(id: 1, title: "Shrimp Soup", type: .lunch, note: "", numberOfPortions: 1, photo: .init(imageLiteralResourceName: "ShrimpSoup"), steps: [])
        
        let recipe2 = Recipe(id: 2, title: "Coconut Ice Cream", type: .dessert, note: "", numberOfPortions: 5, photo: .init(imageLiteralResourceName: "CoconutIceCream"), steps: [])
        
        let recipe3 = Recipe(id: 3,
                             title: "Fish & Chips",
                             type: .lunch, note: "",
                             numberOfPortions: 2,
                             photo: .init(imageLiteralResourceName: "FishAndChips"),
                             steps: [.init(id: 1, title: "1. Preparation", body: "Heat oven to 180C. Line the base and sides of a 23cm springform tin with baking parchment.",
                                           ingredients: [.init(id: 1, name: "200g/7oz almond biscuits"),
                                                         .init(id: 2, name: "100g toasted flaked almond"),
                                                         .init(id: 3, name: "½ tsp almond extract"),
                                                         .init(id: 4, name: " 100g butter , melted")]),
                                     .init(id: 2, title: "2. Making the base", body: "Bash the biscuits and 75g of the flaked almonds to crumbs. Mix with the almond extract and melted butter, then press into the base of the prepared tin and bake for 10 mins. Set aside to cool while you make the filling.",
                                           ingredients: [.init(id: 5, name: "3 x 300g packs full-fat soft cheese"),
                                                         .init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 3, title: "3. Making the filling", body: "In your largest bowl, whisk the cheese with an electric whisk until creamy. Add the sugar and whisk to combine. Whisk in the flour, then the vanilla, the eggs, one at a time, and finally the soured cream.",
                                           ingredients: [.init(id: 5, name: "3 x 300g packs full-fat soft cheese"),
                                                         .init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 4, title: "4. Laying down the filling", body: "Dollop spoonfuls of mixture into the tin, dotting in tbsps of jam as you go. Smooth the top as gently as you can.",
                                           ingredients: [.init(id: 6, name: " 250g caster sugar"),
                                                         .init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 5, title: "5. Baking the cake", body: "Carefully place tin on the middle shelf of the oven and bake for 10 mins. Scatter with remaining almonds. Decrease oven to 110C/90C fan/gas ¼ and bake for a further 35 mins.",
                                           ingredients: [.init(id: 7, name: " 4 tbsp plain flour"),
                                                         .init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 6, title: "6. Cooling the cake", body: "Turn off the oven, keep the door closed and leave cheesecake to cool for 1 hr. Open oven door and leave it ajar for another hour (you can use your oven gloves to wedge it open). Cool for a third hour at room temp, then cover and chill overnight.",
                                           ingredients: [.init(id: 8, name: "1 tsp vanilla extracte")]),
                                     .init(id: 7, title: "7. Serving the cake", body: "Remove from the tin and carefully peel off the parchment. Dust with icing sugar and serve with cream.",
                                           ingredients: [])])
        
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
