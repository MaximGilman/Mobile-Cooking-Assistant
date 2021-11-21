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
    let numberOfPortions: Int
    let photo: UIImage
    let steps: [Step]
    let ingredients: [Ingredient]
}

enum RecipeType: String {
    case lunch = "Lunch"
    case dessert = "Dessert"
    case breakfast = "Breakfast"
    case mainCourse = "Main Course"
    case salad = "Salad"
}
