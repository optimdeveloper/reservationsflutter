import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservations/application/get_it.dart';
import 'package:reservations/models/reservation.dart';
import 'package:reservations/repository/reservation_repository.dart';

class ReservationBloc extends Cubit<ListState> {
  StreamSubscription subscription;
  ReservationBloc()
      : reservationRepository = getIt.get(),
        super(ListLoading()) {}
  final ReservationRepository reservationRepository;
  load() async {
    final items = await reservationRepository.fetchAll();
    emit(ListLoaded(items));
  }

  addOne(Reservation reservation) async {
    final items = await reservationRepository.addOne(reservation);
    emit(ListLoaded(items));
  }

  getWeather(date) async {
    // final weather = await reservationRepository.fetchWeather();
    // final dates = weather['data_3h']['time'].map((item) => item.split(' ')[0]);
    // List<dynamic> filter = [];
    // filter.addAll(dates);
    // filter.retainWhere((value) {
    //   return value.contains(date);
    // });
    // var findKeys = filter.asMap();
    // var keysDays = findKeys.keys.toList();
    // print(keysDays);

    // final second =
    //     weather['data_3h']['precipitation_probability'].map((item) => item);

    // List<dynamic> filter2 = [];
    // filter2.addAll(second);
    // var data = filter2.asMap();
    // var finalprpe = [];
    // var selectedUsers = data.entries.where((u) => keysDays.contains(u.key));
    // selectedUsers.forEach((element) => {finalprpe.add(element.value)});
    // var maxPrecipitation =
    //     finalprpe.reduce((curr, next) => curr > next ? curr : next);
    // print(maxPrecipitation);
  }

  removeReservation(id) async {
    final items = await reservationRepository.removeReservation(id);
    emit(ListLoaded(items));
  }

  subscribe() {
    subscription = reservationRepository.items.listen(
      (items) {
        emit(ListLoaded(items));
      },
      onError: (error) => emit(ListError('$error')),
    );
  }
}

abstract class ListState {
  const ListState();
}

class ListLoading extends ListState {}

class ListError extends ListState {
  final String message;

  const ListError(this.message);
}

class ListLoaded extends ListState {
  final List<Reservation> items;
  ListLoaded(this.items);
}
