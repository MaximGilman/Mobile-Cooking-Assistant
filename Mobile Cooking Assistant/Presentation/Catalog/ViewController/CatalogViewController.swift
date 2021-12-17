//
//  CatalogViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    @IBOutlet private var recipesCollectionView: UICollectionView!
    @IBOutlet private var categoriesCollectionView: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var recipes: [Recipe]?
    private var filteredRecipes: [Recipe] = []
    private var categories: [Category]?
    private var filteredCategories: [Category] = []
    
    private var searchUpdateTimer: Timer?
    private var isSearchBarEmpty: Bool { searchController.searchBar.text?.isEmpty != false }
    private var isFiltering: Bool { searchController.isActive && !isSearchBarEmpty }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViews()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for recipes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        loadRecipes()
        loadCategories()
    }
    
    @IBAction private func didTapOnViewAllRecipes(_ sender: Any) {
        viewAllRecipes()
    }
    
    @IBAction private func didTapOnViewAllCategories(_ sender: Any) {
        viewAllCategories()
    }
    
    private func viewAllRecipes() {
        let recipesController = RecipesViewController()
        navigationController?.pushViewController(recipesController, animated: true)
    }
    
    private func viewAllCategories() {
        let layout = UICollectionViewFlowLayout()
        let categoriesController = CategoriesViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(categoriesController, animated: true)
    }
    
    private func setupCollectionViews() {
        recipesCollectionView.register(UINib(nibName: RecipeCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecipeCell.identifier)
        recipesCollectionView.delegate = self
        recipesCollectionView.dataSource = self
        
        categoriesCollectionView.register(UINib(nibName: CategoryCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCell.identifier)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    private func loadRecipes() {
        ServiceLayer.shared.mockDataService.fetchRecipes { [weak self] recipes in
            self?.recipes = recipes
            self?.recipesCollectionView.reloadData()
        }
    }
    private func loadCategories() {
        ServiceLayer.shared.mockDataService.fetchCategories { [weak self] categories in
            self?.categories = categories
            self?.categoriesCollectionView.reloadData()
        }
    }
}

extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recipesCollectionView {
            if isFiltering { return filteredRecipes.count }
            return recipes?.count ?? 0
        }
        if isFiltering { return filteredCategories.count }
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recipesCollectionView,
           var currentRecipe = recipes?[indexPath.item] {
            if isFiltering { currentRecipe = filteredRecipes[indexPath.item] }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeCell.identifier, for: indexPath) as! RecipeCell
            
            cell.configure(with: currentRecipe)
            
            return cell
        }
        
        if collectionView == categoriesCollectionView,
           var currentCategory = categories?[indexPath.item] {
//            if isFiltering { currentCategory = filteredCategories[indexPath.item] }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            
            cell.configure(with: currentCategory)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? RecipeCell {
            cell.showAnimatedPress { [weak self] in
                guard let self = self else { return }
                var currentRecipe = self.recipes![indexPath.row]
                if self.isFiltering { currentRecipe = self.filteredRecipes[indexPath.item] }
                let detailsController = RecipeDetailsViewController(recipe: currentRecipe)
                self.navigationController?.pushViewController(detailsController, animated: true)
            }
        } else if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.showAnimatedPress { [weak self] in
                
            }
        }
    }
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recipesCollectionView {
            return CGSize(width: collectionView.frame.height * 148/108, height: collectionView.frame.height)
        }
        
        let cellWidth = collectionView.frame.width * 0.43
        return CGSize(width: cellWidth, height: cellWidth * 185/156)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

extension CatalogViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(by: searchController.searchBar.text!)
    }
    
    private func filterContent(by searchText: String) {
        searchUpdateTimer?.invalidate()
        searchUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.filteredRecipes = self.recipes!.filter {
                return $0.title.lowercased().contains(searchText.lowercased())
            }
            self.recipesCollectionView.performBatchUpdates({
                let indexSet = IndexSet(integersIn: 0...0)
                self.recipesCollectionView.reloadSections(indexSet)
            }, completion: nil)
        })
    }
}
