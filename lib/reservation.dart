import 'package:flutter/material.dart';
import 'package:reservations/add_reservation.dart';
import 'package:reservations/blocs/ReservationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservations/components/CardReservation.dart';
import 'package:reservations/helpers/AlertDialog.dart';
import 'package:reservations/models/reservation.dart';

class ReservationsPage extends StatelessWidget {
  ReservationsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocModel = context.read<ReservationBloc>();
    deleteReservation(String id) {
      showAlertDialog(context, 'Desea eliminar al reservacion',
          () => {blocModel.removeReservation(id), Navigator.of(context).pop()});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservaciones'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            BlocBuilder<ReservationBloc, ListState>(builder: (context, state) {
              if (state is ListLoaded) {
                return Column(
                    children: state.items
                        .map((e) => CardReservation(
                            user: e.user,
                            date: e.date,
                            cancha: e.cancha,
                            onPress: () {
                              return deleteReservation(e.id);
                            }))
                        .toList());
              }
              return null;
            })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return AddReservationsPage();
              }),
            );
          },
          tooltip: 'Increment',
          child: Icon(Icons
              .add)), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
