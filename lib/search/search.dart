import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatefulWidget {
  final String value;
  const SearchPage(this.value, {Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var completeData;
  String location = "";
  bool wrongValue = false;
  Future<void> getData() async {
    var dio = Dio();
    int? statusCode;
    String? str = dotenv.env['API_KEY'];
    final response1 = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?q=${widget.value}&appid=$str',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            setState(() {
              statusCode = status;
            });
            return status! < 500;
          },
        ));
    var data = response1.data;
    if (statusCode != 200) {
      wrongValue = true;
    } else {
      setState(() {
        location = widget.value;
        completeData = data;
        completeData == null
            ? cel = 0
            : cel = completeData['main']['temp'] - 273.15;
        completeData == null ? far = 0 : far = (cel * 9) / 5 + 32;
        valueFetched = true;
        showTemp = cel;
        windSpeed = completeData['wind']['speed'].toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Map<String, String> map = {
    'rain': "./images/static/rainy-1.svg",
    'clouds': "./images/static/cloudy.svg",
    "clear": "./images/static/day.svg",
  };

  String windSpeed = "";
  bool valueFetched = false;
  double cel = 0;
  double far = 0;
  double showTemp = 0;
  String val = "°C";
  bool tempConv = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
      ),
      body: wrongValue == true
          ? WrongName(widget.value)
          : valueFetched == false
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(
                    width * 0.03,
                    height * 0.02,
                    width * 0.03,
                    height * 0.02,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.value} Weather",
                        style: const TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            val == "°C"
                                ? "Change Value to °F"
                                : "Change Value to °C",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            textScaleFactor: 1.2,
                          ),
                          Switch(
                            value: tempConv,
                            onChanged: (value) {
                              setState(() {
                                val = (val == "°C") ? "°F" : "°C";
                                tempConv = !tempConv;
                                tempConv == true
                                    ? showTemp = cel
                                    : showTemp = far;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          completeData == null
                              ? const SizedBox()
                              : SvgPicture.asset(
                                  map[completeData['weather'][0]['main']
                                          .toString()
                                          .toLowerCase()]
                                      .toString(),
                                  width: width * 0.5,
                                ),
                          Text(
                            "${showTemp.toStringAsFixed(1)} $val",
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 1.1,
                          ),
                        ],
                      ),
                      Text(
                        completeData['weather'][0]['main'].toString(),
                        style: const TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textScaleFactor: 1.1,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Wind Speed",
                            style: TextStyle(
                              fontSize: 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 1.1,
                          ),
                          Text(
                            windSpeed,
                            style: const TextStyle(
                              fontSize: 27,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textScaleFactor: 1.1,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      const Text(
                        "Check out Future Forecast",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        textScaleFactor: 1.1,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/searchingforecast',
                              arguments: location);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                        ),
                        child: const Text("Search"),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class WrongName extends StatelessWidget {
  final String name;
  const WrongName(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Please Go back and Enter correct city name "$name" is not a valid city name',
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
