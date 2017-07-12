//
//  Utils.swift
//  LocationLogger
//
//  Created by Niar on 7/11/17.
//  Copyright © 2017 Niar. All rights reserved.
//


import Foundation

class Utils {
    
    class func formatDate (date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        //let result = formatter.string(from: date)
        return formatter.string(from: date)
    }
    
    class func stringFromClassName(obj: Any) -> String {
        return String(describing: obj)
    }
    
}
