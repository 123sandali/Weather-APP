import 'package:weather_app/models/currentWeather.dart';

class AutocompleteModel {
  String name;
  String country;

  AutocompleteModel({required this.name, required this.country});

  factory AutocompleteModel.fromJson(Map<String, dynamic> json) {
    return AutocompleteModel(name: json['name'], country: json['country']);
  }
}
