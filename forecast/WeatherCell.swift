//
//  WeatherCell.swift
//  forecast
//
//  Created by Rami Baraka on 08/12/16.
//  Copyright © 2016 Rami Baraka. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIMG: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(foreCast: ForeCastModel){
        
        highTemp.text = "\(foreCast.highTemp)℃"
        lowTemp.text = "\(foreCast.lowTemp)℃"
        day.text = foreCast.date
        weatherType.text = foreCast.weatherType
        weatherIMG.image = UIImage(named: foreCast.weatherType + " Mini")
    }



}
