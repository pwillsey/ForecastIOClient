//
//  ForecastIOClient.swift
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

import Foundation
import AFNetworking
import SwiftyJSON

private func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case (.Some(let lhs), .Some(let rhs)):
        return lhs == rhs
    case (.None, .None):
        return true
    default:
        return false
    }
}

extension Forecast : Equatable {}

public func ==(lhs: Forecast, rhs: Forecast) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.timezone == rhs.timezone && lhs.offset == rhs.offset && lhs.currently == rhs.currently && lhs.minutely == rhs.minutely && lhs.hourly == rhs.hourly && lhs.daily == rhs.daily && lhs.flags == rhs.flags && rhs.alerts == lhs.alerts
}

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
    
    public init(
        latitude: Double,
        longitude: Double,
        timezone: String,
        offset: Int? = nil,
        currently: DataPoint? = nil,
        minutely: DataBlock? = nil,
        hourly: DataBlock? = nil,
        daily: DataBlock? = nil,
        alerts: [Alert]? = nil,
        flags: Flags? = nil
        ) {
            self.latitude = latitude
            self.longitude = longitude
            self.timezone = timezone
            self.offset = offset
            self.currently = currently
            self.minutely = minutely
            self.hourly = hourly
            self.daily = daily
            self.alerts = alerts
            self.flags = flags
    }
    
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

extension DataPoint : Equatable {}

public func ==(lhs: DataPoint, rhs: DataPoint) -> Bool {
    return lhs.time == rhs.time && lhs.summary == rhs.summary && lhs.icon == rhs.icon && lhs.sunriseTime == rhs.sunriseTime && lhs.sunsetTime == rhs.sunsetTime && lhs.moonPhase == rhs.moonPhase && lhs.nearestStormDistance == rhs.nearestStormDistance && lhs.nearestStormBearing == rhs.nearestStormBearing && lhs.precipProbability == rhs.precipProbability && lhs.precipType == rhs.precipType && lhs.precipAccumulation == rhs.precipAccumulation && lhs.temperature == rhs.temperature && lhs.temperatureMin == rhs.temperatureMin && lhs.temperatureMinTime == rhs.temperatureMinTime && lhs.temperatureMax == rhs.temperatureMax && lhs.temperatureMaxTime == rhs.temperatureMaxTime && lhs.apparentTemperature == rhs.apparentTemperature && lhs.apparentTemperatureMin == rhs.apparentTemperatureMin && lhs.apparentTemperatureMinTime == rhs.apparentTemperatureMinTime && lhs.apparentTemperatureMax == rhs.apparentTemperatureMax && lhs.apparentTemperatureMaxTime == rhs.apparentTemperatureMaxTime && lhs.dewPoint == rhs.dewPoint && lhs.windSpeed == rhs.windSpeed && lhs.windBearing == rhs.windBearing && lhs.cloudCover == rhs.cloudCover && lhs.humidity == rhs.humidity && lhs.pressure == rhs.pressure && lhs.visibility == rhs.visibility && lhs.ozone == rhs.ozone
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
    
    public init(
        time: Int,
        summary: String? = nil,
        icon: String? = nil,
        sunriseTime: Int? = nil,
        sunsetTime: Int? = nil,
        moonPhase: Double? = nil,
        nearestStormDistance: Double? = nil,
        nearestStormBearing: Double? = nil,
        precipProbability: Double? = nil,
        precipType: PrecipitationType? = nil,
        precipAccumulation: Double? = nil,
        temperature: Double? = nil,
        temperatureMin: Double? = nil,
        temperatureMinTime: Int? = nil,
        temperatureMax: Double? = nil,
        temperatureMaxTime: Double? = nil,
        apparentTemperature: Double? = nil,
        apparentTemperatureMin: Double? = nil,
        apparentTemperatureMinTime: Int? = nil,
        apparentTemperatureMax: Double? = nil,
        apparentTemperatureMaxTime: Int? = nil,
        dewPoint: Double? = nil,
        windSpeed: Double? = nil,
        windBearing: Double? = nil,
        cloudCover: Double? = nil,
        humidity: Double? = nil,
        pressure: Double? = nil,
        visibility: Double? = nil,
        ozone: Double? = nil
        ) {
            self.time = time
            self.summary = summary
            self.icon = icon
            self.sunriseTime = sunriseTime
            self.sunsetTime = sunsetTime
            self.moonPhase = moonPhase
            self.nearestStormDistance = nearestStormDistance
            self.nearestStormBearing = nearestStormBearing
            self.precipProbability = precipProbability
            self.precipType = precipType
            self.precipAccumulation = precipAccumulation
            self.temperature = temperature
            self.temperatureMin = temperatureMin
            self.temperatureMinTime = temperatureMinTime
            self.temperatureMax = temperatureMax
            self.temperatureMaxTime = temperatureMaxTime
            self.apparentTemperature = apparentTemperature
            self.apparentTemperatureMin = apparentTemperatureMin
            self.apparentTemperatureMinTime = apparentTemperatureMinTime
            self.apparentTemperatureMax = apparentTemperatureMax
            self.apparentTemperatureMaxTime = apparentTemperatureMaxTime
            self.dewPoint = dewPoint
            self.windSpeed = windSpeed
            self.windBearing = windBearing
            self.cloudCover = cloudCover
            self.humidity = humidity
            self.pressure = pressure
            self.visibility = visibility
            self.ozone = ozone
    }
    
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

extension DataBlock: Equatable {}

public func ==(lhs: DataBlock, rhs: DataBlock) -> Bool {
    return lhs.summary == rhs.summary && lhs.icon == rhs.icon && lhs.data == rhs.data
}

public struct DataBlock {
    public var summary: String?
    public var icon: String?
    public var data: [DataPoint]?
    
    public init(
        summary: String? = nil,
        icon: String? = nil,
        data: [DataPoint]? = nil
        ) {
            self.summary = summary
            self.icon = icon
            self.data = data
    }
    
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

extension Alert: Equatable {}

public func ==(lhs: Alert, rhs: Alert) -> Bool {
    return lhs.title == rhs.title && lhs.expires == rhs.expires && lhs.description == rhs.description && lhs.uri == rhs.uri
}

public struct Alert {
    public var title: String
    public var expires: Int
    public var description: String
    public var uri: String
    
    public init(
        title: String,
        expires: Int,
        description: String,
        uri: String
        ) {
            self.title = title
            self.expires = expires
            self.description = description
            self.uri = uri
    }
    
    public init(json: JSON) {
        title = json["title"].stringValue
        expires = json["expires"].intValue
        description = json["description"].stringValue
        uri = json["uri"].stringValue
    }
}

extension Flags: Equatable {}

public func ==(lhs: Flags, rhs: Flags) -> Bool {
    return lhs.darkskyUnavailable == rhs.darkskyUnavailable && lhs.darkskyStations == rhs.darkskyStations && lhs.dataPointStations == rhs.dataPointStations && lhs.isdStations == rhs.isdStations && lhs.lampStations == rhs.lampStations && lhs.metarStations == rhs.metarStations && lhs.metnoLicense == rhs.metnoLicense && lhs.sources == rhs.sources && lhs.units == rhs.units
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
    
    public init(
        darkskyUnavailable: String? = nil,
        darkskyStations: [String]? = nil,
        dataPointStations: [String]? = nil,
        isdStations: [String]? = nil,
        lampStations: [String]? = nil,
        metarStations: [String]? = nil,
        metnoLicense: String? = nil,
        sources: [String]? = nil,
        units: Units? = nil
        ) {
            self.darkskyUnavailable = darkskyUnavailable
            self.darkskyStations = darkskyStations
            self.dataPointStations = dataPointStations
            self.isdStations = isdStations
            self.lampStations = lampStations
            self.metarStations = metarStations
            self.metnoLicense = metnoLicense
            self.sources = sources
            self.units = units
    }
    
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

public enum ForecastBlocks: String, CustomStringConvertible {
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
    
    public typealias SuccessClosure = (forecast: Forecast, forecastAPICalls: Int?) -> Void
    public typealias FailureClosure = (error: NSError) -> Void
    
    private let dateFormatter: NSDateFormatter = NSDateFormatter()
    
    private init() {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
    }
    
    /**
        Retrieve a forecast from the present, past or future.
    
        - parameter latitude:        The latitude of the forecast.
        - parameter longitude:       The longitude of the forecast.
        - parameter time:            The time for the forecast, can be in the past or future, no time returns the present.
        - parameter extendHourly:    Return hourly data for the next seven days instead of the next two.
        - parameter exclude:         An array of data blocks to exclude in the response.
        - parameter failure:         Closure called when the request fails.
        - parameter success:         Closure called when the request succeeds.
    */
    public func forecast(latitude: Double, longitude: Double, time: NSDate? = nil, extendHourly: Bool? = nil, exclude: [ForecastBlocks]? = nil, failure: FailureClosure? = nil, success: SuccessClosure? = nil) {
        if ForecastIOClient.apiKey == nil {
            fatalError("Forecast.IO API key not set!")
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
            for (index, block) in (exclude!).enumerate() {
                excludeString += block.rawValue
                excludeString += ((index + 1) != exclude!.count) ? "," : ""
            }
            parameters["exclude"] = excludeString
        }
        
        var path: String = "/forecast/\(ForecastIOClient.apiKey!)/\(latitude),\(longitude)"
        
        if (time != nil) {
            let dateString: String = dateFormatter.stringFromDate(time!)
            let dateComponents: [String] = dateString.componentsSeparatedByString(" ")
            if (dateComponents.count == 2) {
                path += "," + dateComponents.first! + "T" + dateComponents.last!
            }
        }
        
        ForecastIOClient.sessionManager.GET(path, parameters: parameters, success: { (sessionDataTask, responseObject) -> Void in
            var forecastAPICalls: Int? = nil
            if let response: NSHTTPURLResponse = sessionDataTask.response as? NSHTTPURLResponse {
                if let forecastAPICallsString = response.allHeaderFields["X-Forecast-API-Calls"] as? NSString {
                    forecastAPICalls = forecastAPICallsString.integerValue
                }
            }
            
            let forecast: Forecast = Forecast(json: JSON(responseObject))
            
            success?(forecast: forecast, forecastAPICalls: forecastAPICalls)
            }) { (sessionDataTask, error) -> Void in
                print(error.localizedDescription)
                failure?(error: error)
        }
    }
}