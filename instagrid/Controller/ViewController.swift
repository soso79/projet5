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
    UINavigationControllerDelegate,UIActionSheetDelegate
    
    
{
    
    @IBOutlet weak var swipeUp: UILabel!
    
    @IBOutlet weak var swipeLeft: UILabel!
    // outlet collection boutton layout
    @IBOutlet var layOutButtonCollection: [UIButton]!
    var orientation: UIDeviceOrientation!
    var icon: UIImage!
    var currentButton: UIButton?
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var instagrid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ajout du geste swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector( swipePhotoView(_:)))
        swipeGesture.direction = .up
        swipeGesture.direction = .left
        self.photoView.addGestureRecognizer(swipeGesture)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // bouton pour changer le layout
    @IBAction func didTapLayoutButton(_ sender: UIButton!) {
       // permet d afficher le signe seulement sur le bouton selectionné
    
        for button in self.layOutButtonCollection{
            if button.tag == sender.tag{
                button.isSelected = true;
                
            }else{
                button.isSelected = false
            }
            
        }
        // change le layout
        switch sender.tag {
        case 0:
            changeLayout(style: .layout1)
        case 1:
            changeLayout(style: .layout2)
        case 2:
            changeLayout(style: .layout3)
            
        default: break
            
        }
        
        sender.setImage(#imageLiteral(resourceName: "Selected"), for: .selected)
        
        
        
    }
    
    private func changeLayout( style: PhotoView.Style){
        photoView.style = style
    }
    
    
    // bouton qui ouvre la photo librairy
    func openButtonLibrairy(_ sender: UIButton!) {

            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                self.currentButton = sender
            }
        
    }
    
    // Bonus.
     func openCameraButton(_ sender: UIButton!) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        
            currentButton = sender
        
        
        }
    }
    
    // ouvre la pop up avec le choix camera ou photo librairy ou cancel
    @IBAction func selectPhotoButton(sender: UIButton!){
        
        let actionsheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: "Open Camera", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.openCameraButton(sender)
        }))
        
        actionsheet.addAction(UIAlertAction(title: "Choose Exisiting Photo", style: UIAlertActionStyle.default, handler: { (action) -> Void in
            self.openButtonLibrairy(sender)
    
    }))
    actionsheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
    
    }))
    
    self.present(actionsheet, animated: true, completion: nil)
}
    
    //permet d afficher l image du boutton dans l image view
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(pickedImage)
        currentButton!.setImage(pickedImage, for: .normal)
        currentButton!.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
        
    }
    
    // ici on share une image avec le geste
    @IBAction func swipePhotoView(_ sender: UISwipeGestureRecognizer) {
        let picture = UIImage(view: photoView)
        let activityVc = UIActivityViewController(activityItems:[picture] , applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVc, animated: true, completion: nil)
    }
    
}
    
    
    
    
   
