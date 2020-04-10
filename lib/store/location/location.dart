import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'location.g.dart';

class LocationStore extends _LocationStoreBase with _$LocationStore {
  static LocationStore _instance = LocationStore._();

  factory LocationStore() => _instance;

  LocationStore._();
}

abstract class _LocationStoreBase with Store {
  @observable
  String country = "";

  @observable
  String state = "";

  @observable
  String dist = "";

  @action
  Future getLocation() async {
    try {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();
      print("geolocationStatus : " + geolocationStatus.toString());
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position);

      List<Placemark> placemark = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      country = placemark[0].country;
      state = placemark[0].administrativeArea;
      dist = placemark[0].subAdministrativeArea;
    } catch (e) {
      print("Error in location fetching : " + e.toString());
    }
  }
}
