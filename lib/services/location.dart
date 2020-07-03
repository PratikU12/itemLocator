import 'package:geolocator/geolocator.dart';
import 'package:android_intent/android_intent.dart';


getLocation() async {

  Geolocator geolocator = Geolocator()..forceAndroidLocationManager=true;
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: 'en');
  Placemark dbDetails = placemark.first;
  print(dbDetails.subLocality);
  return dbDetails.subLocality;
}