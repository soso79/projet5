//
//  PhotoView.swift
//  instagrid
//
//  Created by vador on 05/04/2018.
//  Copyright © 2018 sofiane bahri. All rights reserved.
//

import UIKit

class PhotoView: UIView {
    private var icon: UIImage!
   @IBOutlet private var label: UILabel!
   @IBOutlet private var monBoutton: UIButton!
   @IBOutlet private var monBoutton2: UIButton!
   @IBOutlet private var monBoutton3: UIButton!
   @IBOutlet private var monBoutton4: UIButton!
   @IBOutlet private var cameraButton: UIButton!
    
    enum Style {
        case layout1, layout2, layout3
    }
    
    var style: Style = .layout2 {
        
    didSet {
    setStyle(style)
    
      }
    }
    private func setStyle(_ style: Style){
        switch style {
        case .layout1:
            monBoutton .isHidden = true
            monBoutton3 .isHidden = false
            
        case .layout2:
            monBoutton .isHidden = false
            monBoutton3 .isHidden = true
        case .layout3:
            monBoutton .isHidden = false
            monBoutton3 .isHidden = false
        }
        
    }
 
}

