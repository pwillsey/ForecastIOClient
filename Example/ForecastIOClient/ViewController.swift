//
//  ViewController.swift
//  ForecastIOClient
//
//  Copyright (c) 2015 Peter Willsey
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
            let errorDescription = error?.localizedDescription ??  "An Error occurred retrieving weather"
            let alert: UIAlertController = UIAlertController(title: "Error", message: errorDescription, preferredStyle: UIAlertControllerStyle.Alert)
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

