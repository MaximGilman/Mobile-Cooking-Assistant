//
//  RecipePortionsView.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 11/22/21.
//

import Foundation
import UIKit
import SnapKit

protocol RecipePortionsViewDelegate: AnyObject {
    func didChangePortionsValue(value: Int)
}

final class RecipePortionsView: UIView, NibLoadable {
    
    @IBOutlet private var portionsLabel: UILabel!
    @IBOutlet private var sliderContainerView: UIView!
    
    private(set) var currentNumberOfPortions: Int = 1
    
    private weak var delegate: RecipePortionsViewDelegate?
    
    static func make(delegate: RecipePortionsViewDelegate) -> RecipePortionsView {
        let view = RecipePortionsView.loadFromNib()
        view.delegate = delegate
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
        stepSlider.index = 0
        stepSlider.addTarget(self, action: #selector(onSliderValueChanged), for: .valueChanged)
        
        sliderContainerView.addSubview(stepSlider)
        stepSlider.snp.makeConstraints { make in
            make.top.equalTo(sliderContainerView.snp.top)
            make.leading.equalTo(sliderContainerView.snp.leading)
            make.trailing.equalTo(sliderContainerView.snp.trailing)
            make.bottom.equalTo(sliderContainerView.snp.bottom)
        }
    }
    
    @IBAction func onSliderValueChanged(_ sender: StepSlider) {
        let count = Int(sender.index) + 1
        portionsLabel.text = "\(count) portion"
        
        if count > 1 {
            portionsLabel.text = portionsLabel.text! + "s"
        }
        currentNumberOfPortions = count
        delegate?.didChangePortionsValue(value: count)
    }
}
