//
//  ViewController.swift
//  Great Places
//
//  Created by AppleEnthusiast on 26.04.18.
//  Copyright © 2018 TheProgrammingJedi. All rights reserved.
//

import UIKit
import MapKit
class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var websiteButton: UIButton!
    
    var place:Place?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func phoneAction(_ sender: UIButton) {
        
        guard let str = sender.titleLabel?.text, let url = URL(string: "telprompt://\(str)") else{
            return
        }
        
        UIApplication.shared.open(url)
        
    }
    
    @IBAction func websiteAction(_ sender: UIButton) {
        
        guard let str = sender.titleLabel?.text, let url = URL(string: str) else{
            print("URL konnte nicht erzeugt werden.")
            return
        }
        UIApplication.shared.open(url)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard let theplace = place else{
            return
        }
        label.text = theplace.name
        
        if let imagename = theplace.imagename, let imageurl = Place.imageurl(imagename: imagename), let imagedata = try? Data(contentsOf: imageurl){
            let image = UIImage(data: imagedata)
            imageView.image = image
        }
        
        if let website = theplace.website, website.count > 0 {
            websiteButton.setTitle(website, for: UIControlState.normal)
        }
        else{
            websiteButton.setTitle("", for: UIControlState.normal)
        }
       
        
        
        if let phone = theplace.phone, phone.count > 0 {
            phoneButton.setTitle(phone, for: UIControlState.normal)
        }
        else{
            phoneButton.setTitle("", for: UIControlState.normal)
        }
       
        
        if let coordinate = theplace.coordinate{
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 5000, 5000)
            mapView.setRegion(region, animated: true)
            
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = coordinate
            pointAnnotation.title = theplace.name
            pointAnnotation.subtitle = "Photo was taken here"
            mapView.addAnnotation(pointAnnotation)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

