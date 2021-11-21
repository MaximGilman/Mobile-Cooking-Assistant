//
//  UIView+Ext.swift
//  Mobile Cooking Assistant
//
//  Created by Parshakov Alexander on 9/27/21.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(color: GradientColor) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = color
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)

        layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Shadow
extension UIView {
    func setSlightShadow(shadowColor: UIColor = .darkGray, length: CGFloat = 3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: length, height:  length)
        self.layer.shadowRadius = length * 2
        
        if traitCollection.userInterfaceStyle == .dark{
           self.layer.shadowOpacity = 0.0;
        }
        else {
            self.layer.shadowOpacity = 0.35
        }
    }
}

// MARK: - Corners
extension UIView {
    func roundParticularCorners(corners: UIRectCorner = [.allCorners], radius: CGFloat) {
        layer.mask = nil
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func makeRound(_ option: RoundingOption) {
        switch option {
        case .complete:
            layer.cornerRadius = bounds.midY
        case .specific(let radius):
            layer.cornerRadius = radius
        }
    }
}

enum RoundingOption {
    case complete
    case specific(radius: CGFloat)
}


// MARK: - Animation
extension UIView {
    func showAnimatedPress(withScale scale: CGFloat = 0.9, overAllDuration: Double = 0.3, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: overAllDuration / 2, animations: {
            self.transformToScale(scale)
        }) { (_) in
            UIView.animate(withDuration: overAllDuration / 2, animations: {
                self.transformToIdentity()
            }) { (_) in
                completion?()
            }
        }
    }
    
    func transformToIdentity() {
        self.transform = CGAffineTransform.identity
    }
    
    func transformToScale(_ scale: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
