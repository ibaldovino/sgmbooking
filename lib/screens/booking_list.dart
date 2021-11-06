import 'package:flutter/material.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:intl/intl.dart';
import 'package:sgmbooking/screens/blank_page.dart';
import 'package:sgmbooking/screens/detail_data.dart';
import 'package:sgmbooking/service/netService.dart';
import 'package:provider/provider.dart';
import 'package:sgmbooking/utils/appDrawer.dart';
import 'package:sgmbooking/utils/fonts.dart';
import 'package:sgmbooking/service/next_screen.dart';

class BookingList extends StatefulWidget {
  const BookingList({Key? key}) : super(key: key);

  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  late NetworkBloc _networkBloc;
  bool isLoading = false;
  getBookData() async {
    setState(() {
      isLoading = true;
    });
    await _networkBloc.getBooking();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkBloc = Provider.of<NetworkBloc>(context, listen: false);
    getBookData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Viajes disponibles"),
      ),
      drawer: appDrawer(context),
      body: DoubleBackToCloseApp(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ..._networkBloc.bookData.results
                  .asMap()
                  .map((key, value) => MapEntry(
                      key,
                      GestureDetector(
                        onTap: () {
                          nextScreeniOS(context, DetailData(results: value));
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Container(
                                      child: Text(value.rute.name,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 25))),
                                  Divider(thickness: 0.5, color: Colors.grey),
                                  SizedBox(height: 5),
                                  wdEachRow(
                                      "Fecha",
                                      DateFormat('dd/MM/yy')
                                          .format(DateFormat('dd/MM/yy HH:mm')
                                              .parse(value.estimatedDeparture))
                                          .toString()),
                                  wdEachRow("Origen", value.rute.origin.name),
                                  wdEachRow(
                                      "Destino", value.rute.destination.name),
                                  wdEachRow(
                                      "Salida",
                                      DateFormat('HH:mm')
                                          .format(DateFormat('dd/MM/yy HH:mm')
                                              .parse(value.estimatedDeparture))
                                          .toString()),
                                  wdEachRow(
                                      "Llegada",
                                      DateFormat('HH:mm')
                                          .format(DateFormat('dd/MM/yy HH:mm')
                                              .parse(value.estimatedArrival))
                                          .toString()),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(top: 10, right: 15),
                              child: Text(
                                  "${value.countPassages}/${value.totalCapacity}"),
                            )
                          ],
                        ),
                      )))
                  .values
                  .toList(),
            ],
          ),
        ),
        snackBar: const SnackBar(
          content: Text('Pulse atras nuevamente para salir'),
        ),
      ),
    );
  }

  wdEachRow(String title, String value) {
    return Padding(
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Container(width: 100, child: Text(title, style: black17_54)),
            Container(child: Text(value, style: black16)),
          ],
        ));
  }
}
