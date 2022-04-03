//
//  UIVIew+Extension.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation
import UIKit

extension UIView { //To add shimmer animation for images
    
    private func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }

    func startShimmerAnimation() {
        print("#ALK SHIMMER startShimmerAnimation")
        stopShimmerAnimation()
        let gradientLayer = ShimmerGradientLayer.init()
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        let animation = addAnimation()
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopShimmerAnimation(){
        print("#ALK SHIMMER  stopShimmerAnimation")
        let oldAnimation = self.layer.sublayers?.first {
            guard let shimmerLayer = $0 as? ShimmerGradientLayer, shimmerLayer.tag == 1000 else {return false}
            return true
        }
        if oldAnimation != nil {
            print("#ALK SHIMMER  getting and removing old layer")
            oldAnimation?.removeAllAnimations()
            oldAnimation?.removeFromSuperlayer()
        }
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemGray2.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

