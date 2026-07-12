import 'package:weather_app/models/condition.dart';
import 'package:weather_app/models/currentWeather.dart';

class Hourlyweather {
  Condition condition;
  double temp;
  DateTime time;

  Hourlyweather({
    required this.condition,
    required this.temp,
    required this.time,
  });

  factory Hourlyweather.fromJson(Map<String, dynamic> json) {
    return Hourlyweather(
      condition: Condition.fromJson(json['condition']),
      temp: json['temp_c'],
      time: DateTime.fromMillisecondsSinceEpoch(json['time_epoch'] * 1000),
    );
  }
}
