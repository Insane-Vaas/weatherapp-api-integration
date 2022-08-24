import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';

class SearchingForecast extends StatefulWidget {
  final String value;
  const SearchingForecast(this.value, {Key? key}) : super(key: key);

  @override
  State<SearchingForecast> createState() => _SearchingForecastState();
}

class _SearchingForecastState extends State<SearchingForecast> {
  var completeData;
  bool valueFetched = false;
  Future<void> getData() async {
    var dio = Dio();
    String? str = dotenv.env['API_KEY'];
    final response1 = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?q=${widget.value}&appid=$str');
    var data = response1.data;
    setState(() {
      completeData = data;
      valueFetched = true;
    });
  }

  Map<String, String> map = {
    'rain': "./images/static/rainy-1.svg",
    'clouds': "./images/static/cloudy.svg",
    'clear': "./images/static/day.svg",
  };

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.grey.shade50,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Weather App",
          textScaleFactor: 1.2,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Text(
            "Future Forecast of ${widget.value}",
            style: const TextStyle(
              color: Colors.black,
            ),
            textScaleFactor: 1.2,
          ),
        ),
      ),
      body: valueFetched == false
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: completeData["cnt"],
              itemBuilder: (context, index) {
                double cel =
                    completeData['list'][index]['main']['temp'] - 273.15;
                double far = (cel * 9) / 5 + 32;
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      "${map[completeData['list'][index]['weather'][0]['main'].toString().toLowerCase()]}",
                    ),
                    title: Text(
                        "${cel.toStringAsFixed(1)}°C/ ${far.toStringAsFixed(1)}°F "),
                    trailing: Text(completeData['list'][index]['dt_txt']),
                  ),
                );
              },
            ),
    );
  }
}
