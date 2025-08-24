import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
// import 'package:http/http.dart' as http;

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  // Future getCurrentWeather() async {
  //   String cityName = 'London';
  //   http.get(
  //     Uri.parse(
  //       'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=',
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print('Refresh');
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // main card
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '300.67°F',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Icon(
                              Icons.cloud,
                              size: 64,
                              // color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text('Rain', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Weather Forecast',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // weather forecast cards
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecast(
                      time: '00:00',
                      icon: Icons.cloud,
                      temperature: '301.22',
                    ),
                    HourlyForecast(
                      time: '03:00',
                      icon: Icons.sunny,
                      temperature: '275.22',
                    ),
                    HourlyForecast(
                      time: '06:00',
                      icon: Icons.cloud,
                      temperature: '302.22',
                    ),
                    HourlyForecast(
                      time: '09:00',
                      icon: Icons.sunny,
                      temperature: '301.22',
                    ),
                    HourlyForecast(
                      time: '12:00',
                      icon: Icons.cloud,
                      temperature: '301.22',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Additional Information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // additional Information
              const SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfo(
                      icons: Icons.water_drop,
                      text: 'Humidity',
                      value: '94',
                    ),
                    AdditionalInfo(
                      icons: Icons.air,
                      text: 'Wind Speed',
                      value: '7.67',
                    ),
                    AdditionalInfo(
                      icons: Icons.beach_access,
                      text: 'Pressure',
                      value: '1006',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
