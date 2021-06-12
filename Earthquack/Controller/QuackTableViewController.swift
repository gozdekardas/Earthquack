//
//  QuackTableViewController.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 12.06.2021.
//

import UIKit
import CoreData

class QuackTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    var savedEarthquakes = [SavedEarthquakes]()
    
    var dataController:DataController!
    var fetchedResultsController:NSFetchedResultsController<SavedEarthquakes>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Earthquakes.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuackTableViewCell")!
        let quack = Earthquakes.data[(indexPath as NSIndexPath).row]
        
        let placeText = quack.properties.place
        let magText = quack.properties.mag
        
        if let placeText = placeText{
            cell.textLabel?.text = "\(placeText) "
        }
        
        if let magText = magText{
            cell.detailTextLabel?.text = "\(magText)"
        }
        
        
        cell.imageView?.image = UIImage(named: "icon_pin")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let quack = Earthquakes.data[(indexPath as NSIndexPath).row]
        
        
        if let place = quack.properties.place,
           let magnitude = quack.properties.mag
        
        {
            let latitude = quack.geometry.coordinates[1]
            let longitude = quack.geometry.coordinates[0]
            let saving = SavedEarthquakes(context: DataController.shared.viewContext)
            saving.place = place
            saving.magnitude = magnitude
            saving.latitude = latitude
            saving.longitude = longitude
            
            savedEarthquakes.append(saving)
            self.showMessage(title:"Success", message: "Earthquake saved!")
        }else{
            self.showMessage(title:"Failed", message: "Not saved")
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
    
}
