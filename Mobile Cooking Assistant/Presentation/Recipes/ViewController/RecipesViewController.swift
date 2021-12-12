//
//  RecipesViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/26/21.
//

import UIKit

final class RecipesViewController: UITableViewController {
    
    private var recipes: [Recipe] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Recipes for today"
        
        tableView.register(UINib(nibName: FullRecipeCell.identifier, bundle: nil), forCellReuseIdentifier: FullRecipeCell.identifier)
        ServiceLayer.shared.mockDataService.fetchRecipes { [weak self] recipes in
            self?.recipes = recipes
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentRecipe = recipes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FullRecipeCell.identifier, for: indexPath) as! FullRecipeCell
        cell.selectionStyle = .none
        cell.configure(with: currentRecipe)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? FullRecipeCell {
            cell.showAnimatedPress { [weak self] in
                guard let self = self else { return }
                let currentRecipe = self.recipes[indexPath.row]
                let detailsController = RecipeDetailsViewController(recipe: currentRecipe)
                self.navigationController?.pushViewController(detailsController, animated: true)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
