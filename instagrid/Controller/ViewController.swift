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
    var myVc: UIViewController?
    var icon: UIImage!
    var currentButton: UIButton?
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var instagrid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ajout du geste swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector( swipePhotoView(_:)))
        swipeGesture.direction = .up
        self.photoView.addGestureRecognizer(swipeGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // bouton pour changer le layout
    
    @IBAction func didTapLayoutButton(_ sender: UIButton!) {
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
            
        }
        switch sender.tag {
        case 0:
            changeLayout(style: .layout1)
        case 1:
            changeLayout(style: .layout2)
        case 2:
            changeLayout(style: .layout3)
            
        default: break
        }
        
        
        
        sender.setImage(#imageLiteral(resourceName: "icon"), for: .selected)
        
        
    }
    
    
    
    
    private func changeLayout( style: PhotoView.Style){
        photoView.style = style
    }
    // Mise en place de UIaction mais ne fonctionne pas
    @IBAction func openButtonLibrairy(_ sender: UIButton!) {

        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Open Camera", style: UIAlertActionStyle.default, handler: { (action) -> Void in
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Choose Exisiting Photo", style: UIAlertActionStyle.default, handler: { (action) -> Void in
        }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            
        }))
        myVc?.present(actionsheet, animated: true, completion: nil)
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            currentButton = sender
        }
    }
    
    // Bonus.
    @IBAction func openCameraButton(_ sender: UIButton!) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        
            currentButton = sender
        
        
        }
    }
    
    
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(pickedImage)
        currentButton!.setImage(pickedImage, for: .normal)
        currentButton!.imageView?.contentMode = .scaleAspectFill
        
      //  monBoutton2.imageView?.image = pickedImage
        
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func swipePhotoView(_ sender: UISwipeGestureRecognizer) {
        // ici on share une image
        let picture = UIImage(view: photoView)
        let activityVc = UIActivityViewController(activityItems:[picture] , applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVc, animated: true, completion: nil)
    }
    
}
    
    
    
    
   
