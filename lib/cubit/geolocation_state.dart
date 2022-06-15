part of 'geolocation_cubit.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationPermission extends GeolocationState {}

class GeolocationDefinition extends GeolocationState {}

class GeolocationFailure extends GeolocationState {}

class GeolocationDefined extends GeolocationState {
  final String longitude;
  final String latitude;

  const GeolocationDefined({required this.latitude, required this.longitude});
  @override
  List<Object> get props => [latitude, longitude];
}
