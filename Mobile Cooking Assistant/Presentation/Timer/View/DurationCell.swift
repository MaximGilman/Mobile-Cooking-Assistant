//
//  DurationCell.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/12/21.
//

import UIKit

final class DurationCell: UICollectionViewCell {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var durationLabel: UILabel!
    
    static let identifier = String(describing: DurationCell.self)
    
    private(set) var duration: TimerValue!
    
    func configure(duration: TimerValue) {
        self.duration = duration
        durationLabel.text = duration.durationString
        containerView.clipsToBounds = false
        containerView.setSlightShadow()
        containerView.makeRound(.specific(radius: 10))
    }

}

extension TimerValue {
    var durationString: String {
        let minuteString = String(minutes) + "m"
        
        let secondString = String(seconds) + "s"
        
        return minuteString + " " + secondString
    }
}

extension Int {
    var durationString: String {
        let pluralitySuffix = self  == 1 ? "" : "s"
        return String(self) + "min" + pluralitySuffix
    }
}
