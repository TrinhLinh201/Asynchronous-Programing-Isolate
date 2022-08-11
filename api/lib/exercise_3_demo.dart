import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Coord {
  final double lon; //vĩ độ
  final double lat; //kinh độ
  Coord(this.lon, this.lat);
  factory Coord.fromJson(Map<String, dynamic> jsonObject) {
    return Coord(jsonObject["lon"] as double, jsonObject["lat"] as double);
  }
}

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;
  Weather(this.id, this.main, this.description, this.icon);
  factory Weather.fromJson(Map<String, dynamic> jsonObject) {
    return Weather(jsonObject["id"] as int, jsonObject['main'] as String,
        jsonObject["description"] as String, jsonObject["icon"] as String);
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int seaLevel;
  final int grndLevel;
  Main(this.temp, this.feelsLike, this.tempMin, this.tempMax, this.pressure,
      this.humidity, this.seaLevel, this.grndLevel);
  factory Main.fromJson(Map<String, dynamic> jsonObject) {
    return Main(
        jsonObject["temp"] as double,
        jsonObject["feels_like"] as double,
        jsonObject["temp_min"] as double,
        jsonObject["temp_max"] as double,
        jsonObject["pressure"] as int,
        jsonObject["humidity"] as int,
        jsonObject["sea_level"] as int,
        jsonObject["grnd_level"] as int);
  }
}

class Wind {
  final double speed;
  final int deg;
  final double gust;
  Wind(this.speed, this.deg, this.gust);
  factory Wind.fromJson(Map<String, dynamic> jsonObject) {
    return Wind(jsonObject["speed"] as double, jsonObject["deg"] as int,
        jsonObject["gust"] as double);
  }
}

class Clouds {
  final int all;
  Clouds(this.all);
  factory Clouds.fromJson(Map<String, int> jsonObject) {
    return Clouds(jsonObject["all"] as int);
  }
}

class Rain {
  final double? time1h;
  final double? time3h;
  Rain({this.time1h, this.time3h});
  factory Rain.fromJson(Map<String, double> jsonObject) {
    if (jsonObject.containsKey("3h")) {
      return Rain(
          time1h: jsonObject["1h"] as double,
          time3h: jsonObject["3h"] as double);
    } else {
      return Rain(time1h: jsonObject["1h"] as double);
    }
  }
}

class Snow {
  final double? time1h;
  final double? time3h;
  Snow({this.time1h, this.time3h});
  factory Snow.fromJson(Map<String, double> jsonObject) {
    if (jsonObject.containsKey("3h")) {
      return Snow(
          time1h: jsonObject["1h"] as double,
          time3h: jsonObject["3h"] as double);
    } else {
      return Snow(time1h: jsonObject["1h"] as double);
    }
  }
}

class Sys {
  final String country;
  final dynamic sunrise;
  final dynamic sunset;
  Sys(this.country, this.sunrise, this.sunset);
}

class Data {
  final Coord coord;
  final Weather weather;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final dynamic condition;
}
