import 'package:flutter/material.dart';
import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/screens/booking_list.dart';
import 'package:sgmbooking/screens/pasaggeList.dart';
import 'package:sgmbooking/service/netService.dart';
import 'package:sgmbooking/utils/fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/service/next_screen.dart';
import 'package:sgmbooking/utils/snacbar.dart';

class DetailData extends StatefulWidget {
  const DetailData({Key? key, required this.results}) : super(key: key);

  final Results results;

  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  int _value = 0;
  int _valueProgram = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool bookingStart = true;
  bool bookingComplete = false;

  late List<Stops> list_items;
  late Program programa;

  @override
  void initState() {
    super.initState();
    print(["widget.results.rute.stops:", widget.results.rute.stops]);
    _value = widget.results.rute.stops.first.id;
    list_items = widget.results.rute.stops;
    print(["widget.results.program:", widget.results.program]);
    _valueProgram = widget.results.program!.id;
    programa = widget.results.program!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Detalles del viaje"),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          key: formKey,
          children: [
            SizedBox(height: 20),
            wdEachRow("id viaje", widget.results.id.toString()),
            wdEachRow("Origen", widget.results.rute.origin.name),
            wdEachRow("Destino", widget.results.rute.destination.name),
            wdEachRow(
                "Fecha",
                DateFormat('dd/MM/yy')
                    .format(DateFormat('dd/MM/yy HH:mm')
                        .parse(widget.results.estimatedDeparture))
                    .toString()),
            wdEachRow(
                "Fecha fin",
                DateFormat('dd/MM/yy')
                    .format(DateFormat('yyyy-MM-dd')
                        .parse(widget.results.program!.endProgram))
                    .toString()),
            wdEachRow(
                "Hora de partida",
                DateFormat('HH:mm')
                    .format(DateFormat("MM/dd/yy hh:mm")
                        .parse(widget.results.estimatedDeparture))
                    .toString()),
            wdEachRow(
                "Hora de llegada",
                DateFormat('HH:mm')
                    .format(DateFormat("MM/dd/yy hh:mm")
                        .parse(widget.results.estimatedArrival))
                    .toString()),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: Text("Parada donde sube"),
            ),
            Container(
              child: DropdownButton(
                value: _value,
                items: list_items.map((Stops item) {
                  return DropdownMenuItem<int>(
                    child: Text('${item.name} - ${item.id}'),
                    value: item.id,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _value = value as int;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[900], // fondo
            onPrimary: Colors.white, // letras
          ),
          onPressed: () {
            debugPrint("el boton se apreto");
            bookTripFromDetails(widget.results.id, _value, false, null);
          },
          child: Text('Confirmar agenda'),
        ),
      ),
    );
  }

  wdEachRow(String title, String value) {
    return Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(width: 120, child: Text(title, style: black17_54)),
            Container(child: Text(value, style: black16)),
          ],
        ));
  }

  bookTripFromDetails(travelID, stopID, subToAll, subToDate) async {
    NetworkBloc sb = Provider.of<NetworkBloc>(context, listen: false);
    FocusScope.of(context).requestFocus(new FocusNode());
    sb.bookTrip(travelID, stopID, subToAll, subToDate).then((_) async {
      print(["sb.hasError:", sb.hasError]);
      if (sb.hasError == false) {
        setState(() {
          bookingComplete = true;
        });

        nextScreeniOSReplace(context, PassageList());
      } else {
        setState(() {
          bookingStart = false;
        });

        String errorText =
            "Hubo un error con su reserva - " + sb.errorCode.toString();
        openSnacbar(_scaffoldKey, errorText);
      }
    });
  }
}
