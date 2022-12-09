import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reservations/blocs/ReservationBloc.dart';
import 'package:reservations/components/AlertDialogCard.dart';
import 'package:reservations/components/CardReservation.dart';
import 'package:reservations/components/RoundedTextBox.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:reservations/consts.dart';
import 'package:reservations/helpers/AlertDialog.dart';
import 'package:reservations/helpers/ramdom.dart';
import 'package:reservations/models/reservation.dart';

class AddReservationsPage extends StatefulWidget {
  const AddReservationsPage({Key key}) : super(key: key);
  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationsPage> {
  TextEditingController _user = TextEditingController();
  String _fecha = 'Fecha';
  String court = 'Cancha A';

  var reserv = <Reservation>[];
  var items = [
    'Cancha A',
    'Cancha B',
    'Cancha C',
  ];

  @override
  Widget build(BuildContext context) {
    final blocModel = context.read<ReservationBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Reservación'),
      ),
      body: _body(blocModel),
    );
  }

  Widget _body(ListState state) {
    if (state is ListError) {
      return Text(state.message);
    }

    if (state is ListLoaded) {
      return Center(
        child: Container(
            margin:
                const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Probabilidad de lluvia: ' + '%',
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ],
                ),
                Flexible(
                  flex: 1,
                  child: ListView(
                    children: <Widget>[
                      RoundedTextBox(
                        text: 'Nombre del usuario',
                        controller: _user,
                      ),
                      DropdownButton(
                        value: court,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        style: const TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                        isExpanded: true,
                        onChanged: (String newValue) {
                          setState(() {});
                          court = newValue;
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          DatePicker.showDatePicker(context,
                              theme: DatePickerTheme(
                                containerHeight: 210.0,
                              ),
                              showTitleActions: true,
                              minTime: DateTime(2022, 7, 12),
                              maxTime: DateTime(2024, 6, 7),
                              onChanged: (date) {}, onConfirm: (date) {
                            print('confirm $date');
                            if (date.day.toString().length == 1) {
                              _fecha =
                                  '${date.year}-${date.month}-0${date.day}';
                            } else {
                              _fecha = '${date.year}-${date.month}-${date.day}';
                            }

                            reserv = state.items
                                .where((element) =>
                                    element.date == _fecha &&
                                    element.cancha == court)
                                .toList();
                            context.read<ReservationBloc>().getWeather(_fecha);
                            if (reserv.length == 3) {
                              _fecha = "Fecha";
                              showAlertDialog(
                                  context,
                                  'No hay disponibilidad para ese dia elija otra fecha',
                                  () => Navigator.of(context).pop());
                            }
                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.date_range,
                                          size: 18.0,
                                          color: kPrimaryColor,
                                        ),
                                        Text(
                                          " $_fecha",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Seleccionar",
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (_fecha == 'Fecha' || _user.text == '') {
                                showAlertDialog(
                                    context,
                                    'Falta llenar campos',
                                    () => {
                                          Navigator.of(context).pop(),
                                        });

                                return;
                              }
                              context.read<ReservationBloc>().addOne(
                                  Reservation(
                                      id: getRandomString(15),
                                      user: _user.text,
                                      date: _fecha,
                                      cancha: court));
                              showAlertDialog(
                                  context,
                                  'Se ha realizado la reservación',
                                  () => {
                                        Navigator.of(context).pop(),
                                        _fecha = 'Fecha',
                                        _user.text = '',
                                        setState(() {})
                                      });
                            },
                            child: Text(
                              'Guardar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: kFontMedium,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      );
    }
  }
}
