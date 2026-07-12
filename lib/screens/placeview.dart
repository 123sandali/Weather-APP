import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/astroModel.dart';
import 'package:weather_app/models/autoComplete.dart';
import 'package:weather_app/models/currentWeather.dart';
import 'package:weather_app/models/hourlyWeather.dart';
import 'package:weather_app/services/weather_services.dart';
import 'dart:ui';

class Placeview extends StatefulWidget {
  final AutocompleteModel autocompletes;
  const Placeview({super.key, required this.autocompletes});

  @override
  State<Placeview> createState() => _PlaceviewState();
}

class _PlaceviewState extends State<Placeview> {
  late Future<CurrentWeather?> getCurrentWeather;
  late Future<List<Hourlyweather>> hourlyweatherList;
  late Future<Astromodel?> getAstro;

  void initState() {
    super.initState();
    getCurrentWeather = WeatherServices().getCurrentWeather(
      widget.autocompletes.name,
    );
    hourlyweatherList = WeatherServices().getHourlyWeather(
      widget.autocompletes.name,
    );
    getAstro = WeatherServices().getAstronomyData(widget.autocompletes.name);
  }

  Widget weatherIcon(String iconUrl) {
    final fixedUrl = iconUrl.startsWith('//') ? 'https:$iconUrl' : iconUrl;

    return Image.network(
      fixedUrl,
      width: 95,
      height: 95,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF8FC0F4), Color(0xFF5E7FD8)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: getCurrentWeather,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (snapshot.hasError || snapshot.data == null) {
                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('something went wrong..'),
                            ),
                          );
                        }
                        CurrentWeather currentweather = snapshot.data!;

                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: BackButton(),
                            ),
                            Positioned(
                              left: 5,
                              bottom: 10,
                              child: Row(
                                children: [
                                  weatherIcon(currentweather.condition.icon),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentweather.condition.text,
                                        style: GoogleFonts.cabin(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        widget.autocompletes.name,
                                        style: GoogleFonts.cabin(
                                          fontSize: 55,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 8,
                                  top: 8,
                                ),
                                child: Container(
                                  height: 110,
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${currentweather.temp.round()}°',
                                          style: GoogleFonts.cabin(
                                            fontSize: 30,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        FutureBuilder(
                                          future: getAstro,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasError ||
                                                snapshot.data == null) {
                                              return Text(
                                                'Something went wrong',
                                              );
                                            }
                                            Astromodel astro = snapshot.data!;

                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Sunrise',
                                                      style: GoogleFonts.cabin(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${astro.sunrise}',
                                                      style: GoogleFonts.cabin(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 1,
                                                  height: 25,
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Sunset',
                                                      style: GoogleFonts.cabin(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${astro.sunset}',
                                                      style: GoogleFonts.cabin(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Expanded(
              child: FutureBuilder(
                future: hourlyweatherList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError || snapshot.data == null) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.data!.isEmpty) {
                    return Text('No data');
                  }
                  List<Hourlyweather> hourlyweather = snapshot.data!
                      .where(
                        (element) => element.time.hour > DateTime.now().hour,
                      )
                      .toList();
                  return ListView.builder(
                    reverse: false,
                    itemCount: hourlyweather.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${hourlyweather[index].temp.round()}°',
                                          style: GoogleFonts.cabin(
                                            fontSize: 50,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              hourlyweather[index]
                                                  .condition
                                                  .text,
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.cabin(
                                                fontSize: 11,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('hh:mm a').format(
                                                hourlyweather[index].time,
                                              ),
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.cabin(
                                                fontSize: 11,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  weatherIcon(
                                    hourlyweather[index].condition.icon,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
