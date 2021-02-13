//
//  UIButton+Ext.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import UIKit

extension UIButton {
    
    func isLoading(_ isLoading: Bool) {
        if isLoading {
            let spinner = UIActivityIndicatorView(style: .white)
            spinner.center = CGPoint(x: bounds.midX, y: bounds.midY)
            addSubview(spinner)
            spinner.startAnimating()
            isEnabled = false
            titleLabel?.removeFromSuperview()
        } else {
            let spinner = subviews.first(where: { $0 is UIActivityIndicatorView })
            spinner?.removeFromSuperview()
            isEnabled = true
            guard let titleLabel = titleLabel else { return }
            addSubview(titleLabel)
        }
    }
}
