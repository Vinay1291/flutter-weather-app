import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'London';
      final weatherResult = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      final data = jsonDecode(weatherResult.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occured';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

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
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];

          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp k',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                                // color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentSky,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // weather forecast cards
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForecastData = data['list'][1 + index];
                      final hourlyTime = hourlyForecastData['dt_txt'];
                      final time = DateTime.parse(hourlyTime);
                      final hourlyTemp = hourlyForecastData['main']['temp']
                          .toString();
                      final hourlySky =
                          hourlyForecastData['weather'][0]['main'];
                      return HourlyForecast(
                        time: DateFormat.j().format(time),
                        temperature: hourlyTemp,
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // additional Information
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfo(
                        icons: Icons.water_drop,
                        text: 'Humidity',
                        value: currentHumidity.toString(),
                      ),
                      AdditionalInfo(
                        icons: Icons.air,
                        text: 'Wind Speed',
                        value: currentWindSpeed.toString(),
                      ),
                      AdditionalInfo(
                        icons: Icons.beach_access,
                        text: 'Pressure',
                        value: currentPressure.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
