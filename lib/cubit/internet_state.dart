part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  @override
  List<Object> get props => [];
}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final bool internetConnected;

  InternetConnected({required this.internetConnected});
  @override
  List<Object> get props => [internetConnected];
}

class InternetDisconnected extends InternetState {}
