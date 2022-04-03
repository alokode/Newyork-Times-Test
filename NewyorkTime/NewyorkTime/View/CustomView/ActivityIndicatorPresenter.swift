//
//  Lodable.swift
//  NewyorkTime
//
//  Created by Alok Sagar on 03/04/22.
//

import Foundation
import UIKit

protocol ActivityIndicatorPresenter {
    var activityIndicator: UIActivityIndicatorView { get }
    func showActivityIndicator()
    func hideActivityIndicator()
}

//For activity indicator
extension ActivityIndicatorPresenter where Self: UIViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.color = UIColor.black
            self.activityIndicator.style = .large
            self.activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100, height: 100)
            self.activityIndicator.center = CGPoint(x:self.view.bounds.size.width / 2, y:self.view.bounds.size.height / 2)
            self.view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
}

    func hideActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
        }
    }
}
