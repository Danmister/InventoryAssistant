//
//  InventoryViewController.swift
//  InventoryAssistant
//
//  Created by Daniel Correa on 1/4/17.
//  Copyright © 2017 Repel. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpDateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var item : Item? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if item != nil {
            itemImageView.image = UIImage(data: item!.image as! Data)
            titleTextField.text = item!.title
            
            addUpDateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        itemImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if item != nil {
            
            item!.title = titleTextField.text
            item!.image = UIImagePNGRepresentation(itemImageView.image!) as NSData?
            
        } else {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let item = Item(context: context)
            item.title = titleTextField.text
            item.image = UIImagePNGRepresentation(itemImageView.image!) as NSData?
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

        navigationController!.popViewController(animated: true)

    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(item!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)

    }
    
}
