//
//  Recipe.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import Foundation
import UIKit

struct Recipe {
    let id: Int
    let title: String
    let type: RecipeType
    let note: String
    var numberOfPortions: Int
    let photo: UIImage
    let steps: [Step]
    
    var ingredients: [Ingredient] {
        var result: [Ingredient] = []
        
        steps.forEach {
            result.append(contentsOf: $0.ingredients)
        }
        return Array(Set(result))
    }
}

enum RecipeType: String {
    case lunch = "Lunch"
    case dessert = "Dessert"
    case breakfast = "Breakfast"
    case mainCourse = "Main Course"
    case salad = "Salad"
}
