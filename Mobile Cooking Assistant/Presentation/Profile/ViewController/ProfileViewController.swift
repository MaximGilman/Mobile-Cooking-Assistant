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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
