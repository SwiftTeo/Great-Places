//
//  InputTableViewController.swift
//  Great Places
//
//  Created by AppleEnthusiast on 27.04.18.
//  Copyright © 2018 TheProgrammingJedi. All rights reserved.
//

import UIKit

class InputTableViewController: UITableViewController {

    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    @IBOutlet weak var tf_website: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        if let name = tf_name.text, name.count > 0{
            let place = Place(name: name)
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   

}
