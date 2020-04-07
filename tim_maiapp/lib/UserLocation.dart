import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:tim_maiapp/UserRoute.dart' as UserRoute;
import 'package:tuple/tuple.dart';

class UserLocation {

  static Future<Tuple2<String, String>> getUserLatAndLong() async{
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return new Tuple2("Couldn't get user's latitude", "Couldn't get user's longitude");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return new Tuple2("Couldn't get user's latitude", "Couldn't get user's longitude");
      }
    }

    _locationData = await location.getLocation();
    return new Tuple2(_locationData.latitude.toString(), _locationData.longitude.toString());
  }

  static Future<UserRoute.UserRoute> getRoute(Tuple2<String, String> origin, Tuple2<String, String> destination, String time, String apiKey) async {
    try {
      Response response = await Dio().get("https://router.hereapi.com/v8/routes?transportMode=car&origin="+
        origin.item1+","+origin.item2+"&destination="+destination.item1+","+destination.item2+
        "&departureTime="+time+"&apiKey="+apiKey);
      if (response != null && response.statusCode == 200)
        return UserRoute.UserRoute.fromJson(response.data);
        
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

}