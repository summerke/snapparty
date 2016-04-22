//
//  Bar.swift
//  SnapParty
//
//  Created by Max van der Werf on 22/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import Foundation

class Bar
{
    var name:String
    //var licenseholder :String
    var longitude :String
    var latitude :String
    
    
    init(name: String, latitude: String, longitude: String)
    {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        
    }
}