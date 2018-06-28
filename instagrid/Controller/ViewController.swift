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
UINavigationControllerDelegate,UIActionSheetDelegate {
    @IBOutlet weak var swipeUp: UILabel!
    @IBOutlet weak var swipeLeft: UILabel!
    // outlet collection boutton layout
    @IBOutlet var layOutButtonCollection: [UIButton]!
    var icon: UIImage!
    var currentButton: UIButton?
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var instagrid: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        let orientation = UIApplication.shared.statusBarOrientation
        let swipeGesture = UISwipeGestureRecognizer(target: self, action:#selector( swipePhotoView(_:)))
        //  gesture  instructions depending device orientation
        switch orientation {
        case .portrait,.portraitUpsideDown:
            swipeGesture.direction = .up
        case .landscapeLeft, .landscapeRight:
            swipeGesture.direction = .left
        default: break
        }
        self.photoView.addGestureRecognizer(swipeGesture)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if photoView.gestureRecognizers != nil {
        for gesture in photoView.gestureRecognizers! {
        if let recognizer = gesture as? UISwipeGestureRecognizer {
        photoView.removeGestureRecognizer(recognizer)
        }
      }
    }
        let swipeGesture = UISwipeGestureRecognizer(target: self,      action:#selector( swipePhotoView(_:)))
        self.photoView.removeGestureRecognizer(swipeGesture)
        // swipe gesture orientation instructions
        if UIDevice.current.orientation.isLandscape {
            swipeGesture.direction = .left
        }else{
            swipeGesture.direction = .up
        }
        self.photoView.addGestureRecognizer(swipeGesture)
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    }
    
    // change layout button
    @IBAction func didTapLayoutButton(_ sender: UIButton!) {
    // display the button sign only on selected button
    for button in self.layOutButtonCollection{
            if button.tag == sender.tag{
               button.isSelected = true;
            }else{
            button.isSelected = false
            }
    }
        // change the layout
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
    
    // button open the  photo librairy
    func openButtonLibrairy(_ sender: UIButton!) {
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                // rotate the  photolibrairy page on device
                imagePicker.modalPresentationStyle = .overCurrentContext
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
    
    // open the pop up with choice (choose picture ,take picture ,cancel)
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
    
    //display image of the button in the image view
     func imagePickerController(_ picker: UIImagePickerController,     didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(pickedImage)
        currentButton!.setImage(pickedImage, for: .normal)
        currentButton!.imageView?.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    // share a picture with the gesture
     @objc func swipePhotoView(_ sender: UISwipeGestureRecognizer) {
        let picture = UIImage(view: photoView)
        let activityVc = UIActivityViewController(activityItems:[picture] , applicationActivities: nil)
        activityVc.popoverPresentationController?.sourceView = self.view
        self.present(activityVc, animated: true, completion: nil)
        }
    
    
}
    
    
    
    
   
