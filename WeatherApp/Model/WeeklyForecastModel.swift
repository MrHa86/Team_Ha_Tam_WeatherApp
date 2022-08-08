//
//  WeeklyForecastModel.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 05/08/2022.
//


import Foundation
import SwiftyJSON

class WeeklyForecastModel {

    var data: [DataWeekly]?
    var cityName: String?
    var lon: String?
    var timezone: String?
    var lat: String?
    var countryCode: String?
    var stateCode: String?

    init(_ json: JSON) {
        data = json["data"].arrayValue.map { DataWeekly($0) }
        cityName = json["city_name"].stringValue
        lon = json["lon"].stringValue
        timezone = json["timezone"].stringValue
        lat = json["lat"].stringValue
        countryCode = json["country_code"].stringValue
        stateCode = json["state_code"].stringValue
    }

}


class DataWeekly {

    var moonriseTs: Int?
    var windCdir: String?
    var rh: Int?
    var pres: Double?
    var highTemp: Double?
    var sunsetTs: Int?
    var ozone: Int?
    var moonPhase: Double?
    var windGustSpd: Double?
    var snowDepth: Int?
    var clouds: Int?
    var ts: Int?
    var sunriseTs: Int?
    var appMinTemp: Double?
    var windSpd: Double?
    var pop: Int?
    var windCdirFull: String?
    var slp: Double?
    var moonPhaseLunation: Double?
    var validDate: String?
    var appMaxTemp: Double?
    var vis: Double?
    var dewpt: Double?
    var snow: Int?
    var uv: Int?
    var weather: WeatherWeekly?
    var windDir: Int?
    var maxDhi: Any?
    var cloudsHi: Int?
    var precip: Double?
    var lowTemp: Double?
    var maxTemp: Double?
    var moonsetTs: Int?
    var datetime: String?
    var temp: Double?
    var minTemp: Double?
    var cloudsMid: Int?
    var cloudsLow: Int?

    init(_ json: JSON) {
        moonriseTs = json["moonrise_ts"].intValue
        windCdir = json["wind_cdir"].stringValue
        rh = json["rh"].intValue
        pres = json["pres"].doubleValue
        highTemp = json["high_temp"].doubleValue
        sunsetTs = json["sunset_ts"].intValue
        ozone = json["ozone"].intValue
        moonPhase = json["moon_phase"].doubleValue
        windGustSpd = json["wind_gust_spd"].doubleValue
        snowDepth = json["snow_depth"].intValue
        clouds = json["clouds"].intValue
        ts = json["ts"].intValue
        sunriseTs = json["sunrise_ts"].intValue
        appMinTemp = json["app_min_temp"].doubleValue
        windSpd = json["wind_spd"].doubleValue
        pop = json["pop"].intValue
        windCdirFull = json["wind_cdir_full"].stringValue
        slp = json["slp"].doubleValue
        moonPhaseLunation = json["moon_phase_lunation"].doubleValue
        validDate = json["valid_date"].stringValue
        appMaxTemp = json["app_max_temp"].doubleValue
        vis = json["vis"].doubleValue
        dewpt = json["dewpt"].doubleValue
        snow = json["snow"].intValue
        uv = json["uv"].intValue
        weather = WeatherWeekly(json["weather"])
        windDir = json["wind_dir"].intValue
        maxDhi = json["max_dhi"]
        cloudsHi = json["clouds_hi"].intValue
        precip = json["precip"].doubleValue
        lowTemp = json["low_temp"].doubleValue
        maxTemp = json["max_temp"].doubleValue
        moonsetTs = json["moonset_ts"].intValue
        datetime = json["datetime"].stringValue
        temp = json["temp"].doubleValue
        minTemp = json["min_temp"].doubleValue
        cloudsMid = json["clouds_mid"].intValue
        cloudsLow = json["clouds_low"].intValue
    }

}


class WeatherWeekly {

    var icon: String?
    var code: Int?
    var description: String?

    init(_ json: JSON) {
        icon = json["icon"].stringValue
        code = json["code"].intValue
        description = json["description"].stringValue
    }

}
