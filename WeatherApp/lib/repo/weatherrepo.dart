import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:WeatherApp/model/Weather.dart';

class WeatherRepo{
  
  Future<WeatherInfoMain> getWeatherInfo(String lat,String lon) async {
    final response=await http.get("http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=d1db196f38034df64c20931d5e8a855b");
    var jsonWeather=jsonDecode(response.body);
  return WeatherInfoMain.fromJson(jsonWeather["main"]);
  }

}