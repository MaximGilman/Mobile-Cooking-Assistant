//
//  StepViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 12/6/21.
//

import UIKit
import SnapKit

final class StepViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet private var ingredientsView: UIView!
    
    private let step: Step
    
    init(step: Step) {
        self.step = step
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = step.title
        bodyLabel.text = step.body
        
        setupIngrevientsViewIfNeeded()
    }

    private func setupIngrevientsViewIfNeeded() {
        guard step.ingredients.count > 0 else { return }
        let view = RecipeIngredientsView.make(ingredients: step.ingredients, shouldShowTitle: false)
        ingredientsView.addSubview(view)
        view.snp.makeConstraints { make in
            make.trailing.equalTo(ingredientsView.snp.trailing)
            make.leading.equalTo(ingredientsView.snp.leading)
            make.top.equalTo(ingredientsView.snp.top)
            make.bottom.equalTo(ingredientsView.snp.bottom)
        }
    }
}
