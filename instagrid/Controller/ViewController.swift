//
//  ViewController.swift
//  instagrid
//
//  Created by vador on 08/03/2018.
//  Copyright © 2018 sofiane bahri. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
    
{

    
    @IBOutlet  var monBoutton2: UIButton!
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var instagrid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func didTapLayout1Button(_ sender: UIButton) {
        changeLayout(style: .layout1)
        
    }
    
    @IBAction func didTapLayout2Button(_ sender: UIButton) {
        changeLayout(style: .layout2)
    }
    
    
    @IBAction func didTapLayout3Button(_ sender: UIButton) {
        changeLayout(style:.layout3)
    }
    
    private func changeLayout( style: PhotoView.Style){
        photoView.style = style
    }
    
    @IBAction func openButtonLibrairy(_ sender: UIButton!) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(pickedImage)
        monBoutton2.setImage(pickedImage, for: .normal)
        monBoutton2.imageView?.contentMode = .scaleAspectFill
      //  monBoutton2.imageView?.image = pickedImage
        
        dismiss(animated: true, completion: nil)
        
    }

}
    
    
    
    
   
