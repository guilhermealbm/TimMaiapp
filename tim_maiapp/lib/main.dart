import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'UserLocation.dart';
import 'package:tuple/tuple.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(TimMaiapp());
}

class TimMaiapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TimMaiapp",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _startPointController = TextEditingController();
  Tuple2 _location;
  MapBoxPlace _place;
  @override
  Widget build(BuildContext context) {
    getCurrentUserLocation(_location);
    return Scaffold(
      appBar: AppBar(
        title: Text("TimMaiapp"),
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: CustomTextField(
              hintText: "Enter destination",
              textController: _startPointController,
              onTap: () async {
                var nav = Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapBoxAutoCompleteWidget(
                      apiKey: DotEnv().env["map_box_token"],
                      hint: "Enter destination",
                      onSelect: (place) {
                        _place = place;
                        print(place.center.elementAt(1));
                        print(place.center.elementAt(0));
                        print(place.toJson());
                        _startPointController.text = place.placeName;
                      },
                      language: "pt",
                      limit: 10,
                      country: "BR",
                    ),
                  ),
                );
                if (await nav == null && _place != null) {
                  print("calculate distance!");
                }
              },
              enabled: true,
            ),
          ),
        ],
      ),
    );
  }

  getCurrentUserLocation(Tuple2 _location) async => _location = await UserLocation.getUserLatAndLong();
  
}