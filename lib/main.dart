import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reservations/application/get_it.dart';
import 'package:reservations/blocs/ReservationBloc.dart';
import 'package:reservations/helpers/reservationobserver.dart';
import 'package:reservations/repository/reservation_repository.dart';
import 'package:reservations/reservation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  registerRepositories();
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: ReservationBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ReservationBloc()..load(),
        child: MaterialApp(
            title: 'Reservations',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: ReservationsPage()));
  }
}
