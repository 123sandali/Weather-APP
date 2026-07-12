import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:weather_app/models/astroModel.dart';
import 'package:weather_app/models/autoComplete.dart';
import 'package:weather_app/models/currentWeather.dart';
import 'package:weather_app/models/hourlyWeather.dart';

class WeatherServices {
  String key = '0f5e8c7726ac429d9cb122906260204&q';

  Future<CurrentWeather?> getCurrentWeather(String query) async {
    final endpoint =
        'http://api.weatherapi.com/v1/current.json?key=$key&q=$query';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      CurrentWeather currentweather = CurrentWeather.fromJson(body);
      return currentweather;
    } else {
      Logger().e(response.statusCode);
      return null;
    }
  }

  Future<List<AutocompleteModel>> getautoComplete(String text) async {
    final endpoint =
        'http://api.weatherapi.com/v1/search.json?key=$key&q=$text';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      Logger().e(result);
      List<AutocompleteModel> autocomplete = result
          .map((data) => AutocompleteModel.fromJson(data))
          .toList();
      return autocomplete;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<Hourlyweather>> getHourlyWeather(String query) async {
    final endpoint =
        'http://api.weatherapi.com/v1/forecast.json?key=${key}=${query}&days=1&aqi=no&alerts=no';

    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> hourlyData = body['forecast']['forecastday'][0]['hour'];
        List<Hourlyweather> hourlyweatherList = hourlyData
            .map((e) => Hourlyweather.fromJson(e))
            .toList();
        return hourlyweatherList;
      } else {
        Logger().e(response.statusCode);
        return [];
      }
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<Astromodel?> getAstronomyData(String query) async {
    final endpoint =
        'http://api.weatherapi.com/v1/astronomy.json?key=${key}&q=${query}';

    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        final astroModel = Astromodel.fromJsom(body['astronomy']['astro']);
        return astroModel;
      } else {
        Logger().e(response.statusCode);
        return null;
      }
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }
}
