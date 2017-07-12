//
//  Weather manager.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//

import UIKit
import Foundation

final class WeatherManager {
    
    static let sharedInstance = WeatherManager()
    
    func checkWeather (city: String, completion: @escaping( [String : AnyObject] ) -> Void ) {
        
        let urlRequest = URLRequest(url: URL(string: "http://api.apixu.com/v1/current.json?key=dfd9978b20bc4738baa132017171107&q=\(city)")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error == nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                    
//                    if let current = json["current"] as? [String : AnyObject] {
//                        
//                        if let temp = current["temp_c"] as? Int {
//                            self.degree = temp
//                        }
//                        if let condition = current["condition"] as? [String : AnyObject] {
//                            self.condition = condition["text"] as! String
//                            let icon = condition["icon"] as! String
//                            self.imgURL = "http:\(icon)"
//                        }
//                    }
//                    if let location = json["location"] as? [String : AnyObject] {
//                        self.city = location["name"] as! String
//                    }
//                    
//                    if let _ = json["error"] {
//                        self.exists = false
//                    }
                    
                    //return jsocomplsdn
                    //print(json)
                    completion(json)
                    
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
