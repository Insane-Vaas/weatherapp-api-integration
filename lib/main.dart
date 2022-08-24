import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/search/search.dart';

import 'search/forecast.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/searching':
            {
              final String value = settings.arguments as String;
              return MaterialPageRoute(builder: (_) => SearchPage(value));
            }
          case '/searchingforecast':
            {
              final String value = settings.arguments as String;
              return MaterialPageRoute(
                  builder: (_) => SearchingForecast(value));
            }
          default:
            '/';
        }
        return null;
      },
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String cityLocation = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(4),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Please Enter Location",
            style: TextStyle(color: Colors.black),
            textScaleFactor: 1.3,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  cityLocation = value;
                });
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Location",
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (cityLocation == "") {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Search Can not be empty!"),
                  ),
                );
              } else {
                Navigator.pushNamed(context, '/searching',
                    arguments: cityLocation);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black54,
            ),
            child: const Text("Search"),
          ),
        ],
      ),
    );
  }
}
