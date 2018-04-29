//
//  InputTableViewController.swift
//  Great Places
//
//  Created by AppleEnthusiast on 27.04.18.
//  Copyright © 2018 TheProgrammingJedi. All rights reserved.
//

import UIKit
import CoreLocation

class InputTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_website: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if let name = tf_name.text, name.count > 0{
            
            let timestamp = Date().timeIntervalSince1970
            var imagename:String? = nil
            
            if let image = imageView.image{
                imagename = "\(Int(timestamp)).jpg"
                let imagedata = UIImageJPEGRepresentation(image, 0.01)
                
                if let imageurl = Place.imageurl(imagename: imagename!){
                    
                    _ = try? imagedata?.write(to: imageurl, options: [.atomic])
                }
            }
            
            let place = Place(name: name, imagename: imagename, phone: tf_phone.text, website: tf_website.text)
            let plistdictionary = place.plistDictionary()
            print(place)
            print(plistdictionary)
            
            do{
               
                
                if let url = Place.placesurl(){
                    var plist:Any?
                    
                    if let indata = try? Data(contentsOf: url){
                        plist = try? PropertyListSerialization.propertyList(from: indata, options: [], format: nil)
                    }
                    else{
                        plist = nil
                    }
                    
                    
                    var plistarray = [[String:Any]]()
                    
                    if let array = plist as? [[String:Any]]{
                        plistarray = array
                    }
                    
                    plistarray.append(plistdictionary)
                    
                    let data = try PropertyListSerialization.data(fromPropertyList: plistarray, format: .xml, options: 0)
                    
                    try data.write(to: url, options: .atomic)
                    
                    dismiss(animated: true, completion: nil)
                }
                else{
                    print("😢 Fehler im Dateisystem.")
                }
                
                
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 3{
            showActionSheet()
        }
    }
    
    func showActionSheet(){
        
        let alertController = UIAlertController(title: "Select Photo", message: "Add a Photo to Your Place", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            self.selectImage(from: .camera)
        }
        
        let photo = UIAlertAction(title: "Photo", style: UIAlertActionStyle.default) { (action) in
            self.selectImage(from: .photoLibrary)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(camera)
        alertController.addAction(photo)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func selectImage(from sourcetype: UIImagePickerControllerSourceType){
        
        if UIImagePickerController.isSourceTypeAvailable(sourcetype){
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourcetype
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}
