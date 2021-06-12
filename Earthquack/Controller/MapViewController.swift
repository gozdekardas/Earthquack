//
//  MapViewController.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 9.06.2021.
//

import UIKit
import MapKit
import CoreData
import Foundation

class MapViewController: UIViewController, NSFetchedResultsControllerDelegate, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<SavedEarthquakes>!
    var savedEarthquakes = [SavedEarthquakes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.register(customAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
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
        
        activityIndicatorView.startAnimating()
        EarthquakeClient.getQuakes(yesterday: yesterday, today: today) { (data, error) in
            //    let quake = Earthquake(context: DataController.shared.viewContext)
            if let data = data {
                Earthquakes.data = data.features
                
                var annotations = [MKPointAnnotation]()
                let response = EarthquakeResponse(type:  data.type, features: data.features )
                
                for feature in response.features {
                    let longitude = feature.geometry.coordinates[0]
                    let latitude = feature.geometry.coordinates[1]
                    let magnitude = feature.properties.mag
                    let place = feature.properties.place
                    // print("\(latitude) \(longitude) \(magnitude)")
                    
                    let lat = CLLocationDegrees(latitude)
                    let long = CLLocationDegrees(longitude)
                    
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = place
                    if let magnitude = magnitude{
                        annotation.subtitle = "\(magnitude)"
                    }
                    
                    
                    annotations.append(annotation)
                }
                print(annotations.count)
                self.mapView.addAnnotations(annotations)
                self.activityIndicatorView.stopAnimating()
            }else{
                self.showMessage(title:"Failed", message: "Error when getting earthquakes")
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
    
    func showMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        present(alertVC, animated: true)
        
        
    }
    
    func addToSaved(view: MKAnnotationView) {
        
        if let selectedPinLat = view.annotation?.coordinate.latitude,
           let selectedPinLon = view.annotation?.coordinate.longitude, let selectedPinMag = view.annotation?.subtitle,  let selectedPinPlace = view.annotation?.title{
            
            let saving = SavedEarthquakes(context: DataController.shared.viewContext)
            saving.latitude = selectedPinLat
            saving.longitude = selectedPinLon
            saving.place = selectedPinPlace

            if let mag = Double(selectedPinMag!) {
                saving.magnitude = mag
            }
            savedEarthquakes.append(saving)
            self.showMessage(title:"Success", message: "Earthquake saved!")
        }else{
            self.showMessage(title:"Failed", message: "Not saved")
        }
        
        mapView.deselectAnnotation(view.annotation, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("On Click The Marker")
        addToSaved(view: view)
        
    }
}





