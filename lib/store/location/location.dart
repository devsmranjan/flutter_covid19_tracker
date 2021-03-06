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

  @observable
  bool isLocationEnabled = true;

  @action
  Future getLocation() async {
    try {
      Geolocator geolocator = Geolocator();

      bool _serviceEnabled = await geolocator.isLocationServiceEnabled();

      if (!_serviceEnabled) {
        print(_serviceEnabled);
        isLocationEnabled = false;
      } else {
        isLocationEnabled = true;
        GeolocationStatus _geolocationStatus =
            await geolocator.checkGeolocationPermissionStatus(
                locationPermission: GeolocationPermission.locationWhenInUse);
        print("geolocationStatus : " + _geolocationStatus.toString());

        Position _position = await geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print(_position);

        List<Placemark> placemark = await geolocator.placemarkFromCoordinates(
            _position.latitude, _position.longitude);

        country = placemark[0].country;
        state = placemark[0].administrativeArea;
        dist = placemark[0].subAdministrativeArea;
      }
    } catch (e) {
      print("Error in location fetching : " + e.toString());
    }
  }
}
