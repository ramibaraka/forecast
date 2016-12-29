//
//  Constants.swift
//  forecast
//
//  Created by Rami Baraka on 07/12/16.
//  Copyright © 2016 Rami Baraka. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATTITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "c1d2e0bd881d65f5b6337cce827014fa"
let WEATHER = "weather?"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(abs(Location.sharedInstance.longitude!))&cnt=10&appid=c1d2e0bd881d65f5b6337cce827014fa"

let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(abs(Location.sharedInstance.longitude!))0&appid=\(API_KEY)"
typealias DownloadComplete = () -> ()

