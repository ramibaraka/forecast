//
//  ViewController.swift
//  forecast
//
//  Created by Rami Baraka on 06/12/16.
//  Copyright © 2016 Rami Baraka. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation


class ForeCastVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cloudImg: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation!
    
    
    var foreCasts = [ForeCastModel]()
    var foreCast: ForeCastModel!
    
    var currentWeather: CurrentWeather!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthStatus()
        
    }
    
    func locationAuthStatus(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForeCast {
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func downloadForeCast(completed: @escaping DownloadComplete){
        // Download forecast
        
        Alamofire.request(FORECAST_URL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, Any> {
                
                if let list = dict["list"] as? [Dictionary<String, Any>]{
                    
                    for obj in list {
                        let foreCast = ForeCastModel(weatherDict: obj)
                        self.foreCasts.append(foreCast)
                    }
                    self.foreCasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
    }
    

    
    func updateMainUI(){
        dateLabel.text = currentWeather.date
        tempLabel.text = "\(currentWeather.currentTemp)℃"
        cityLabel.text = currentWeather.cityName
        weatherLabel.text = currentWeather.weatherType
        
        cloudImg.image = UIImage(named: currentWeather.weatherType)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let foreCast = foreCasts[indexPath.row]
            cell.configureCell(foreCast: foreCast)
            return cell
            
        } else {
            return WeatherCell()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
}

