//
//  RecipeDetailsHeaderView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/21/21.
//

import UIKit

final class RecipeDetailsHeaderView: UIView, NibLoadable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    static func make() -> RecipeDetailsHeaderView {
        let view = RecipeDetailsHeaderView.loadFromNib()
        
        return view
    }
    
    @IBAction private func onLikeButtonTapped(_ sender: Any) {
    }
    
}
