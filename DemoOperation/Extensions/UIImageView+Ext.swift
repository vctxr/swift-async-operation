//
//  UIImageView+Ext.swift
//  DemoOperation
//
//  Created by Victor Samuel Cuaca on 07/02/21.
//

import UIKit

extension UIImageView {
    
    func loadGIF(gifData: Data) {
        guard let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return }
        
        var images: [UIImage] = []
        let imageCount = CGImageSourceGetCount(source)
        
        for i in 0 ..< imageCount {
            guard let image = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            images.append(UIImage(cgImage: image))
        }
        animationImages = images
        startAnimating()
    }
}
