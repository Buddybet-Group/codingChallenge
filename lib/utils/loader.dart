import 'package:flutter/material.dart';

import 'app.dart';
import 'custom_widgets.dart';

showLoaderDialog({String message = ''}) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularProgressIndicator(
          color: Colors.orange.shade900,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: formFieldLabel(
            label: message == '' ? "Loading..." : message,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: App.context!,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showScreenLoader({String message = ''}) {
  AlertDialog alert = AlertDialog(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircularProgressIndicator(
          color: Colors.orange.shade900,
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: formFieldLabel(
            label: message == '' ? "Loading..." : message,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
  return Container(
    height: MediaQuery.of(App.context!).size.height * 0.8,
    child: Center(
      heightFactor: 1,
      child: alert,
    ),
  );
}
