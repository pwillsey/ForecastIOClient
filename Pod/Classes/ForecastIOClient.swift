//
//  ForecastIOClient.swift
//  8BitWeather
//
//  Created by Peter Willsey on 8/5/15.
//  Copyright (c) 2015 Peter Willsey. All rights reserved.
//

import Foundation
import AFNetworking
import SwiftyJSON

public struct ForecastIO {
    public var latitude: Double
    public var longitude: Double
    public var timezone: String
    public var offset: String
    public var currently: DataPoint
    public var minutely: DataBlock
    public var hourly: DataBlock
    public var daily: DataBlock
    public var alerts: Array<Alert> = Array()
    public var flags: Flags
    
    public init(json: JSON) {
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
        timezone = json["timezone"].stringValue
        offset = json["offset"].stringValue
        currently = DataPoint(json: json["currently"])
        minutely = DataBlock(json: json["minutely"])
        hourly = DataBlock(json: json["hourly"])
        daily = DataBlock(json: json["daily"])
        
        for alertJson: JSON in json["alerts"].arrayValue {
            alerts.append(Alert(json: alertJson))
        }
        
        flags = Flags(json: json["flags"])
    }
}

public struct DataPoint {
    public var time: Int
    public var summary: String
    public var icon: String
    public var sunriseTime: Int
    public var sunsetTime: Int
    public var moonPhase: Double
    public var nearestStormDistance: Double
    public var nearestStormBearing: Double
    public var precipProbability: Double
    public var precipType: String
    public var precipAccumulation: Double
    public var temperature: Double
    public var temperatureMin: Double
    public var temperatureMinTime: Int
    public var temperatureMax: Double
    public var temperatureMaxTime: Double
    public var apparentTemperature: Double
    public var apparentTemperatureMin: Double
    public var apparentTemperatureMinTime: Int
    public var apparentTemperatureMax: Double
    public var apparentTemperatureMaxTime: Int
    public var dewPoint: Double
    public var windSpeed: Double
    public var windBearing: Double
    public var cloudCover: Double
    public var humidity: Double
    public var pressure: Double
    public var visibility: Double
    public var ozone: Double
    
    public init(json: JSON) {
        time = json["time"].intValue
        summary = json["summary"].stringValue
        icon = json["icon"].stringValue
        sunriseTime = json["sunriseTime"].intValue
        sunsetTime = json["sunsetTime"].intValue
        moonPhase = json["moonPhase"].doubleValue
        nearestStormDistance = json["nearestStormDistance"].doubleValue
        nearestStormBearing = json["nearestStormBearing"].doubleValue
        precipProbability = json["precipProbability"].doubleValue
        precipType = json["precipType"].stringValue
        precipAccumulation = json["precipAccumulation"].doubleValue
        temperature = json["temperature"].doubleValue
        temperatureMin = json["temperatureMin"].doubleValue
        temperatureMinTime = json["temperatureMinTime"].intValue
        temperatureMax = json["temperatureMax"].doubleValue
        temperatureMaxTime = json["temperatureMaxTime"].doubleValue
        apparentTemperature = json["apparentTemperature"].doubleValue
        apparentTemperatureMin = json["apparentTemperatureMin"].doubleValue
        apparentTemperatureMinTime = json["apparentTemperatureMinTime"].intValue
        apparentTemperatureMax = json["apparentTemperatureMax"].doubleValue
        apparentTemperatureMaxTime = json["apparentTemperatureMaxTime"].intValue
        dewPoint = json["dewPoint"].doubleValue
        windSpeed = json["windSpeed"].doubleValue
        windBearing = json["windBearing"].doubleValue
        cloudCover = json["cloudCover"].doubleValue
        humidity = json["humidity"].doubleValue
        pressure = json["pressure"].doubleValue
        visibility = json["visibility"].doubleValue
        ozone = json["visibility"].doubleValue
    }
}

public struct DataBlock {
    public var summary: String
    public var icon: String
    public var data: Array<DataPoint> = Array()
    
    public init(json: JSON) {
        summary = json["summary"].stringValue
        icon = json["icon"].stringValue
        
        for dataPointJson: JSON in json["data"].arrayValue {
            data.append(DataPoint(json: dataPointJson))
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
    public var darkskyStations: Array<String> = Array()
    public var dataPointStations: Array<String> = Array()
    public var isdStations: Array<String> = Array()
    public var lampStations: Array<String> = Array()
    public var metarStations: Array<String> = Array()
    public var metnoLicense: String
    public var sources: Array<String> = Array()
    public var units: ForecastIOUnits
    
    public init(json: JSON) {
        darkskyUnavailable = json["darksky-unavailable"].string
        
        for darkskyStationJson: JSON in json["darksky-stations"].arrayValue {
            darkskyStations.append(darkskyStationJson.stringValue)
        }
        for dataPointStationJson: JSON in json["datapoint-stations"].arrayValue {
            dataPointStations.append(dataPointStationJson.stringValue)
        }
        for isdStationJson: JSON in json["isd-stations"].arrayValue {
            isdStations.append(isdStationJson.stringValue)
        }
        for lampStationJson: JSON in json["lamp-stations"].arrayValue {
            lampStations.append(lampStationJson.stringValue)
        }
        for metarStationJson: JSON in json["metar-stations"].arrayValue {
            metarStations.append(metarStationJson.stringValue)
        }
        
        metnoLicense = json["metno-license"].stringValue
        
        for sourceJson: JSON in json["sources"].arrayValue {
            sources.append(sourceJson.stringValue)
        }
        if let unitValue = ForecastIOUnits(rawValue: json["units"].stringValue) {
            units = unitValue
        } else {
            units = .us
        }
    }
}

public enum ForecastIOUnits: String {
    case us = "us"
    case si = "si"
    case ca = "ca"
    case uk = "uk"
    case uk2 = "uk2"
}

public enum ForecastIOBlocks: String, Printable {
    case currently = "currently"
    case minutely = "minutely"
    case hourly = "hourly"
    case daily = "daily"
    case alerts = "alerts"
    case flags = "flags"
    
    public var description: String {
        return self.rawValue
    }
}

public class ForecastIOClient {
    public static let sharedInstance: ForecastIOClient = ForecastIOClient()
    public static var apiKey: String?
    public static var units: ForecastIOUnits = .us
    public static var lang: String = "en"
    
    private static let baseURL: String = "https://api.forecast.io"
    private static let sessionManager: AFHTTPSessionManager = AFHTTPSessionManager(baseURL: NSURL(string: baseURL))
    
    public func currentForecast(latitude: Double, longitude: Double, extendHourly: Bool? = nil, exclude: [ForecastIOBlocks]? = nil, failure: ((error: NSError) -> Void)? = nil, success: ((forecast: ForecastIO) -> Void)? = nil) {
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
        
        let path: String = "/forecast/\(ForecastIOClient.apiKey!)/\(latitude),\(longitude)"
        
        println("\(path)")
        
        ForecastIOClient.sessionManager.GET(path, parameters: parameters, success: { (sessionDataTask, responseObject) -> Void in
            let forecast: ForecastIO = ForecastIO(json: JSON(responseObject))
            
            success?(forecast: forecast)
        }) { (sessionDataTask, error) -> Void in
            println(error.localizedDescription)
            failure?(error: error)
        }
    }
}