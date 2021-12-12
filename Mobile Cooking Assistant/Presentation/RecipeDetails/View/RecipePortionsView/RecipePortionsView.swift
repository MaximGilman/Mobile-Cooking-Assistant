//
//  RecipePortionsView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import Foundation
import UIKit
import SnapKit

final class RecipePortionsView: UIView, NibLoadable {
    
    @IBOutlet private var portionsLabel: UILabel!
    @IBOutlet private var sliderContainerView: UIView!
    
    static func make() -> RecipePortionsView {
        let view = RecipePortionsView.loadFromNib()
        view.setupStepSlider()
        
        return view
    }
    
    private func setupStepSlider() {
        let stepSlider = StepSlider()
        stepSlider.maxCount = 5
        stepSlider.sliderCircleColor = .lightGray
        stepSlider.trackColor = .systemGray6
        stepSlider.labelColor = .gray
        stepSlider.tintColor = .gray
        
        sliderContainerView.addSubview(stepSlider)
        stepSlider.snp.makeConstraints { make in
            make.top.equalTo(sliderContainerView.snp.top)
            make.leading.equalTo(sliderContainerView.snp.leading)
            make.trailing.equalTo(sliderContainerView.snp.trailing)
            make.bottom.equalTo(sliderContainerView.snp.bottom)
        }
    }
    
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        let count = Int(sender.value)
        portionsLabel.text = "\(count) portion"
        
        if count > 1 {
            portionsLabel.text = portionsLabel.text! + "s"
        }
    }
    @IBAction func sliderMoved(_ sender: UISlider) {
//        sender.setValue(Float(lround(sender.value)), animated: true)
    }
}
