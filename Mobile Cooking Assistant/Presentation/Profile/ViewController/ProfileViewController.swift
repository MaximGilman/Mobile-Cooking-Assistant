//
//  ProfileViewController.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {

    @IBOutlet private var achivementsContainerView: UIView!
    @IBOutlet private var logoutButton: UIButton!
    
    @IBOutlet var UserNameLabel: UILabel!
    private var sl: ServiceLayer

    init(sl: ServiceLayer = ServiceLayer.shared) {
        self.sl = sl
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = sl.user
        let nname = user.name
        UserNameLabel?.text = nname
        setupAchivements()
        logoutButton.makeRound(.complete)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let user = sl.user
        let nname = user.name
        UserNameLabel?.text = nname
        setupAchivements()
        logoutButton.makeRound(.complete)
    }
    
    private func setupAchivements() {
        let achivementsView = ProfileAchievementsView.make()
        
        achivementsContainerView.addSubview(achivementsView)
        achivementsView.snp.makeConstraints { make in
            make.top.equalTo(achivementsContainerView.snp.top)
            make.leading.equalTo(achivementsContainerView.snp.leading)
            make.trailing.equalTo(achivementsContainerView.snp.trailing)
            make.bottom.equalTo(achivementsContainerView.snp.bottom)
        }
        achivementsContainerView.layoutIfNeeded()
    }

    @IBAction func didTapOnLogOut(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        let defaults = UserDefaults.standard
        defaults.set(false, forKey: "isAuth")
        self.present(loginViewController, animated: true)
    }
}
