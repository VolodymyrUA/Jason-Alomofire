//
//  ViewController.swift
//  JasonTest
//
//  Created by Володимир Смульський on 3/5/18.
//  Copyright © 2018 Володимир Смульський. All rights reserved.


import UIKit
import SwiftyJSON
import Alamofire
import CoreLocation

struct Trash {
    var name:String = ""
    var longitude:Double = 0
    var latitude:Double = 0
    var numberOfRaffle:Double = 1
    var id: Double = 0
}

extension Trash {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

class ViewController: UIViewController {
    
    let idIndex = 0
    let latitudeIndex = 4
    let longitudeIndex = 5
    let numberOfraffleIndex = 6
    let arrayOfLinks = ["https://firebasestorage.googleapis.com/v0/b/recycler032.appspot.com/o/Divided%20trashmap(.json)%2F1.json?alt=media&token=1f26892b-236c-432b-b3cf-250029c7cbfb","https://firebasestorage.googleapis.com/v0/b/recycler032.appspot.com/o/Divided%20trashmap(.json)%2FBigDiv4%20(2).json?alt=media&token=9840c3cb-c231-44f4-8e50-8e960c7a5138"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request( arrayOfLinks[0], method: .get).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    return
                }
                
                let str = String.init(data: data, encoding: String.Encoding.utf8)
                let json = JSON.init(parseJSON: str!)
                var trashDictionary = [String:Trash]()
                
                for trashJson in json["Placemark"].arrayValue {
                    var trash = Trash()
                    trash.name = trashJson["name"].string ?? ""
                    
                    if let lat = trashJson["ExtendedData"]["Data"][self.latitudeIndex]["value"].string {
                        trash.latitude = Double(lat) ?? 0
                    }
                    if let long = trashJson["ExtendedData"]["Data"][self.longitudeIndex]["value"].string {
                        trash.longitude = Double(long) ?? 0
                    }
                    if let name = trashDictionary [trash.name] {
                        trash.name = name.name
                    }
                    
                    if let numberOfRaffle = trashJson["ExtendedData"]["Data"][6]["value"].string {
                        trash.numberOfRaffle = Double(numberOfRaffle) ?? 0
                    }
                
                    if let id = trashJson["ExtendedData"]["Data"][self.idIndex]["value"].string {
                        trash.id = Double(id) ?? 0
                    }
                    
                    print("name = \(trash.name),coordinates: latitude = \(trash.latitude), longitude = \(trash.longitude), numberOfRaffle = \(trash.numberOfRaffle),id = \(trash.id)\n")
                    
                    trashDictionary[trash.name] = trash
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//                for i in 0..< placemark["Placemark"].array?.count  {
//                    let placemark = json["Placemark"][i]
//                    let name = placemark["name"]
//                    let latitude = placemark["ExtendedData"]["Data"][self.latitudeIndex]["value"]
//                    let longitude = placemark["ExtendedData"]["Data"][self.longitudeIndex]["value"]
//                    let numberOfraffle = placemark["ExtendedData"]["Data"][self.numberOfraffleIndex]["value"]
//                    self.trashDictionary [String(describing: name)] = [ Double(latitude), Double(longitude), Double(numberOfraffle) ]

//                let placemark2 = json["Placemark"][1]
//                let name2 = placemark2["name"]
//                let latitude2 = placemark2["ExtendedData"]["Data"][4]["value"]
//                let longitude2 = placemark2["ExtendedData"]["Data"][5]["value"]
//                print("name = \(name2),coordinates: latitude = \(latitude2), longitude = \(longitude2) ")





//placemark["Placemark"]["name"].count - return index
// name.count return number

//                for i in Trash {
//                    var varTrash = Trash(id)
//                    varTrash.id = i["ExtendedData"]["Data"][longitudeIndex]["value"]
//                }

//                    let placemark = json["Placemark"][0]
//                    let name = placemark["name"]
//                    let latitude = placemark["ExtendedData"]["Data"][4]["value"]
//                    let longitude = placemark["ExtendedData"]["Data"][5]["value"]
//                    let numberOfraffle = placemark["ExtendedData"]["Data"][6]["value"]
//
//                print("name = \(name),coordinates: latitude = \(latitude), longitude = \(longitude),numberOfraffle = \(numberOfraffle) \n")
