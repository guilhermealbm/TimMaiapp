import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'UserLocation.dart';

void main() => runApp(TimMaiapp());

class TimMaiapp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    Tuple2 _location;
    getUserLocation(_location);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("TimMaiapp"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Your lat and long is:"),
              Text(_location.item1),
              Text(_location.item2)
            ],
          ),
        ),
      ),
    );
  }

  getUserLocation(Tuple2 _location) async => _location = await UserLocation.getUserLatAndLong();

}