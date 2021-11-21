//
//  RecipeCell.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import UIKit

final class RecipeCell: UICollectionViewCell {
    
    @IBOutlet private var dishImageView: UIImageView!
    @IBOutlet private var dimmingView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var lunchLabel: UILabel!
    @IBOutlet private var cookingTimeLabel: UILabel!
    
    static let identifier = String(describing: RecipeCell.self)
    
    func configure(with recipe: Recipe) {
        dishImageView.image = recipe.photo
        titleLabel.text = recipe.title
        lunchLabel.text = recipe.type.rawValue
        
        dishImageView.layer.cornerRadius = 20
        dimmingView.layer.cornerRadius = 20
    }

}
