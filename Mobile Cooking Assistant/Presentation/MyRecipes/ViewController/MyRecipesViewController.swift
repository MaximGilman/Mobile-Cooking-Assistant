//
//  MyRecipesViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit

final class MyRecipesViewController: UIViewController {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var noCookingLabel: UILabel!
    
    private let cookingService = ServiceLayer.shared.cookingService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cooking now"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupData()
        setupTapRecognizer()
    }
    
    private func setupData() {
        containerView.makeRound(.specific(radius: 10))
        imageView.makeRound(.specific(radius: 10))
        containerView.setSlightShadow()
        
        imageView.image = cookingService.currentRecipe?.photo
        titleLabel.text = cookingService.currentRecipe?.title
        
        noCookingLabel.isHidden = cookingService.currentRecipe != nil
    }
    
    private func setupTapRecognizer() {
        let tapOnView = UITapGestureRecognizer(target: self, action: #selector(toCooking))
        tapOnView.cancelsTouchesInView = false
        containerView.addGestureRecognizer(tapOnView)
    }
    
    @objc private func toCooking() {
        let state = ServiceLayer.shared.cookingService.state
        let viewControler = CookingViewController(recipe: cookingService.currentRecipe!, lastState: state)
        viewControler.modalPresentationStyle = .fullScreen
        present(viewControler, animated: true, completion: nil)
    }
}
