//
//  UIImage+extension.swift
//  instagrid
//
//  Created by vador on 03/05/2018.
//  Copyright © 2018 sofiane bahri. All rights reserved.
//

import UIKit
// transforme une UIView en UIImage
extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
}
