//
//  Place.swift
//  Great Places
//
//  Created by AppleEnthusiast on 27.04.18.
//  Copyright © 2018 TheProgrammingJedi. All rights reserved.
//

import Foundation
import CoreLocation

struct Place{
    
    var name:String
    var timestamp:Double
    var imagename:String?
    var phone:String?
    var coordinate:CLLocationCoordinate2D?
    var website:String?
    
    init(name:String, timestamp:Double? = nil, imagename:String? = nil, phone:String? = nil, coordinate:CLLocationCoordinate2D? = nil, website:String? = nil) {
        
        self.name = name
        
        if let thetimestamp = timestamp{
            self.timestamp = thetimestamp
        }
        else{
            self.timestamp = Date().timeIntervalSince1970
        }
        
        self.imagename = imagename
        self.phone = phone
        self.coordinate = coordinate
        self.website = website
    }//init
    
    init(dictionary:[String:Any]) {
        
        name = dictionary["name"] as! String
        timestamp = dictionary["timestamp"] as! Double
        imagename = dictionary["imagename"] as? String
        phone = dictionary["phone"] as? String
        
        if let latitude = dictionary["latitude"] as? Double, let longitude = dictionary["longitude"] as? Double{
            coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        else{
            coordinate = nil
        }
        
        website = dictionary["website"] as? String
    }//init dictionary
    
    func plistDictionary() -> [String:Any]{
        
        var dictionary = [String:Any]()
        
        dictionary["name"] = name
        dictionary["timestamp"] = timestamp
        
        if imagename != nil{
            dictionary["imagename"] = imagename
        }
        
        if phone != nil{
            dictionary["phone"] = phone
        }
        
        if coordinate != nil{
            dictionary["latitude"] = coordinate?.latitude
            dictionary["longitude"] = coordinate?.longitude
        }
        
        if website != nil{
            dictionary["website"] = website
        }
        
        return dictionary
    }
    
    static func placesurl()-> URL?{
        
        let fileurls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documenturl = fileurls.first{
            return documenturl.appendingPathComponent("places.plist")
        }
        
        return nil
    }//placesurl
    
    static func imageurl(imagename:String)->URL?{
        let fileurls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        if let documenturl = fileurls.first{
            return documenturl.appendingPathComponent(imagename)
        }
        
        return nil
    }//imageurl
    
}
