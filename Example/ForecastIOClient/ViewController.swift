//
//  ViewController.swift
//  ForecastIOClient
//
//  Created by Peter Willsey on 08/07/2015.
//  Copyright (c) 2015 Peter Willsey. All rights reserved.
//

import UIKit
import ForecastIOClient

class ViewController: UIViewController {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherSummaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set forecast.io API Key
        ForecastIOClient.apiKey = "FORECAST-IO-API-KEY"
        // Set units the request will be returned in
        ForecastIOClient.units = Units.Us
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Retrieve current forecast
        ForecastIOClient.sharedInstance.forecast(-75.6046300, longitude: -26.2090000, failure: { (error) in
            let alert: UIAlertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
            }) { (forecast, forecastAPICalls) -> Void in
                if let numberOfAPICalls: Int = forecastAPICalls {
                    print("\(numberOfAPICalls) forecastIO API calls made today!")
                }
                if let currentTemperature: Double = forecast.currently?.temperature {
                    self.temperatureLabel.text = String(Int(round(currentTemperature))) + "°"
                }
                if let weatherSummary: String = forecast.currently?.summary {
                    self.weatherSummaryLabel.text = weatherSummary
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forecastIOButtonTapped(sender: AnyObject) {
        let forecastIOURL: NSURL = NSURL(string: "http://www.forecast.io")!
        UIApplication.sharedApplication().openURL(forecastIOURL)
    }
}

