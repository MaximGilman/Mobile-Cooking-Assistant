//
//  RecipeDetailsViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/21/21.
//

import UIKit
import SnapKit

final class RecipeDetailsViewController: ScrollableViewController {
    
    private let previewHeight: CGFloat = 100
    
    private var headerView: RecipeDetailsHeaderView!
    private var mainContainerView: UIView!
    private var portionsView: RecipePortionsView!
    private var ingredientsView: RecipeIngredientsView!
    private var stepsStackView: UIStackView!
    
    private var recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeader()
        setupMainContainerView()
        setupPortionsView()
        setupIngredientStack()
        setupStepsStack()
        setupCookButton()
    }
    
    private func setupHeader() {
        headerView = RecipeDetailsHeaderView.make(recipe: recipe)
        
        scrollView.addSubview(headerView)
        headerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(90)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).inset(0)
        }
    }
    
    private func setupMainContainerView() {
        mainContainerView = UIView()
        mainContainerView.backgroundColor = .white
        
        scrollView.addSubview(mainContainerView)
        mainContainerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(scrollView.snp.top).offset(200)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).inset(0)
            make.bottom.equalTo(scrollView.snp.bottom).offset(100)
        }
        mainContainerView.makeRound(.specific(radius:20))
        mainContainerView.setSlightShadow()
    }
    
    private func setupPortionsView() {
        portionsView = RecipePortionsView.make(delegate: self)
        
        mainContainerView.addSubview(portionsView)
        portionsView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mainContainerView.snp.top).offset(10)
            make.leading.equalTo(view.snp.leading).offset(10)
            make.trailing.equalTo(view.snp.trailing).inset(10)
        }
    }
    
    private func setupIngredientStack() {
        ingredientsView = RecipeIngredientsView.make(ingredients: recipe.ingredients, portions: recipe.numberOfPortions)
        
        mainContainerView.addSubview(ingredientsView)
        ingredientsView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(portionsView.snp.bottom).offset(10)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
        }
    }
    
    private func setupStepsStack() {
        stepsStackView = UIStackView()
        stepsStackView.axis = .vertical
        stepsStackView.distribution = .fillProportionally
        stepsStackView.spacing = 20
        
        mainContainerView.addSubview(stepsStackView)
        view.layoutIfNeeded()
        
        stepsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(ingredientsView.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).inset(20)
        }
        recipe.steps.forEach {
            stepsStackView.addArrangedSubview(RecipeStepView.make(step: $0))
        }
    }
    
    private func setupCookButton() {
        let cookButton = UIButton()
        cookButton.backgroundColor = .white
        cookButton.setTitleColor(.black, for: .normal)
        cookButton.setTitle("Cook", for: .normal)
        cookButton.addTarget(self, action: #selector(toCooking), for: .touchUpInside)
        
        mainContainerView.addSubview(cookButton)
        cookButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(130)
            make.top.equalTo(stepsStackView.snp.bottom).offset(20)
            make.centerX.equalTo(mainContainerView.snp.centerX)
            make.bottom.equalTo(scrollView.snp.bottom).inset(40)
        }
        cookButton.setSlightShadow()
        cookButton.makeRound(.specific(radius: 20))
    }
    
    @objc private func toCooking() {
        let state = ServiceLayer.shared.cookingService.state
        recipe.numberOfPortions = portionsView.currentNumberOfPortions
        let viewControler = CookingViewController(recipe: recipe, lastState: state)
        viewControler.modalPresentationStyle = .fullScreen
        present(viewControler, animated: true)
    }
    
    private func setupLikeButton() {
        let likeButton = UIButton()
        likeButton.backgroundColor = .red
        likeButton.tintColor = .darkGray
        
        mainContainerView.addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(130)
            make.top.equalTo(stepsStackView.snp.bottom).offset(20)
            make.centerX.equalTo(mainContainerView.snp.centerX)
            make.bottom.equalTo(scrollView.snp.bottom).inset(40)
        }
        likeButton.makeRound(.complete)
    }
}

extension RecipeDetailsViewController: RecipePortionsViewDelegate {
    
    func didChangePortionsValue(value: Int) {
        recipe.numberOfPortions = value
        ingredientsView.update(portions: value)
    }
}
