//
//  AppViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import UIKit

final class AppViewController: UITabBarController {
    
    private var isAuthenticated = false
    
    let sl :ServiceLayer
    
    init(sl: ServiceLayer = ServiceLayer.shared) {
        self.sl = sl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewControllers = [catalog, myRecipes, timer, profile]
        
//        UserDefaults.standard.set(false, forKey: "isAuth")
        isAuthenticated = UserDefaults.standard.bool(forKey: "isAuth")
        if !isAuthenticated {

            let loginViewController = LoginViewController()
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true)
            isAuthenticated = true
        }
        else{
            let login = UserDefaults.standard.string(forKey: "login") as! String
            let password = UserDefaults.standard.string(forKey: "password") as! String

            let user = sl.loginService.logIn(login: login, password: password) {[weak self] errorMsg, userP in
                self?.sl.user = userP as! User
            }
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
