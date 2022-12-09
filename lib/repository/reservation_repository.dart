import 'dart:async';

import 'package:reservations/models/reservation.dart';
import 'package:reservations/providers/weather_provider.dart';

abstract class ReservationRepository {
  /// Throws [NetworkException].
  final _controller = StreamController<List<Reservation>>();
  Stream<List<Reservation>> get items => _controller.stream.asBroadcastStream();
  void addToStream(List<Reservation> items) => _controller.sink.add(items);
  Future fetchWeather();
  Future fetchAll();
  Future addOne(Reservation reservation);
  Future removeReservation(id);
}

class ReservationRepositoryImpls extends ReservationRepository {
  WeatherService service = WeatherService();
  List<Reservation> reservations = [];

  Future fetchAll() async {
    return reservations;
  }

  Future fetchWeather() async {
    return service.fetchWeather();
  }

  Future addOne(Reservation reservation) async {
    reservations.add(reservation);
    return reservations;
  }

  Future removeReservation(id) async {
    reservations.removeWhere((element) => element.id == id);
    return reservations;
  }
  // removeReservation(id) {
  // reservations.removeWhere((element) => element.id == id);
  //return reservations;
  //}
}
