//
//  DurationCell.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 10/12/21.
//

import UIKit

final class DurationCell: UICollectionViewCell {

    @IBOutlet private var durationLabel: UILabel!
    
    func configure(duration: Int) {
        self.durationLabel.text = duration.durationString
    }

}

extension Int {
    var durationString: String {
        let pluralitySuffix = self  == 1 ? "" : "s"
        return String(self) + "min" + pluralitySuffix
    }
}
