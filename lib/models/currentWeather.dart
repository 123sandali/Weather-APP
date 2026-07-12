import 'package:flutter/material.dart';
import 'package:weather_app/models/condition.dart';

class CurrentWeather {
  String name;
  double temp;
  Condition condition;
  CurrentWeather({
    //named argument, use paranthesis{}
    required this.name,
    required this.temp,
    required this.condition,
  });
  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      name: json['location']['name'],
      temp: json['current']['temp_c'],
      condition: Condition.fromJson(json['current']['condition']),
    );
  }
}
