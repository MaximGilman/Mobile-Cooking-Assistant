//
//  RecipeStepView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import Foundation
import UIKit

final class RecipeStepView: UIView, NibLoadable {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    
    static func make(step: Step) -> RecipeStepView {
        let view = RecipeStepView.loadFromNib()
        view.titleLabel.text = step.title
        view.bodyLabel.text = step.body
        
        return view
    }
}
