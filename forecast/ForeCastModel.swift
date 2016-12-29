//
//  ForeCastModel.swift
//  forecast
//
//  Created by Rami Baraka on 08/12/16.
//  Copyright © 2016 Rami Baraka. All rights reserved.
//

import Foundation

class ForeCastModel {
    
    init(weatherDict: Dictionary<String, Any>) {
        
        if let temp = weatherDict["temp"] as? Dictionary<String, Any> {
        
            if let min = temp["min"] as? Double {
                
                let convertedTemp: Int = Int(min - 273.15)
                
                self._lowTemp = "\(convertedTemp)"
            }
            
            if let max = temp["max"] as? Double {
                
                let convertedTemp: Int = Int(max - 273.15)
                
                self._highTemp = "\(convertedTemp)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>] {
        
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
        if _date == nil {
            _date = ""
        }
        return self._date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return self._weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return self._highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return self._lowTemp
    }
}


extension Date {
    
    func dayOfTheWeek() -> String{
    
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
        
    }
}
