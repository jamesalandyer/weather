//
//  Weather.swift
//  weather
//
//  Created by James Dyer on 4/16/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Weather {
    
    private var _tempature: String!
    private var _conditionTxt: String!
    private var _humidity: String!
    private var _high: String!
    private var _low: String!
    private var _windSpeed: String!
    private var _windDirection: String!
    private var _city: String!
    private var _zip: String!
    private var _state: String!
    
    var tempature: String {
        if _tempature == nil {
            _tempature = ""
        }
        
        return _tempature
    }
    
    var conditionTxt: String {
        if _conditionTxt == nil {
            _conditionTxt = ""
        }
        
        return _conditionTxt
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        
        return _humidity
    }
    
    var high: String {
        if _high == nil {
            _high = ""
        }
        return _high
    }
    
    var low: String {
        if _low == nil {
            _low = ""
        }
        
        return _low
    }
    
    var windSpeed: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        
        return _windSpeed
    }
    
    var windDirection: String {
        if _windDirection == nil {
            _windDirection = ""
        }
        
        return _windDirection
    }
    
    var city: String {
        if _city == nil {
            _city = ""
        }
        
        return _city
    }
    
    var zip: String {
        return _zip
    }
    
    var state: String {
        get {
            return _state
        }
        set {
            _state = newValue.uppercaseString
        }
        
    }
    
    init(zip: String) {
        _zip = zip
    }
    
    private func windConverter(deg: Int) -> String {
        switch deg {
        case 0...22:
            return "N"
        case 23...67:
            return "NE"
        case 68...112:
            return "E"
        case 113...157:
            return "SE"
        case 158...202:
            return "S"
        case 203...247:
            return "SW"
        case 248...292:
            return "W"
        case 293...337:
            return "NW"
        case 338...360:
            return "N"
        default:
            return ""
        }
    }
    
    func downloadWeather(completed: DownloadComplete) {
        
        let weatherUrl = "http://api.openweathermap.org/data/2.5/weather?zip=\(self._zip),us&APPID=ba9980aeedd7a59924e4f39c194da4d0&units=imperial"
        let url = NSURL(string: weatherUrl)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let temp = main["temp"] as? Double {
                        self._tempature = "\(Int(round(temp)))°"
                    }
                    if let high = main["temp_max"] as? Double {
                        self._high = "\(Int(round(high)))°"
                    }
                    if let low = main["temp_min"] as? Double {
                        self._low = "\(Int(round(low)))°"
                    }
                    if let humid = main["humidity"] as? Int {
                        self._humidity = "\(humid)%"
                    }
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let condition = weather[0]["main"] as? String {
                        self._conditionTxt = condition
                    }
                }
                if let location = dict["name"] as? String {
                    self._city = location.uppercaseString
                }
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = wind["speed"] as? Double {
                        self._windSpeed = "\(Int(round(speed))) MPH"
                    }
                    if let direction = wind["deg"] as? Int {
                        self._windDirection = self.windConverter(direction)
                    }
                }
                completed()
            }
        }
    }
    
}