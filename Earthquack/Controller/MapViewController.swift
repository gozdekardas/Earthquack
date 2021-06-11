//
//  MapViewController.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 9.06.2021.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController,  MKMapViewDelegate{
    @IBOutlet weak var mapview: MKMapView!
    
    var dataController:DataController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        // Do any additional setup after loading the view.
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_us_POSIX")
        
        let today = formatter.string(from: now)
        
        print(today)
        
        let date = formatter.date(from: today)
        let lastTime: TimeInterval = -(24*60*60)
        
        let lastDate = date?.addingTimeInterval(lastTime)
        let yesterday = formatter.string(from: lastDate!)
        print(yesterday)
        
        
        EarthquakeClient.getQuakes(yesterday: yesterday, today: today) { (data, error) in
            //    let quake = Earthquake(context: DataController.shared.viewContext)
            if let data = data{
                let response = EarthquakeResponse(type:  data.type, features: data.features )
                print(response.features)
                
                // here i want to get the latitude from response
            }
        }
    }
    
    func saveUserRegion(_ mapRegion: MKCoordinateRegion?){
        if let mapRegion = mapRegion {
            let userMapRegion = ["latitude": mapRegion.center.latitude,
                                 "longitude": mapRegion.center.longitude,
                                 "delta_latitude": mapRegion.span.latitudeDelta,
                                 "delta_longitude": mapRegion.span.longitudeDelta]
            UserDefaults.standard.set(userMapRegion, forKey: "userMapRegion")
        }
    }
}





