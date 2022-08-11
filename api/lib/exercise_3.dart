import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class Weather {
  final String main;
  final String description;
  Weather(
    this.main,
    this.description,
  );
  factory Weather.fromJson(Map<String, dynamic> jsonObject) {
    return Weather(
        jsonObject['main'] as String, jsonObject["description"] as String);
  }

  void showInf() {
    print("Trạng thái: ${this.main},");
    print("Chi tiết: ${this.description}");
  }
}

class Main {
  final double temp;
  final int humidity;

  Main(this.temp, this.humidity);
  factory Main.fromJson(Map<String, dynamic> jsonObject) {
    return Main(jsonObject["temp"] as double, jsonObject["humidity"] as int);
  }
  void showInf() {
    print("nhiệt độ: ${(this.temp - 273).ceilToDouble()}'C");
    print("độ ẩm: ${this.humidity}%");
  }
}

class Data {
  final Weather weather;
  final Main main;
  final String name;
  Data(this.name, this.main, this.weather);
  factory Data.formJson(Map<String, dynamic> jsonObject) {
    final jsonMain = jsonObject["main"];
    Main main = Main.fromJson(jsonMain);
    final jsonWeather = jsonObject["weather"];
    Weather weather = Weather.fromJson(jsonWeather[0]);

    return Data(jsonObject["name"] as String, main, weather);
  }
  void showInf() {
    print("Tên thành phố: ${this.name}");
    this.main.showInf();
    this.weather.showInf();
  }
}

Map<String, dynamic> convertFromJsonToMap(String jsonString) {
  final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;

  return jsonObject;
}

// Map<String, dynamic> convertFromJsonToObject(String jsonString) {
//   final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
//   return jsonData;
// }

Future<Data> getPostFromBackend(double lon, double lat) async {
  String url =
      "https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=1693e691cc68920dd6ebf412a51f9553";

  final uri = Uri.parse(url);
  try {
    final response = await get(uri);
    final jsonString = response.body;
    final jsonData = convertFromJsonToMap(jsonString);

    //final jsonData2 = jsonData["weather"];
    //final jsonObject = convertFromJsonToObject(jsonData2[0]);
    final Data data = Data.formJson(jsonData);

    return data;
  } catch (e) {
    print(e);
    rethrow;
  }
}

void doSomething(double lon, double lat) async {
  Data data = await getPostFromBackend(lon, lat);
  data.showInf();
}

void main(List<String> args) {
  print("Nhập vào vĩ độ(dạng double): ");
  double lat = double.parse(stdin.readLineSync()!);
  print("Nhập vào kinh độ(dạng double): ");
  double lon = double.parse(stdin.readLineSync()!);
  doSomething(lon, lat);
}
