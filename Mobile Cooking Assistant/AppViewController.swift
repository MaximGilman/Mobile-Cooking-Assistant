//
//  AppViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit

final class AppViewController: UITabBarController {
    
    private var isAuthenticated = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = [catalog, myRecipes, timer, profile]
        
        if !isAuthenticated {

            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true)
            isAuthenticated = true
        }
    }
    
    private lazy var catalog: UINavigationController = {
        let catalogViewController = CatalogViewController()
        let defaultImage: UIImage = UIImage(imageLiteralResourceName: "Catalog")
        
        let tabBarItem = UITabBarItem(title: "Catalog", image: defaultImage, selectedImage: defaultImage)
        catalogViewController.tabBarItem = tabBarItem
        
        let navigationController = UINavigationController(rootViewController: catalogViewController)
        
        return navigationController
    }()
    
    private lazy var myRecipes: MyRecipesViewController = {
        let recipesViewController = MyRecipesViewController()
        let defaultImage: UIImage = UIImage(imageLiteralResourceName: "Timer")
        
        let tabBarItem = UITabBarItem(title: "My Recipes", image: defaultImage, selectedImage: defaultImage)
        recipesViewController.tabBarItem = tabBarItem
        
        return recipesViewController
    }()
    
    private lazy var timer: TimerViewController = {
        let timerViewController = TimerViewController()
        let defaultImage: UIImage = UIImage(imageLiteralResourceName: "Timer")
        
        let tabBarItem = UITabBarItem(title: "Timer", image: defaultImage, selectedImage: defaultImage)
        timerViewController.tabBarItem = tabBarItem
        
        return timerViewController
    }()
    
    private lazy var profile: ProfileViewController = {
        let profileViewController = ProfileViewController()
        let defaultImage: UIImage = UIImage(imageLiteralResourceName: "Profile")
        
        let tabBarItem = UITabBarItem(title: "Profile", image: defaultImage, selectedImage: defaultImage)
        profileViewController.tabBarItem = tabBarItem
        
        return profileViewController
    }()
}


extension AppViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
    
}
