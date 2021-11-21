//
//  Gradients.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import QuartzCore
import UIKit

typealias GradientColor = [CGColor]

extension Array where Element == CGColor {
    
    static let login: GradientColor = [UIColor.make(hex: "#859398").cgColor, UIColor.make(hex: "#283048").cgColor]
}
