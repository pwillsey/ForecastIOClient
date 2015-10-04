# ForecastIOClient

[![CI Status](http://img.shields.io/travis/Peter Willsey/ForecastIOClient.svg?style=flat)](https://travis-ci.org/Peter Willsey/ForecastIOClient)
[![Version](https://img.shields.io/cocoapods/v/ForecastIOClient.svg?style=flat)](http://cocoapods.org/pods/ForecastIOClient)
[![License](https://img.shields.io/cocoapods/l/ForecastIOClient.svg?style=flat)](http://cocoapods.org/pods/ForecastIOClient)
[![Platform](https://img.shields.io/cocoapods/p/ForecastIOClient.svg?style=flat)](http://cocoapods.org/pods/ForecastIOClient)

A Swift [forecast.io](https://developer.forecast.io/) API client.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Requires iOS 8+

## Installation

### CocoaPods
ForecastIOClient is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ForecastIOClient"
```
### Carthage

To install add the following line to your Cartfile:

```
github "pwillsey/ForecastIOClient"
```

## Configuration

Import ForecastIOClient and add the following line to your `func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool` method:

```Swift
ForecastIOClient.apiKey = "FORECAST-IO-API-KEY"
```

## Sample Usage

```Swift
ForecastIOClient.sharedInstance.forecast(-75.6046300, longitude: -26.2090000) { (forecast, forecastAPICalls) -> Void in
  // do something with forecast data
}
```

## Author

Peter Willsey, pwillsey@gmail.com

## License

ForecastIOClient is available under the MIT license. See the LICENSE file for more info.
