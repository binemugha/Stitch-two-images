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
    @IBOutlet weak var stitchButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Thank you")
        buttonDesign()
    }
    
    func buttonDesign(){
        stitchButton.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 10
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

     
        //Checking if the images are empty before the merge
        if (LeftImage != nil && RightImage != nil){
            let size = CGSize(width: self.combinedImage.frame.size.width, height: self.combinedImage.frame.size.height)
            UIGraphicsBeginImageContext(size)

            let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            
            
            LeftImage!.draw(in: areaSize)
            RightImage!.draw(in: areaSize, blendMode: .normal, alpha: 0.82)
            
            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            self.combinedImage.image = newImage
        }else{
            showErrorAlert()
        }
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        if combinedImage.image != nil{
            let imageData = combinedImage.image?.pngData()
            let compressedImage = UIImage(data: imageData!)
            UIImageWriteToSavedPhotosAlbum(compressedImage!, self, #selector(completeSaved), nil)
        }else{
            showRandomErrorAlert()
        }
    }
    
    //Helper
    @objc func completeSaved(_ imageData:UIImage, error:Error?, context:UnsafeMutableRawPointer?){
        
        if let err = error {
            showRandomErrorAlert()
            print(err)
            return
        }
        let alert = UIAlertController(title: "Saved", message: "The Image has been saved", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "Please select two images", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showRandomErrorAlert(){
        let alert = UIAlertController(title: "Error", message: "There was an error", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

