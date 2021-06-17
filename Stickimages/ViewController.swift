//
//  ViewController.swift
//  Stickimages
//
//  Created by Benjamin Inemugha on 17/06/2021.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var combinedImage: UIImageView!
    
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Thank you for coding interview")
    }
    
    //Choosing Left and Right Images Button
    
    @IBAction func openPhotoLibraryLeft(_ sender: Any) {
        flag = 1
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        flag = 2
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    
    //Protocol for UIPicker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        if flag == 1{
            self.imageViewLeft.image = image
        }else if flag == 2{
            self.imageViewRight.image = image
        }
        
        picker.dismiss(animated: true)
    }
    
    //Stitch the images together
    @IBAction func stitchImages(_ sender: Any) {
        let LeftImage = self.imageViewLeft.image
        let RightImage = self.imageViewRight.image

        let size = CGSize(width: self.combinedImage.frame.size.width, height: self.combinedImage.frame.size.height)
        UIGraphicsBeginImageContext(size)

        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        LeftImage!.draw(in: areaSize)

        RightImage!.draw(in: areaSize, blendMode: .normal, alpha: 0.7)

        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.combinedImage.image = newImage
    }
    
}

