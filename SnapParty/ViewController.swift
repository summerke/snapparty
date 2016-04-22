//
//  ViewController.swift
//  SnapParty
//
//  Created by Fhict on 08/04/16.
//  Copyright © 2016 Fhict. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //start location manager to find location
    @IBAction func btnCheckin(sender: AnyObject) {
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        //if the user is not logged in it wil get the login page.
        if(!isUserLoggedIn) {
            self.performSegueWithIdentifier("loginView", sender: self)
        }
    }
    //finds and dispays the current location of the user
    func locationManager(manager: CLLocationManager!,
                         didUpdateLocations locations: [CLLocation]!)
    {
        locationManager.stopUpdatingLocation()
        var latestLocation: AnyObject = locations[locations.count - 1]
        //sets all location variables.
       let currentLatitude = String(format: "%.4f",
                               latestLocation.coordinate.latitude)
       let currentLongitude = String(format: "%.4f",
                                latestLocation.coordinate.longitude)
       let currentHorizontalAccuracy = String(format: "%.4f",
                                         latestLocation.horizontalAccuracy)
       let currentAltitude = String(format: "%.4f",
                               latestLocation.altitude)
       let currentVerticalAccuracy = String(format: "%.4f",
                                       latestLocation.verticalAccuracy)
        //for testing it prints the current location
        print(("latitude: \(currentLatitude) longitude: \(currentLongitude)"))
        compareBar()
       
    }
    //displays an error message when no gps is found.
    func locationManager(manager: CLLocationManager!,
                         didFailWithError error: NSError!) {
        
    }
    //todo
    // checks if you are in a bar.
    func compareBar()
    {
        loadJsonData()
    }
    
    //loads all the bars in the database for comparison.
    func loadJsonData()
    {
        let url = NSURL(string: "https://www.maxvdwerf.nl/SnapParty/bars.php")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            do
            {
                if let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data!, 	   options: NSJSONReadingOptions.AllowFragments)
                {
                    self.parseJsonData(jsonObject)
                }
            }
            catch
            {
                print("Error parsing JSON data")
            }
        }
        dataTask.resume();
    }
    //makes the JSON data readable for an array.
    func parseJsonData(jsonObject:AnyObject)
    {
        var bars = [Bar]()
        if let jsonData = jsonObject as? NSArray
        {
            for item in jsonData
            {
                let newBar = Bar(
                    name: item.objectForKey("name") as! String,
                    latitude: item.objectForKey("latitude")as! String,
                    longitude: item.objectForKey("longitude") as! String
           
                )
                bars.append(newBar);
            }
        }
        //for testing purposes it displays all the names of the bars in the database.
       for Bar in bars
       {
        print(("naam locatie:\(Bar.name)"))
        }
    }

    
}

