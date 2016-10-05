//
//  ForecastIOClientTests.swift
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
import XCTest
import ForecastIOClient
import SwiftyJSON
import Nimble

class ForecastIOClientTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testForecastIOStruct() {
        let forecastJson: JSON = [
            "latitude":37.8267,
            "longitude":-122.423,
            "timezone":"America/Los_Angeles",
            "offset":-7,
            "currently":[
                "time":1438744201,
                "summary":"Partly Cloudy",
                "icon":"partly-cloudy-day",
                "nearestStormDistance":1,
                "nearestStormBearing":119,
                "precipIntensity":0,
                "precipProbability":0.1,
                "temperature":64.71,
                "apparentTemperature":64.71,
                "dewPoint":55.2,
                "humidity":0.71,
                "windSpeed":9.56,
                "windBearing":268,
                "visibility":8.94,
                "cloudCover":0.4,
                "pressure":1015.42,
                "ozone":324.01
            ],
            "minutely":[
                "summary":"Partly cloudy for the hour.",
                "icon":"partly-cloudy-day",
                "data":[
                    [
                        "time":1438744200,
                        "precipIntensity":0,
                        "precipProbability":0
                    ]
                ]
            ],
            "hourly":[
                "summary":"Mostly cloudy until tomorrow evening.",
                "icon":"partly-cloudy-day",
                "data":[
                    [
                        "time":1438743600,
                        "summary":"Partly Cloudy",
                        "icon":"partly-cloudy-day",
                        "precipIntensity":0,
                        "precipProbability":0,
                        "temperature":64.99,
                        "apparentTemperature":64.99,
                        "dewPoint":55.11,
                        "humidity":0.7,
                        "windSpeed":9.6,
                        "windBearing":267,
                        "visibility":9.12,
                        "cloudCover":0.4,
                        "pressure":1015.38,
                        "ozone":324.07
                    ],
                ]
            ],
            "daily":[
                "summary":"Mostly cloudy until tomorrow evening.",
                "icon":"partly-cloudy-day",
                "data":[
                    [
                        "time":1438743600,
                        "summary":"Partly Cloudy",
                        "icon":"partly-cloudy-day",
                        "precipIntensity":0,
                        "precipProbability":0,
                        "temperature":64.99,
                        "apparentTemperature":64.99,
                        "dewPoint":55.11,
                        "humidity":0.7,
                        "windSpeed":9.6,
                        "windBearing":267,
                        "visibility":9.12,
                        "cloudCover":0.4,
                        "pressure":1015.38,
                        "ozone":324.07
                    ],
                ]
            ],
            "flags":[
                "sources":[
                    "darksky"
                ],
                "isd-stations":[
                    "724943-99999",
                ],
                "lamp-stations":[
                    "KAPC",
                ],
                "darksky-stations":[
                    "KMUX",
                ],
                "units":"us"
            ]
        ]
        
        let forecast: Forecast = Forecast(json: forecastJson)
        
        expect(forecast.latitude).to(equal(37.8267))
        expect(forecast.longitude).to(equal(-122.423))
        expect(forecast.timezone).to(equal("America/Los_Angeles"))
        expect(forecast.offset).to(equal(-7))
        
        expect(self.dataPointValid(forecast.currently!)).to(beTruthy())
        expect(self.dataBlockValid(forecast.minutely)).to(beTruthy())
        expect(self.dataBlockValid(forecast.hourly)).to(beTruthy())
        expect(self.dataBlockValid(forecast.daily)).to(beTruthy())
        expect(self.flagsValid(forecast.flags)).to(beTruthy())
        // TODO: Add in alerts
    }
    
    // TODO: Add tests for missing temp properties
    func testDataPointStruct() {
        let currentlyJson: JSON = [
            "time":1438744201,
            "summary":"Partly Cloudy",
            "icon":"partly-cloudy-day",
            "sunriseTime":1438744201,
            "sunsetTime":1438744401,
            "moonPhase":0.75,
            "nearestStormDistance":1,
            "nearestStormBearing":119,
            "precipIntensity":0,
            "precipProbability":0.1,
            "precipType":"rain",
            "precipAccumulation":1.0,
            "temperature":64.71,
            "temperatureMin":64.71,
            "temperatureMinTime":1438744201,
            "temperatureMax":64.71,
            "temperatureMaxTime":1438744201,
            "apparentTemperature":64.71,
            "apparentTemperatureMin":63.71,
            "apparentTemperatureMinTime":1438744201,
            "apparentTemperatureMax":65.71,
            "apparentTemperatureMaxTime":1438744201,
            "dewPoint":55.2,
            "humidity":0.71,
            "windSpeed":9.56,
            "windBearing":268,
            "visibility":8.94,
            "cloudCover":0.4,
            "pressure":1015.42,
            "ozone":324.01
        ]
        
        let currently: DataPoint = DataPoint(json: currentlyJson)
        
        expect(currently.time).to(equal(1438744201))
        expect(currently.summary).to(equal("Partly Cloudy"))
        expect(currently.icon).to(equal("partly-cloudy-day"))
        expect(currently.sunriseTime).to(equal(1438744201))
        expect(currently.sunsetTime).to(equal(1438744401))
        expect(currently.moonPhase).to(equal(0.75))
        expect(currently.nearestStormDistance).to(equal(1))
        expect(currently.nearestStormBearing).to(equal(119))
        expect(currently.precipProbability).to(equal(0.1))
        expect(currently.precipType).to(equal(PrecipitationType.Rain))
        expect(currently.precipAccumulation).to(equal(1.0))
        expect(currently.temperature).to(equal(64.71))
        expect(currently.temperatureMin).to(equal(64.71))
        expect(currently.temperatureMinTime).to(equal(1438744201))
        expect(currently.temperatureMax).to(equal(64.71))
        expect(currently.temperatureMaxTime).to(equal(1438744201))
        expect(currently.apparentTemperature).to(equal(64.71))
        expect(currently.apparentTemperatureMin).to(equal(63.71))
        expect(currently.apparentTemperatureMinTime).to(equal(1438744201))
        expect(currently.apparentTemperatureMax).to(equal(65.71))
        expect(currently.apparentTemperatureMaxTime).to(equal(1438744201))
        expect(currently.dewPoint).to(equal(55.2))
        expect(currently.humidity).to(equal(0.71))
        expect(currently.windSpeed).to(equal(9.56))
        expect(currently.windBearing).to(equal(268))
        expect(currently.visibility).to(equal(8.94))
        expect(currently.cloudCover).to(equal(0.4))
        expect(currently.pressure).to(equal(1015.42))
        expect(currently.ozone).to(equal(324.01))
    }
    
    func testDataBlockStruct() {
        let minutelyJson: JSON = [
            "summary":"Partly cloudy for the hour.",
            "icon":"partly-cloudy-day",
            "data":[
                [
                    "time":1438744200,
                    "precipIntensity":0,
                    "precipProbability":0
                ],
                [
                    "time":1438744260,
                    "precipIntensity":0,
                    "precipProbability":0
                ]
            ]
        ]
        
        let minutely: DataBlock = DataBlock(json: minutelyJson)
        
        expect(minutely.summary).to(equal("Partly cloudy for the hour."))
        expect(minutely.icon).to(equal("partly-cloudy-day"))
        expect(minutely.data?.count).to(equal(2))
    }
    
    func testAlertStuct() {
        let alertJson: JSON = [
            "title":"Alert Title",
            "expires":1438744200,
            "description":"Alert description",
            "uri":"http://www.forecastio.com/alert"
        ]
        
        let alert: Alert = Alert(json: alertJson)
        
        expect(alert.title).to(equal("Alert Title"))
        expect(alert.expires).to(equal(1438744200))
        expect(alert.description).to(equal("Alert description"))
        expect(alert.uri).to(equal("http://www.forecastio.com/alert"))
    }
    
    func testFlagsStruct() {
        let flagsJson: JSON = [
            "sources":[
                "nwspa",
                "isd",
                "madis",
                "lamp",
                "darksky"
            ],
            "isd-stations":[
                "724943-99999",
                "999999-23272"
            ],
            "lamp-stations":[
                "KAPC",
                "KCCR",
                "KSFO",
                "KSQL"
            ],
            "darksky-stations":[
                "KMUX",
                "KDAX"
            ],
            "units":"ca"
        ]
        
        let flags: Flags = Flags(json: flagsJson)
        
        expect(flags.sources?.count).to(equal(5))
        expect(flags.sources?[4]).to(equal("darksky"))
        
        expect(flags.isdStations?.count).to(equal(2))
        expect(flags.isdStations?[1]).to(equal("999999-23272"))
        
        expect(flags.lampStations?.count).to(equal(4))
        expect(flags.lampStations?[0]).to(equal("KAPC"))
        
        expect(flags.darkskyStations?.count).to(equal(2))
        expect(flags.darkskyStations?[1]).to(equal("KDAX"))
        
        expect(flags.units).to(equal(Units.Ca))
    }
    
    fileprivate func dataBlockValid(_ dataBlock: DataBlock?) -> Bool {
        return dataBlock?.summary != nil || dataBlock?.icon != nil || dataBlock?.data != nil
    }
    
    fileprivate func dataPointValid(_ dataPoint: DataPoint?) -> Bool {
        return dataPoint!.time > 0 || dataPoint?.summary != nil || dataPoint?.icon != nil || dataPoint?.sunriseTime != nil || dataPoint?.sunsetTime != nil || dataPoint?.moonPhase != nil || dataPoint?.nearestStormDistance != nil || dataPoint?.nearestStormBearing != nil || dataPoint?.precipProbability != nil || dataPoint?.precipType != nil || dataPoint?.precipAccumulation != nil || dataPoint?.temperature != nil || dataPoint?.temperatureMin != nil || dataPoint?.temperatureMinTime != nil || dataPoint?.temperatureMax != nil || dataPoint?.temperatureMaxTime != nil || dataPoint?.apparentTemperature != nil || dataPoint?.apparentTemperatureMin != nil || dataPoint?.apparentTemperatureMinTime != nil || dataPoint?.apparentTemperatureMax != nil || dataPoint?.apparentTemperatureMaxTime != nil || dataPoint?.dewPoint != nil || dataPoint?.windSpeed != nil || dataPoint?.windBearing != nil || dataPoint?.cloudCover != nil || dataPoint?.humidity != nil || dataPoint?.pressure != nil || dataPoint?.visibility != nil || dataPoint?.ozone != nil
    }
    
    fileprivate func alertValid(_ alert: Alert) -> Bool {
        return alert.title != "" || alert.expires != 0 || alert.description != "" || alert.uri != ""
    }
    
    fileprivate func flagsValid(_ flags: Flags?) -> Bool {
        return flags?.sources != nil || flags?.isdStations != nil || flags?.lampStations != nil || flags?.darkskyStations != nil || flags?.darkskyUnavailable != nil || flags?.metnoLicense != nil || flags?.metarStations != nil || flags?.units != nil
    }
}
