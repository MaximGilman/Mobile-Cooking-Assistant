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
    
    static func make(ingredients: [Ingredient], shouldShowTitle: Bool = true) -> RecipeIngredientsView {
        let view = RecipeIngredientsView.loadFromNib()
        view.titleLabel.isHidden = !shouldShowTitle
        
        ingredients.forEach {
            let ingredientLabel = UILabel()
            ingredientLabel.text = "• " + $0.name
            ingredientLabel.textColor = .darkGray
            ingredientLabel.numberOfLines = 0
            view.stackView.addArrangedSubview(ingredientLabel)
        }
        
        return view
    }
}
