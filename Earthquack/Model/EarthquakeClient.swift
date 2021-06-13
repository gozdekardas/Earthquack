//
//  EarthquakeClient.swift
//  Earthquack
//
//  Created by GOZDE KARDAS on 9.06.2021.
//
import Foundation

class EarthquakeClient{
    enum Endpoints {
        case getLatestEarthquakes(yesterday: String, today: String)
        
        var stringURL: String{
            switch self {
            case let .getLatestEarthquakes(yesterday,today):
                return "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(yesterday)&endtime=\(today)"
            }
        }
        var url: URL{
            return URL(string: stringURL)!
        }
    }
    
    private class func sendGETRequest<ResponseType: Decodable>(url: URL, response: ResponseType.Type, completionHandler: @escaping (ResponseType?,Error?) -> Void ){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(nil,error)
                }
                return
            }
            
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(responseObject,nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completionHandler(nil, error)
                }
            }
        }
        task.resume()
    }
    
    public class func getQuakes(yesterday: String, today: String, completionHandler: @escaping (EarthquakeResponse?, Error?) -> Void ){
                
            sendGETRequest(url: Endpoints.getLatestEarthquakes(yesterday: yesterday, today: today).url , response: EarthquakeResponse.self) { (response, error) in
                    if let response = response {
                        completionHandler(response, nil)
                    } else {
                        completionHandler(nil, error)
                    }
                }
            }
    
}
