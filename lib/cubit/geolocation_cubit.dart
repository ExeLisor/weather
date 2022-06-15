import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
part 'geolocation_state.dart';

class GeolocationCubit extends Cubit<GeolocationState> {
  GeolocationCubit() : super(GeolocationPermission()) {
    checkPermissions();
  }
  checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(GeolocationFailure());
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(GeolocationFailure());
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      emit(GeolocationFailure());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    emit(GeolocationDefinition());
    position();
  }

  position() async {
    final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    Position position = await geolocatorPlatform.getCurrentPosition();
    String latitude = position.latitude.toString();
    String longitude = position.longitude.toString();

    emit(GeolocationDefined(latitude: latitude, longitude: longitude));

    return [latitude, longitude];
  }
}
