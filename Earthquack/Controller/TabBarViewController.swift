//
//  TabBar.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 12.06.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
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
            if let data = data {
                Earthquakes.data = data.features
                print(Earthquakes.data.count)
                
            }else{
                self.showMessage(title:"Failed", message: "Error when getting earthquakes")
            }
        }
    }
    
    func showMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }))
        present(alertVC, animated: true)
        
        
    }
}
