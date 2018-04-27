//
//  PlacesTableViewController.swift
//  Great Places
//
//  Created by AppleEnthusiast on 27.04.18.
//  Copyright © 2018 TheProgrammingJedi. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    var places = [Place]()
    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateformatter.dateStyle = DateFormatter.Style.medium
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let place = places[indexPath.row]
        cell.textLabel?.text = place.name
        let date = Date(timeIntervalSince1970: place.timestamp)
        cell.detailTextLabel?.text = dateformatter.string(from: date)

        return cell
    }
    

    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            places.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            if let url = Place.placesurl(){
                
                var plistarray = [[String:Any]]()
                
                for place in places{
                    plistarray.append(place.plistDictionary())
                }
                
                do{
                    let data = try PropertyListSerialization.data(fromPropertyList: plistarray, format: .xml, options: 0)
                    try data.write(to: url, options: .atomic)
                }
                catch{
                    print(error.localizedDescription)
                }
                
            }
            else{
                print("😢 Fehler im Dateisystem.")
            }
            
        }
    }
    


}