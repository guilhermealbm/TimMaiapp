import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart';
import 'package:tim_maiapp/UserRoute.dart';
import 'UserLocation.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

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
  String _message = 'How many times can you hear "Ela Partiu" until you reach your destination? Enter your destination above and find out';
  
  @override
  Widget build(BuildContext context) {
    getCurrentUserLocation();
    return Scaffold(
      appBar: AppBar(
        title: Text("TimMaiapp"),
      ),
      body: Column(
        children: <Widget>[
          getDestinationTextField(),
          Text("$_message")
        ],
      ),
    );
  }

  Widget getDestinationTextField() {
    return SingleChildScrollView(
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
                  _startPointController.text = place.placeName;
                },
                language: "pt",
                limit: 10,
                country: "BR",
              ),
            ),
          );
          if (await nav == null && _place != null) 
            getUserRouteInSeconds();
        },
        enabled: true,
      ),
    );
  }

  getCurrentUserLocation() async => _location = await UserLocation.getUserLatAndLong();

  getUserRouteInSeconds() async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("yyyy-MM-dd" + "T" + "HH:mm:ss").format(now);
    Tuple2<String, String> _destination = new Tuple2(_place.center.elementAt(1).toString(), _place.center.elementAt(0).toString());
    UserRoute userRoute = await UserLocation.getRoute(_location, _destination, formattedDate, DotEnv().env["here_maps_token"]);
    Duration difference = DateTime.parse(userRoute.routes.elementAt(0).sections.elementAt(0).arrival.time.toString()).difference(now);
    double division = difference.inSeconds/255;
    final repetitions = division.toStringAsFixed(division.truncateToDouble() == division ? 0 : 2);
    setState(() => _message = 'You can hear "Ela Partiu" $repetitions times! Everything is gonna be okay, bud');

  }
  
}