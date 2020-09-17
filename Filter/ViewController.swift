//
//  ViewController.swift
//  Filter
//
//  Created by Katherine Mu on 2020-09-16.
//  Copyright © 2020 Katherine. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    let context = CIContext()
    var original: UIImage?
    
    @IBAction func choosePhoto(_ sender: Any) {
        // if we are able to access the photo library
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // create an instance of the image picker
            let picker = UIImagePickerController()
            // it will be the delegate itself!
            picker.delegate = self
            // we will get the photos from the photoLibrary
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        }
    }
    
    // we are done, we have to dismiss the screen, then set the imageView to the value picked by the user
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
    
    // helper function to display filters
    func display(filter: CIFilter) {
        let originalCIImage = CIImage(image: original!)
        
        filter.setValue(originalCIImage!, forKey: kCIInputImageKey)
        let output = filter.outputImage
        
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!)
    }
    
    @IBAction func applyBlur() {
        let filter = CIFilter(name: "CIMotionBlur")
        filter?.setValue(20.00, forKey: kCIInputRadiusKey)
        filter?.setValue(0.00, forKey: kCIInputAngleKey)
        display(filter: filter!)
    }

    // APPLYING FILTERS:
    @IBAction func applySepia() {
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter: filter!)

    }
    
    @IBAction func applyNoir() {
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter: filter!)
    }
    
    @IBAction func applyInvert() {
        let filter = CIFilter(name: "CIColorInvert")
        display(filter: filter!)
    }
    
    @IBAction func applyOriginal() {
        imageView.image = original
    }
}

