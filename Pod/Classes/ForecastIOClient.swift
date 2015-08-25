//
//  ForecastIOClient.swift
//  8BitWeather
//
//  Created by Peter Willsey on 8/5/15.
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

import Foundation
import AFNetworking
import SwiftyJSON

public struct Forecast {
    public var latitude: Double
    public var longitude: Double
    public var timezone: String
    public var offset: Int?
    public var currently: DataPoint?
    public var minutely: DataBlock?
    public var hourly: DataBlock?
    public var daily: DataBlock?
    public var alerts: [Alert]?
    public var flags: Flags?
    
    public init(json: JSON) {
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        timezone = json["timezone"].stringValue
        offset = json["offset"].int
        
        if json["currently"].dictionary != nil {
            currently = DataPoint(json: json["currently"])
        }
        if json["minutely"].dictionary != nil {
            minutely = DataBlock(json: json["minutely"])
        }
        if json["hourly"].dictionary != nil {
            hourly = DataBlock(json: json["hourly"])
        }
        if json["daily"].dictionary != nil {
            daily = DataBlock(json: json["daily"])
        }
        
        if json["alerts"].count > 0 {
            alerts = [Alert]()
            for alertJson: JSON in json["alerts"].arrayValue {
                alerts!.append(Alert(json: alertJson))
            }
        }
        
        if json["flags"].dictionary != nil {
            flags = Flags(json: json["flags"])
        }
    }
}

public struct DataPoint {
    public var time: Int
    public var summary: String?
    public var icon: String?
    public var sunriseTime: Int?
    public var sunsetTime: Int?
    public var moonPhase: Double?
    public var nearestStormDistance: Double?
    public var nearestStormBearing: Double?
    public var precipProbability: Double?
    public var precipType: PrecipitationType?
    public var precipAccumulation: Double?
    public var temperature: Double?
    public var temperatureMin: Double?
    public var temperatureMinTime: Int?
    public var temperatureMax: Double?
    public var temperatureMaxTime: Double?
    public var apparentTemperature: Double?
    public var apparentTemperatureMin: Double?
    public var apparentTemperatureMinTime: Int?
    public var apparentTemperatureMax: Double?
    public var apparentTemperatureMaxTime: Int?
    public var dewPoint: Double?
    public var windSpeed: Double?
    public var windBearing: Double?
    public var cloudCover: Double?
    public var humidity: Double?
    public var pressure: Double?
    public var visibility: Double?
    public var ozone: Double?
    
    public init(json: JSON) {
        time = json["time"].intValue
        summary = json["summary"].string
        icon = json["icon"].string
        sunriseTime = json["sunriseTime"].int
        sunsetTime = json["sunsetTime"].int
        moonPhase = json["moonPhase"].double
        nearestStormDistance = json["nearestStormDistance"].double
        nearestStormBearing = json["nearestStormBearing"].double
        precipProbability = json["precipProbability"].double
        precipType = PrecipitationType(rawValue: json["precipType"].stringValue)
        precipAccumulation = json["precipAccumulation"].double
        temperature = json["temperature"].double
        temperatureMin = json["temperatureMin"].double
        temperatureMinTime = json["temperatureMinTime"].int
        temperatureMax = json["temperatureMax"].double
        temperatureMaxTime = json["temperatureMaxTime"].double
        apparentTemperature = json["apparentTemperature"].double
        apparentTemperatureMin = json["apparentTemperatureMin"].double
        apparentTemperatureMinTime = json["apparentTemperatureMinTime"].int
        apparentTemperatureMax = json["apparentTemperatureMax"].double
        apparentTemperatureMaxTime = json["apparentTemperatureMaxTime"].int
        dewPoint = json["dewPoint"].double
        windSpeed = json["windSpeed"].double
        windBearing = json["windBearing"].double
        cloudCover = json["cloudCover"].double
        humidity = json["humidity"].double
        pressure = json["pressure"].double
        visibility = json["visibility"].double
        ozone = json["ozone"].double
    }
}

public struct DataBlock {
    public var summary: String?
    public var icon: String?
    public var data: [DataPoint]?
    
    public init(json: JSON) {
        summary = json["summary"].string
        icon = json["icon"].string
        
        if json["data"].count > 0 {
            data = [DataPoint]()
            for dataPointJson: JSON in json["data"].arrayValue {
                data!.append(DataPoint(json: dataPointJson))
            }
        }
    }
}

public struct Alert {
    public var title: String
    public var expires: Int
    public var description: String
    public var uri: String
    
    public init(json: JSON) {
        title = json["title"].stringValue
        expires = json["expires"].intValue
        description = json["description"].stringValue
        uri = json["uri"].stringValue
    }
}

public struct Flags {
    public var darkskyUnavailable: String?
    public var darkskyStations: [String]?
    public var dataPointStations: [String]?
    public var isdStations: [String]?
    public var lampStations: [String]?
    public var metarStations: [String]?
    public var metnoLicense: String?
    public var sources: [String]?
    public var units: Units?
    
    public init(json: JSON) {
        darkskyUnavailable = json["darksky-unavailable"].string
        
        if json["darksky-stations"].count > 0 {
            darkskyStations = [String]()
            for darkskyStationJson: JSON in json["darksky-stations"].arrayValue {
                darkskyStations!.append(darkskyStationJson.stringValue)
            }
        }
        if json["datapoint-stations"].count > 0 {
            dataPointStations = [String]()
            for dataPointStationJson: JSON in json["datapoint-stations"].arrayValue {
                dataPointStations!.append(dataPointStationJson.stringValue)
            }
        }
        if json["isd-stations"].count > 0 {
            isdStations = [String]()
            for isdStationJson: JSON in json["isd-stations"].arrayValue {
                isdStations!.append(isdStationJson.stringValue)
            }
        }
        if json["lamp-stations"].count > 0 {
            lampStations = [String]()
            for lampStationJson: JSON in json["lamp-stations"].arrayValue {
                lampStations!.append(lampStationJson.stringValue)
            }
        }
        if json["metar-stations"].count > 0 {
            metarStations = [String]()
            for metarStationJson: JSON in json["metar-stations"].arrayValue {
                metarStations!.append(metarStationJson.stringValue)
            }
        }
        
        metnoLicense = json["metno-license"].string
        
        if json["sources"].count > 0 {
            sources = [String]()
            for sourceJson: JSON in json["sources"].arrayValue {
                sources!.append(sourceJson.stringValue)
            }
        }
        
        units = Units(rawValue: json["units"].stringValue)
    }
}

/**
    Units which a forecast's values can be returned in.

    - Us: Imperial units.
    - Si: Metric units.
    - Ca: Metric units with wind speed in KM/H.
    - Uk: (Deprecated) metric units with wind speed in MPH.
    - Uk2: Metric units with wind speed in MPH and nearest storm distance and visibility in miles.
    - Auto: Units selected automatically based on location.
*/
public enum Units: String {
    case Us = "us"
    case Si = "si"
    case Ca = "ca"
    case Uk = "uk"
    case Uk2 = "uk2"
    case Auto = "auto"
}

public enum PrecipitationType: String {
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Hail = "hail"
}

public enum ForecastBlocks: String, Printable {
    case Currently = "currently"
    case Minutely = "minutely"
    case Hourly = "hourly"
    case Daily = "daily"
    case Alerts = "alerts"
    case Flags = "flags"
    
    public var description: String {
        return self.rawValue
    }
}
/**
    A singleton that retrieves forecasts from forecast.io
*/
public class ForecastIOClient {
    public static let sharedInstance: ForecastIOClient = ForecastIOClient()
    
    /// The forecast.io API key to use.
    public static var apiKey: String?
    
    /// The units that will be returned in forecasts.
    public static var units: Units = .Us
    
    /// The language to return forecasts in.
    public static var lang: String = "en"
    
    private static let baseURL: String = "https://api.forecast.io"
    private static let sessionManager: AFHTTPSessionManager = AFHTTPSessionManager(baseURL: NSURL(string: baseURL))
    
    public typealias SuccessClosure = (forecast: Forecast) -> Void
    public typealias FailureClosure = (error: NSError) -> Void
    
    private let dateFormatter: NSDateFormatter = NSDateFormatter()
    
    public init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
    }
    
    /**
        Retrieve a forecast from the present, past or future.
    
        :param: latitude        The latitude of the forecast.
        :param: longitude       The longitude of the forecast.
        :param: time            The time for the forecast, can be in the past or future, no time returns the present.
        :param: extendHourly    Return hourly data for the next seven days instead of the next two.
        :param: exclude         An array of data blocks to exclude in the response.
        :param: failure         Closure called when the request fails.
        :param: success         Closure called when the request succeeds.
    */
    public func forecast(latitude: Double, longitude: Double, time: NSDate? = nil, extendHourly: Bool? = nil, exclude: [ForecastBlocks]? = nil, failure: FailureClosure? = nil, success: SuccessClosure? = nil) {
        if ForecastIOClient.apiKey == nil {
            fatalError("Forecast.IO APIKey not set!")
        }
        
        var parameters = [
            "units" : ForecastIOClient.units.rawValue,
            "lang" : ForecastIOClient.lang
        ]
        
        if extendHourly != nil {
            parameters["extend"] = "hourly"
        }
        
        if exclude != nil {
            var excludeString = ""
            for (index, block) in enumerate(exclude!) {
                excludeString += block.rawValue
                excludeString += ((index + 1) != exclude!.count) ? "," : ""
            }
            parameters["exclude"] = excludeString
        }
        
        var path: String = "/forecast/\(ForecastIOClient.apiKey!)/\(latitude),\(longitude)"
        
        if (time != nil) {
            var dateString: String = dateFormatter.stringFromDate(time!)
            var dateComponents: [String] = dateString.componentsSeparatedByString(" ")
            if (dateComponents.count == 2) {
                path += "," + dateComponents.first! + "T" + dateComponents.last!
            }
        }
        
        ForecastIOClient.sessionManager.GET(path, parameters: parameters, success: { (sessionDataTask, responseObject) -> Void in
            let forecast: Forecast = Forecast(json: JSON(responseObject))
            
            success?(forecast: forecast)
            }) { (sessionDataTask, error) -> Void in
                println(error.localizedDescription)
                failure?(error: error)
        }
    }
}