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
    @IBOutlet private var ingredientsLabel: UILabel!
    @IBOutlet private var ingredientsView: UIView!
    @IBOutlet private var portionsNumberButton: UIButton!
    
    private var recipeIngredientsView: RecipeIngredientsView!
    
    private let step: Step
    private var numberOfPortions: Int = 1
    
    init(step: Step, numberOfPortions: Int) {
        self.step = step
        self.numberOfPortions = numberOfPortions
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
        portionsNumberButton.setTitle(String(numberOfPortions), for: .normal)
    }

    @IBAction private func didTapPortionsButton(_ sender: Any) {
        let portionsViewController = ChangePortionsViewController(delegate: self)
        portionsViewController.modalPresentationStyle = .overFullScreen
        present(portionsViewController, animated: true)
    }
    
    private func setupIngrevientsViewIfNeeded() {
        guard step.ingredients.count > 0 else {
            ingredientsLabel.isHidden = true
            return
        }
        let view = RecipeIngredientsView.make(ingredients: step.ingredients, portions: numberOfPortions, shouldShowTitle: false)
        recipeIngredientsView = view
        ingredientsView.addSubview(view)
        view.snp.makeConstraints { make in
            make.trailing.equalTo(ingredientsView.snp.trailing)
            make.leading.equalTo(ingredientsView.snp.leading)
            make.top.equalTo(ingredientsView.snp.top)
            make.bottom.equalTo(ingredientsView.snp.bottom)
        }
    }
}

extension StepViewController: RecipePortionsViewDelegate {
    func didChangePortionsValue(value: Int) {
        portionsNumberButton.setTitle(String(value), for: .normal)
        recipeIngredientsView.update(portions: value)
    }
}
