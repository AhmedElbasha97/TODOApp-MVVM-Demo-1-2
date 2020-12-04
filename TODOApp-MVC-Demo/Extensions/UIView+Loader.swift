//
//  UIView+Loader.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/3/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    //MARK:- showing loader
    func showLoader() {
        let activityIndicator = setupActivityIndicator()
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
     //MARK:- showing loader
    func hideLoader() {
        if let activityIndicator = viewWithTag(333) {
            activityIndicator.removeFromSuperview()
        }
    }
     //MARK:- setting up loader
    private func setupActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = self.bounds
        activityIndicator.center = self.center
        activityIndicator.style = .medium
        activityIndicator.tag = 333
        return activityIndicator
    }
}
