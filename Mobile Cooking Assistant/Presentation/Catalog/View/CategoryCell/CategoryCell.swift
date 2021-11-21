//
//  CategoryCollectionViewCell.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/11/21.
//

import UIKit

final class CategoryCell: UICollectionViewCell {

    @IBOutlet private var foodImageView: UIImageView!
    @IBOutlet private var titleContainerView: UIView!
    @IBOutlet private var categoryTitleLabel: UILabel!
    
    static let identifier = String(describing: CategoryCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleContainerView.roundParticularCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(with category: Category) {
        foodImageView.image = category.image
        categoryTitleLabel.text = category.title
        
        layoutIfNeeded()
        foodImageView.roundParticularCorners(corners: [.topLeft, .topRight], radius: 10)
        titleContainerView.roundParticularCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
        
        setSlightShadow()
    }
}
