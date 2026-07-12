import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/autoComplete.dart';
import 'package:weather_app/models/currentWeather.dart';
import 'package:weather_app/models/hourlyWeather.dart';
import 'package:weather_app/screens/placeview.dart';
import 'package:weather_app/services/weather_services.dart';

class HomeScreen extends StatefulWidget {
  final CurrentWeather currentweather;
  const HomeScreen({super.key, required this.currentweather});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Hourlyweather>> hourlyweatherList;

  TextEditingController queryController = TextEditingController();
  List<AutocompleteModel> autocompletes = [];
  List<AutocompleteModel> temp = [];

  void initState() {
    super.initState();
    hourlyweatherList = WeatherServices().getHourlyWeather(
      widget.currentweather.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 400,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF8FC0F4), Color(0xFF5E7FD8)],
                            ),
                          ),
                          height: 370,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 300,
                                  // child: Lottie.asset(
                                  //   'assets/lotties/weather.json',
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 37,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 2),
                                          Text(
                                            widget.currentweather.name,
                                            style: GoogleFonts.cabin(
                                              fontSize: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            widget
                                                .currentweather
                                                .condition
                                                .text,
                                            style: GoogleFonts.cabin(
                                              fontSize: 15,
                                              color: Colors.black.withOpacity(
                                                0.7,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 2),
                                          Image.network(
                                            '${widget.currentweather.condition.icon}',
                                            width: 25,
                                            height: 25,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        '${widget.currentweather.temp.round()}°',
                                        style: GoogleFonts.cabin(
                                          fontSize: 60,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.black.withOpacity(
                                        0.4,
                                      ),
                                      child: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 18,
                                      backgroundImage: NetworkImage(
                                        'https://img.freepik.com/free-photo/cute-cartoon-kid-posing-portrait_23-2151870590.jpg?semt=ais_hybrid&w=740&q=80',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black,
                              border: Border.all(width: 1),
                            ),
                            height: 60,
                            width: 360,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.12),
                                ),
                              ),
                              height: 60,
                              width: 360,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 270,
                                      child: TextField(
                                        controller: queryController,
                                        cursorColor: Colors.white,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        onChanged: (value) async {
                                          if (value.isNotEmpty) {
                                            autocompletes =
                                                await WeatherServices()
                                                    .getautoComplete(value);
                                          } else {
                                            autocompletes.clear();
                                          }
                                          //refresh karala rebuild krnna
                                          setState(() {});
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search here',
                                          hintStyle: GoogleFonts.cabin(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (autocompletes.isNotEmpty && queryController.text.isNotEmpty)
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: autocompletes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            autocompletes[index].name,
                            style: GoogleFonts.cabin(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            autocompletes[index].country,
                            style: GoogleFonts.cabin(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Placeview(
                                  autocompletes: autocompletes[index],
                                ),
                              ),
                            );
                            setState(() {
                              queryController.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),

                SizedBox(height: 30),
                Text(
                  'Today',
                  style: GoogleFonts.cabin(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                FutureBuilder(
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
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: hourlyweather.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 8,
                                    sigmaY: 8,
                                  ),
                                  child: Container(
                                    height: 120,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.12),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                        bottom: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            DateFormat(
                                              'hh:mm a',
                                            ).format(hourlyweather[index].time),
                                            // '${hourlyweather[index].time.hour}',
                                            style: GoogleFonts.cabin(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Image.network(
                                            hourlyweather[index].condition.icon,
                                            width: 40,
                                            height: 40,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${hourlyweather[index].temp.round()}°',
                                            style: GoogleFonts.cabin(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
