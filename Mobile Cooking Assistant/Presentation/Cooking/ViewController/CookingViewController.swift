//
//  CookingViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 12/6/21.
//

import UIKit

final class CookingViewController: UIPageViewController {
    
    private var previousButton: UIButton!
    private var nextButton: UIButton!
    
    private var navigationBar: UINavigationBar!
    
    private let recipe: Recipe
    private var portions: Int = 1
    private let cookingService: CookingService
    private var cookingState: CookingState?
    
    private var currentIndex = 0
    
    private var finishedCooking = false
    
    private lazy var stepViewControllers: [StepViewController] = {
        recipe.steps.map { StepViewController(step: $0, numberOfPortions: portions) }
    }()
    
    init(recipe: Recipe, lastState: CookingState? = nil, cookingService: CookingService = ServiceLayer.shared.cookingService) {
        self.recipe = recipe
        self.portions = recipe.numberOfPortions
        self.cookingService = cookingService
        self.cookingState = lastState
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = recipe.title
        
        dataSource = self
        delegate = self
        
        if cookingService.currentRecipe?.id == recipe.id {
            let indexOfLastState = recipe.steps.firstIndex(where: { $0.id == cookingState?.lastStep?.id }) ?? 0
            currentIndex = indexOfLastState
            setViewControllers([stepViewControllers[indexOfLastState]], direction: .forward, animated: false)
        } else {
            cookingService.saveLastState(nil, recipe: nil)
            setViewControllers([stepViewControllers[0]], direction: .forward, animated: false)
        }
        setupNavigationBar()
        setupMenu()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !finishedCooking {
            cookingService.saveLastState(.init(lastStep: recipe.steps[currentIndex], lastPortions: portions), recipe: recipe)
        }
    }
    
    private func setupNavigationBar() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 40, width: view.frame.size.width, height: 44))
        navigationBar.isTranslucent = false
        
        view.addSubview(navigationBar)

        let navItem = UINavigationItem(title: recipe.title)
        let dismissItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(dismissAction))
        dismissItem.image = UIImage(systemName: "chevron.down")
        dismissItem.tintColor = .black
        navItem.leftBarButtonItem = dismissItem

        navigationBar.setItems([navItem], animated: false)
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupMenu() {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        if currentIndex == recipe.steps.count - 1 {
            nextButton.setTitle("Finish", for: .normal)
        }
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.backgroundColor = .white
        nextButton.makeRound(.specific(radius: 10))
        nextButton.setSlightShadow()
        nextButton.addTarget(self, action: #selector(nextDidTap), for: .touchUpInside)
        
        previousButton = UIButton()
        previousButton.setTitle("Previous", for: .normal)
        previousButton.setTitleColor(.black, for: .normal)
        previousButton.backgroundColor = .white
        previousButton.isHidden = currentIndex == 0
        previousButton.makeRound(.specific(radius: 10))
        previousButton.setSlightShadow()
        previousButton.addTarget(self, action: #selector(previousDidTap), for: .touchUpInside)
        stack.addArrangedSubview(previousButton)
        stack.addArrangedSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(view.frame.width*0.3)
        }
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(100)
            make.width.equalTo(view.snp.width).multipliedBy(0.7)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    @objc private func previousDidTap(_ sender: Any) {
        previousButton.showAnimatedPress(overAllDuration: 0.2) { [ weak self] in
            guard let self = self else { return }
            self.goToPreviousPage()
            if self.currentIndex == 0 {
                self.previousButton.isHidden = true
            }
            if self.currentIndex != self.recipe.steps.count - 1 {
                self.nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    @objc private func nextDidTap(_ sender: Any) {
        if currentIndex == self.recipe.steps.count - 1 {
            cookingService.saveLastState(nil, recipe: nil)
            finishedCooking = true
            dismiss(animated: true)
//            navigationController?.popViewController(animated: true)
        }
        nextButton.showAnimatedPress(overAllDuration: 0.2) { [ weak self] in
            guard let self = self else { return }
            self.goToNextPage()
            if self.currentIndex != 0 {
                self.previousButton.isHidden = false
            }
            if self.currentIndex == self.recipe.steps.count - 1 {
                self.nextButton.setTitle("Finish", for: .normal)
            }
        }
    }
}

extension CookingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard currentIndex != 0 else { return nil }
        currentIndex -= 1
        return stepViewControllers[currentIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard currentIndex != stepViewControllers.count - 1 else { return nil }
        currentIndex += 1
        return stepViewControllers[currentIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return stepViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController!) -> Int {
        return 0
    }
}

extension UIPageViewController {

    @objc func goToNextPage() {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
       setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
    }

    @objc func goToPreviousPage() {
       guard let currentViewController = self.viewControllers?.first else { return }
       guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
       setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)
    }

}
