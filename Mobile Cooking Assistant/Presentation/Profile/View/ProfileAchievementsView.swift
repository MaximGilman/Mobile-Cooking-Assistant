//
//  ProfileAchivementsView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import Foundation
import UIKit
import UICircularProgressRing

final class ProfileAchievementsView: UIView, NibLoadable {
    
    @IBOutlet private var achievementsStackView: UIStackView!
    @IBOutlet private var firstRing: UICircularProgressRing!
    @IBOutlet private var secondRing: UICircularProgressRing!
    @IBOutlet private var thirdRing: UICircularProgressRing!
    
    private var areRingsHidden: Bool = false
    
    static func make() -> ProfileAchievementsView {
        let view = ProfileAchievementsView.loadFromNib()
        
        view.firstRing.value = 100
        view.firstRing.setupStyleInProfile()
        
        view.secondRing.value = 33
        view.secondRing.setupStyleInProfile()
        
        view.thirdRing.value = 0
        view.thirdRing.setupStyleInProfile()
        
        return view
    }
    
    @IBAction private func onHideTapped(_ sender: Any) {
        achievementsStackView.isHidden = !achievementsStackView.isHidden
    }
}

private extension UICircularProgressRing {
    
    func setupStyleInProfile() {
        outerRingColor = .lightGray
        innerRingColor = .green
        outerRingWidth = 3
        innerRingWidth = 3
        style = .ontop
    }
}
