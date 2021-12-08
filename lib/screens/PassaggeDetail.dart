import 'package:flutter/material.dart';
//import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/screens/pasaggeList.dart';
import 'package:sgmbooking/service/netService.dart';
import 'package:sgmbooking/utils/fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/service/next_screen.dart';
import 'package:sgmbooking/utils/snacbar.dart';
import 'package:sgmbooking/models/passageModel.dart';

class PassageDetail extends StatefulWidget {
  const PassageDetail({Key? key, required this.results}) : super(key: key);

  final ResultsPassage results;

  @override
  _PassageDetailState createState() => _PassageDetailState();
}

class _PassageDetailState extends State<PassageDetail> {
  int _value = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool bookingStart = true;
  bool cancelComplete = false;
  late Origin paradaElgida;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    print(["widget.results.stop:", widget.results.stop.name]);
    _value = widget.results.stop.id;
    paradaElgida = widget.results.stop;
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
            //wdEachRow("id viaje", widget.results.id.toString()),
            wdEachRow("Origen", widget.results.rute.origin.name),
            wdEachRow("Destino", widget.results.rute.destination.name),
            wdEachRow("Parada", widget.results.stop.name),
            wdEachRow(
                "Fecha",
                DateFormat('dd/MM/yy')
                    .format(DateFormat('dd/MM/yy HH:mm')
                        .parse(widget.results.estimatedDeparture))
                    .toString()),
            /*wdEachRow(
                "Fecha fin",
                DateFormat('dd/MM/yy')
                    .format(DateFormat('yyyy-MM-dd')
                        .parse(widget.results.program.endProgram))
                    .toString()),*/
            wdEachRow(
                "Hora de partida",
                DateFormat('HH:mm')
                    .format(DateFormat("dd/MM/yy hh:mm")
                        .parse(widget.results.estimatedDeparture))
                    .toString()),
            wdEachRow(
                "Hora de llegada",
                DateFormat('HH:mm')
                    .format(DateFormat("dd/MM/yy hh:mm")
                        .parse(widget.results.estimatedArrival))
                    .toString()),
            SizedBox(height: 10),
        Visibility(
          visible: widget.results.is_program,
          child: Container(
              width: 160,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              alignment: Alignment.center,
              child: Text("Cancelación", style: black17_54),
            )),
        Visibility(
          visible: widget.results.is_program,
          child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 180,
                    height: 20,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.bottomLeft,
                    child: Text("Cancelar toda la serie?", style: black17_54),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.bottomLeft,
                    width: 160,
                    height: 20,
                    child: Checkbox(
                        checkColor: Colors.red[300],
                        focusColor: Colors.redAccent[400],
                        hoverColor: Colors.redAccent[400],
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                  ),
                ])),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red[400], // fondo
            onPrimary: Colors.white, // letras
          ),
          onPressed: () {
            debugPrint("el boton se apreto");

            cancelTripFromDetails(widget.results.id, isChecked, null);
          },
          child: Text('Cancelar agenda'),
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
            Container(
                child: Text(value,
                    overflow: TextOverflow.ellipsis, style: black16)),
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
          // bookingComplete = true;
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

  cancelTripFromDetails(travelID, deleteAll, delToDate) async {
    NetworkBloc sb = Provider.of<NetworkBloc>(context, listen: false);
    FocusScope.of(context).requestFocus(new FocusNode());
    sb.cancelTrip(travelID, deleteAll, delToDate).then((_) async {
      print(["sb.hasError:", sb.hasError]);
      if (sb.hasError == false) {
        setState(() {
          cancelComplete = true;
        });
        nextScreeniOSReplace(context, PassageList());
      } else {
        setState(() {
          bookingStart = false;
        });

        String errorText =
            "Hubo un error cancelando su reserva - " + sb.errorCode.toString();
        openSnacbar(_scaffoldKey, errorText);
      }
    });
  }
}
