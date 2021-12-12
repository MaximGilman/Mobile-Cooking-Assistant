//
//  RecipeDetailsHeaderView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/21/21.
//

import UIKit

final class RecipeDetailsHeaderView: UIView, NibLoadable {

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    
    static func make(recipe: Recipe) -> RecipeDetailsHeaderView {
        let view = RecipeDetailsHeaderView.loadFromNib()
        view.imageView.image = recipe.photo
        view.titleLabel.text = recipe.title
        
        return view
    }
    
    @IBAction private func onLikeButtonTapped(_ sender: Any) {
        
    }
    
}
