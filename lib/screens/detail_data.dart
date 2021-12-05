import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/screens/booking_list.dart';
import 'package:sgmbooking/screens/pasaggeList.dart';
import 'package:sgmbooking/service/netService.dart';
import 'package:sgmbooking/utils/fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/service/next_screen.dart';
import 'package:sgmbooking/utils/snacbar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  bool isChecked = false;
  late DateTime _selectedDate;

  late List<Stops> list_items;
  late Program programa;
  bool _usrSelectedDate = false;
  String _date = DateFormat('dd, MMMM yyyy').format(DateTime.now()).toString();
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    super.initState();
    print(["widget.results.rute.stops:", widget.results.rute.stops]);
    _value = widget.results.rute.stops.first.id;
    list_items = widget.results.rute.stops;
    print(["widget.results.program:", widget.results.program]);
    _valueProgram = widget.results.program.id;
    programa = widget.results.program;
    final DateRangePickerController _controller = DateRangePickerController();
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
            wdEachRow(
                "Fecha ultimo viaje",
                DateFormat('dd/MM/yy')
                    .format(DateFormat('yyyy-MM-dd')
                        .parse(widget.results.program.endProgram))
                    .toString()),
            Container(
              width: 160,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
              alignment: Alignment.center,
              child: Text("Datos para agenda", style: black17_54),
            ),
            //SizedBox(height: 10),

            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: 160,
                    height: 35,
                    alignment: Alignment.bottomLeft,
                    child: Text("Parada donde sube", style: black17_54),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    width: 160,
                    height: 35,
                    alignment: Alignment.topLeft,
                    child: DropdownButton(
                      value: _value,
                      isExpanded: true,
                      items: list_items.map((Stops item) {
                        return DropdownMenuItem<int>(
                          child:
                              //Text('${item.name} - ${item.id}', style: black16),
                              Text(
                            '${item.name}',
                            style: black16,
                            overflow: TextOverflow.fade,
                          ),
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
                ]),

            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 35,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.bottomLeft,
                    child:
                        Text("Agendarse a toda la serie?", style: black17_54),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    alignment: Alignment.topLeft,
                    width: 160,
                    height: 35,
                    child: Checkbox(
                        checkColor: Colors.green[300],
                        focusColor: Colors.green[500],
                        hoverColor: Colors.green[500],
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            _usrSelectedDate = false;
                            print(_usrSelectedDate);
                          });
                        }),
                  ),
                ]),
            Visibility(
                visible: !isChecked,
                child: Container(
                  child: SfDateRangePicker(
                    //onSelectionChanged
                    view: DateRangePickerView.month,

                    selectionMode: DateRangePickerSelectionMode.single,
                    minDate: DateFormat('dd/MM/yy HH:mm')
                        .parse(widget.results.estimatedDeparture),
                    maxDate: DateFormat('yyyy-MM-dd')
                        .parse(widget.results.program.endProgram),
                    onSelectionChanged: selectionChanged,
                  ),
                )),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 100,
        padding: EdgeInsets.only(bottom: 50),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green[350], // fondo
            onPrimary: Colors.white, // letras
          ),
          onPressed: () {
            debugPrint("el boton se apreto");
            if (isChecked == true) {
              bookTripFromDetails(widget.results.id, _value, true, null);
            } else if (isChecked == false && _usrSelectedDate == true) {
              //_date = '"$_date"';
              bookTripFromDetails(widget.results.id, _value, false, _date);
            } else {
              bookTripFromDetails(widget.results.id, _value, false, null);
            }
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
            Container(width: 160, child: Text(title, style: black17_54)),
            Container(child: Text(value, style: black16)),
          ],
        ));
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {
        _date = DateFormat('yyyy-MM-dd').format(args.value).toString();
        //_date = '"$_date"';
        _usrSelectedDate = true;
        print(_date);
        print(_usrSelectedDate.toString());
      });
    });
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
