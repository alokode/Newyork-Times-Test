//
//  ShimmerGradientLayer.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 02/04/22.
//

import Foundation
import UIKit


class ShimmerGradientLayer:CAGradientLayer {
    var tag:Int = 1000
    override init() {
        super.init()
        print("#ALK SHIMMER  ShimmerGradientLayer init")
        let gradientColorOne : CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        let gradientColorTwo : CGColor = UIColor(white: 0.95, alpha: 1.0).cgColor
        self.startPoint = CGPoint(x: 0.0, y: 1.0)
        self.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        self.locations = [0.0, 0.5, 1.0]
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
