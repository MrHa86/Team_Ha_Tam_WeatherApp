//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 05/08/2022.
//

import Foundation
import SwiftyJSON

class HourlyForecast {

    var data: [DataHourly]?
    var cityName: String?
    var lon: String?
    var timezone: String?
    var lat: String?
    var countryCode: String?
    var stateCode: String?

    init(_ json: JSON) {
        data = json["data"].arrayValue.map { DataHourly($0) }
        cityName = json["city_name"].stringValue
        lon = json["lon"].stringValue
        timezone = json["timezone"].stringValue
        lat = json["lat"].stringValue
        countryCode = json["country_code"].stringValue
        stateCode = json["state_code"].stringValue
    }

}


class DataHourly {

    var windCdir: String?
    var rh: Int?
    var pod: String?
    var timestampUtc: String?
    var pres: Int?
    var solarRad: Int?
    var ozone: Double?
    var weather: WeatherHourly?
    var windGustSpd: Double?
    var timestampLocal: String?
    var snowDepth: Int?
    var clouds: Int?
    var ts: Int?
    var windSpd: Double?
    var pop: Int?
    var windCdirFull: String?
    var slp: Int?
    var dni: Int?
    var dewpt: Double?
    var snow: Int?
    var uv: Int?
    var windDir: Int?
    var cloudsHi: Int?
    var precip: Double?
    var vis: Double?
    var dhi: Int?
    var appTemp: Double?
    var datetime: String?
    var temp: Double?
    var ghi: Int?
    var cloudsMid: Int?
    var cloudsLow: Int?

    init(_ json: JSON) {
        windCdir = json["wind_cdir"].stringValue
        rh = json["rh"].intValue
        pod = json["pod"].stringValue
        timestampUtc = json["timestamp_utc"].stringValue
        pres = json["pres"].intValue
        solarRad = json["solar_rad"].intValue
        ozone = json["ozone"].doubleValue
        weather = WeatherHourly(json["weather"])
        windGustSpd = json["wind_gust_spd"].doubleValue
        timestampLocal = json["timestamp_local"].stringValue
        snowDepth = json["snow_depth"].intValue
        clouds = json["clouds"].intValue
        ts = json["ts"].intValue
        windSpd = json["wind_spd"].doubleValue
        pop = json["pop"].intValue
        windCdirFull = json["wind_cdir_full"].stringValue
        slp = json["slp"].intValue
        dni = json["dni"].intValue
        dewpt = json["dewpt"].doubleValue
        snow = json["snow"].intValue
        uv = json["uv"].intValue
        windDir = json["wind_dir"].intValue
        cloudsHi = json["clouds_hi"].intValue
        precip = json["precip"].doubleValue
        vis = json["vis"].doubleValue
        dhi = json["dhi"].intValue
        appTemp = json["app_temp"].doubleValue
        datetime = json["datetime"].stringValue
        temp = json["temp"].doubleValue
        ghi = json["ghi"].intValue
        cloudsMid = json["clouds_mid"].intValue
        cloudsLow = json["clouds_low"].intValue
    }

}


class WeatherHourly {

    var icon: String?
    var code: Int?
    var description: String?

    init(_ json: JSON) {
        icon = json["icon"].stringValue
        code = json["code"].intValue
        description = json["description"].stringValue
    }

}
