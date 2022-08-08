//
//  Current.swift
//  WeatherApp
//
//  Created by Vu Nam Ha on 05/08/2022.
//

import Foundation
import SwiftyJSON

class Current {

    var data: [Data]?
    var count: Int?

    init(_ json: JSON) {
        data = json["data"].arrayValue.map { Data($0) }
        count = json["count"].intValue
    }

}

class Data {

    var rh: Int?
    var pod: String?
    var lon: Double?
    var pres: Double?
    var timezone: String?
    var obTime: String?
    var countryCode: String?
    var clouds: Int?
    var ts: Int?
    var solarRad: Int?
    var stateCode: String?
    var cityName: String?
    var windSpd: Double?
    var windCdirFull: String?
    var windCdir: String?
    var slp: Int?
    var vis: Int?
    var hAngle: Int?
    var sunset: String?
    var dni: Int?
    var dewpt: Double?
    var snow: Int?
    var uv: Int?
    var precip: Int?
    var windDir: Int?
    var sunrise: String?
    var ghi: Int?
    var dhi: Int?
    var aqi: Int?
    var lat: Double?
    var weather: Weather?
    var datetime: String?
    var temp: Int?
    var station: String?
    var elevAngle: Double?
    var appTemp: Double?

    init(_ json: JSON) {
        rh = json["rh"].intValue
        pod = json["pod"].stringValue
        lon = json["lon"].doubleValue
        pres = json["pres"].doubleValue
        timezone = json["timezone"].stringValue
        obTime = json["ob_time"].stringValue
        countryCode = json["country_code"].stringValue
        clouds = json["clouds"].intValue
        ts = json["ts"].intValue
        solarRad = json["solar_rad"].intValue
        stateCode = json["state_code"].stringValue
        cityName = json["city_name"].stringValue
        windSpd = json["wind_spd"].doubleValue
        windCdirFull = json["wind_cdir_full"].stringValue
        windCdir = json["wind_cdir"].stringValue
        slp = json["slp"].intValue
        vis = json["vis"].intValue
        hAngle = json["h_angle"].intValue
        sunset = json["sunset"].stringValue
        dni = json["dni"].intValue
        dewpt = json["dewpt"].doubleValue
        snow = json["snow"].intValue
        uv = json["uv"].intValue
        precip = json["precip"].intValue
        windDir = json["wind_dir"].intValue
        sunrise = json["sunrise"].stringValue
        ghi = json["ghi"].intValue
        dhi = json["dhi"].intValue
        aqi = json["aqi"].intValue
        lat = json["lat"].doubleValue
        weather = Weather(json["weather"])
        datetime = json["datetime"].stringValue
        temp = json["temp"].intValue
        station = json["station"].stringValue
        elevAngle = json["elev_angle"].doubleValue
        appTemp = json["app_temp"].doubleValue
    }

}


class Weather {

    var icon: String?
    var code: Int?
    var description: String?

    init(_ json: JSON) {
        icon = json["icon"].stringValue
        code = json["code"].intValue
        description = json["description"].stringValue
    }

}
