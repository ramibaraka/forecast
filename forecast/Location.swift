//
//  Location.swift
//  forecast
//
//  Created by Rami Baraka on 08/12/16.
//  Copyright © 2016 Rami Baraka. All rights reserved.
//

import Foundation
import CoreLocation


class Location {
    
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
