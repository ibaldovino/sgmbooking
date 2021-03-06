import 'package:flutter/material.dart';

void openSnacbar(_scaffoldKey, snacMessage) {
  _scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(
        snacMessage,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Colors.green,
      onPressed: () {},
    ),
  ));
}

void errorMessage(snacMessage) {
  SnackBar(
    content: Container(
      alignment: Alignment.centerLeft,
      height: 60,
      child: Text(
        snacMessage,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    ),
    action: SnackBarAction(
      label: 'Ok',
      textColor: Colors.green,
      onPressed: () {},
    ),
  );
}
