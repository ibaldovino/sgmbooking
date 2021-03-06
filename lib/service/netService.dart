import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgmbooking/models/bookModel.dart';
import 'package:sgmbooking/models/passageModel.dart';
import 'package:sgmbooking/service/my_api.dart';
import 'package:sgmbooking/utils/snacbar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/widgets/framework.dart';

class NetworkBloc extends ChangeNotifier {
  bool _hasError = false;
  bool get hasError => _hasError;

  String? _errorCode;
  String? get errorCode => _errorCode;

  bool _guestUser = false;
  bool get guestUser => _guestUser;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  BookModel _bookData =
      BookModel(count: 0, next: "", previous: "", results: []);
  BookModel get bookData => _bookData;

  PassageModel _passageData =
      PassageModel(count: 0, next: "", previous: "", resultsPassage: []);
  PassageModel get passageData => _passageData;

  Future guestSignout() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool('guest_user', false);
    _guestUser = false;
    notifyListeners();
  }

  Future setSignIn() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('signed_in', true);
    _isSignedIn = true;
    notifyListeners();
  }

  Future signInwithEmailPassword(userEmail, userPassword) async {
    // try {
    print("------------------------005");
    var data = {
      'username': userEmail,
      'password': userPassword,
    };

    var res = await CallApi().postData(data, 'rest/v1/obtain-token/');
    var body = json.decode(utf8.decode(res.bodyBytes));

    print(["login response:", res, body, res.statusCode]);

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);

      var enUser = json.encode(body['pk']);
      var deUser = json.decode(enUser);

      _hasError = false;
      notifyListeners();
    } else if (res.statusCode == 401) {
      _hasError = true;
      _errorCode = body['non_field_errors'];
      notifyListeners();
    } else if (res.statusCode == 400) {
      _hasError = true;
      _errorCode = body['non_field_errors'][0];
    } else {
      _hasError = true;
      if (body['password'] == null)
        _errorCode = body['email'];
      else
        _errorCode = body['password'];
      notifyListeners();
    }
  }

  Future<bool> getBooking() async {
    var res = await CallApi()
        .getDataParameterWithToken('rest/v1/travel/', ""); //?format=json
    if (res.statusCode == 200) {
      var body = json.decode(utf8.decode(res.bodyBytes));
      _bookData = BookModel.fromJson(body);
      print("llegue viajes disponibles");
    }

    notifyListeners();

    return true;
  }

  Future<bool> getPassage() async {
    var res = await CallApi().getDataParameterWithToken(
        'rest/v1/travel-with-passage/', ""); //?format=json
    print("get passage");
    print(res.statusCode);
    if (res.statusCode == 200) {
      var body = json.decode(utf8.decode(res.bodyBytes));
      _passageData = PassageModel.fromJson(body);
    }

    notifyListeners();

    return true;
  }

  Future bookTrip(travelID, stopID, subToAll, subToDate) async {
    // try {
    print("------------------------book trip");

    var data = {
      "travel_id": travelID,
      "stop_id": stopID,
      "subscribe_to_all": subToAll,
      "subscribe_to_date": subToDate
    };
    debugPrint(data.toString());
    var res = await CallApi().postGetDataWithToken(data, 'rest/v1/passenger');
    var body = json.decode(utf8.decode(res.bodyBytes));

    //print(["Booking complete:", res.toString(), body, res.statusCode]);

    if (res.statusCode == 200) {
      /*var reservaDetalle = json.encode(body);
      var resDetail = json.decode(reservaDetalle);*/

      debugPrint(body.toString());

      _hasError = false;
      notifyListeners();
    } else if (res.statusCode == 401) {
      _hasError = true;
      _errorCode = body['detail'];
      errorMessage(_errorCode);
      notifyListeners();
    } else if (res.statusCode == 400) {
      _hasError = true;
      _errorCode = body['detail'];
      //_errorCode = "Ya eres pasajero en este viaje";
      print(["Error numero: ", res.statusCode]);
      print(_errorCode);
    } else if (res.statusCode == 404) {
      _hasError = true;
      _errorCode = body['detail'];
      errorMessage(_errorCode);
    } else {
      _hasError = true;
      if (body['password'] == null)
        _errorCode = body['email'];
      else
        _errorCode = body['password'];
      errorMessage(_errorCode);
      notifyListeners();
    }
  }

  Future cancelTrip(travelID, deleteAll, delToDate) async {
    // try {
    print("------------------------Cancel trip");

    var data = {
      "travel_id": travelID,
      "del_all": deleteAll,
      "del_to_date": delToDate
    };
    debugPrint(data.toString());
    var res =
        await CallApi().postGetDataWithToken(data, 'rest/v1/passenger-remove');

    if (res.bodyBytes.isNotEmpty) {
      var body = json.decode(utf8.decode(res.bodyBytes));

      if (res.statusCode == 200) {
        /*var reservaDetalle = json.encode(bod2y);
      var resDetail = json.decode(reservaDetalle);*/

        debugPrint(body.toString());

        _hasError = false;
        notifyListeners();
      } else if (res.statusCode == 401) {
        _hasError = true;
        _errorCode = body['detail'];
        errorMessage(_errorCode);
        notifyListeners();
      } else if (res.statusCode == 400) {
        _hasError = true;
        _errorCode = body['detail'];
        //_errorCode = "Ya eres pasajero en este viaje";
        print(["Error numero: ", res.statusCode]);
        print(_errorCode);
      } else if (res.statusCode == 404) {
        _hasError = true;
        _errorCode = body['detail'];
        errorMessage(_errorCode);
      } else {
        _hasError = true;
        if (body['password'] == null)
          _errorCode = body['email'];
        else
          _errorCode = body['password'];
        errorMessage(_errorCode);
        notifyListeners();
      }
    }
  }
}
