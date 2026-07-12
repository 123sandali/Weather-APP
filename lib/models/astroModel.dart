class Astromodel {
  String sunset;
  String sunrise;

  Astromodel({required this.sunrise, required this.sunset}) {}

  factory Astromodel.fromJsom(Map<String, dynamic> json) {
    return Astromodel(sunrise: json['sunrise'], sunset: json['sunset']);
  }
}
