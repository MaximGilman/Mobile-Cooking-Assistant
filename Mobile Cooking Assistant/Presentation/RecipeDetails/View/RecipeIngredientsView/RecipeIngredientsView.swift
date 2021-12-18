//
//  RecipeIngredientsView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import Foundation
import UIKit

final class RecipeIngredientsView: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var stackView: UIStackView!
    
    private var ingredients: [Ingredient] = []
    
    static func make(ingredients: [Ingredient], portions: Int, shouldShowTitle: Bool = true) -> RecipeIngredientsView {
        let view = RecipeIngredientsView.loadFromNib()
        view.titleLabel.isHidden = !shouldShowTitle
        view.ingredients = ingredients
        
        ingredients.forEach {
            let ingredientLabel = UILabel()
            ingredientLabel.text = "• " + $0.name
            if portions > 1 {
                ingredientLabel.text = "x\(portions) " + ingredientLabel.text!
            }
            ingredientLabel.textColor = .darkGray
            ingredientLabel.numberOfLines = 0
            view.stackView.addArrangedSubview(ingredientLabel)
        }
        
        return view
    }
    
    func update(portions: Int) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        ingredients.forEach {
            let ingredientLabel = UILabel()
            ingredientLabel.text = "• " + $0.name
            if portions > 1 {
                ingredientLabel.text = "x\(portions) " + ingredientLabel.text!
            }
            ingredientLabel.textColor = .darkGray
            ingredientLabel.numberOfLines = 0
            stackView.addArrangedSubview(ingredientLabel)
        }
    }
}
