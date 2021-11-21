//
//  FullRecipeCell.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/26/21.
//

import UIKit

final class FullRecipeCell: UITableViewCell {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var dishImageView: UIImageView!
    
    static let identifier = String(describing: FullRecipeCell.self)
    
    func configure(with recipe: Recipe) {
        dishImageView.image = recipe.photo
        titleLabel.text = recipe.title
        titleLabel.text = recipe.type.rawValue
        
        containerView.setSlightShadow()
        dishImageView.makeRound(.specific(radius: 20))
        contentView.makeRound(.specific(radius: 20))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
}
