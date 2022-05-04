import 'package:flutter/material.dart';

import 'app.dart';

///adds the space between the two columns
///[height] pass the double value

///shows the horizontal divider
Widget divider() => Divider(color: Colors.white, height: 20, thickness: 2);

///Displays a ElevatedButton
///takes [displayName] to display text on button
///takes [onPressedCallback] fires an event when user taps on the button
ElevatedButton buildElevatedButton(displayName, onPressedCallback) {
  return ElevatedButton(onPressed: onPressedCallback, child: Text(displayName));
}

///builds the elevated button with the given [label]
///[label] takes String
///[callback] triggers when user taps on the button
///[backgroundColor] colour of the button
Widget elevatedButton(
    {required String label,
    required Function() callBack,
    required Color backgroundColor}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: backgroundColor, padding: EdgeInsets.all(15)),
    onPressed: callBack,
    child: Text(
      label,
      style: TextStyle(
        letterSpacing: 1.5,
      ),
    ),
  );
}

///displays the span text label
///[nonSpanText] takes the String value
///[spanText] takes the String value
///[onSpanClicked] triggers when user taps on the span text
///[isUnderline] boolean value, which is used to draw the underline for span text
///[spanFontSize] takes the double value
Widget spanTextLabel(String nonSpanText, String spanText, onSpanClicked,
    {bool isUnderline = true, double spanTextFontSize = 14}) {
  return GestureDetector(
    onTap: onSpanClicked,
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(text: nonSpanText, children: [
        TextSpan(
          text: spanText,
          style: TextStyle(
            fontSize: spanTextFontSize,
            decoration:
                isUnderline ? TextDecoration.underline : TextDecoration.none,
          ),
        )
      ]),
    ),
  );
}

///builds the gradient container for appbar
Widget gradientAppBarContainer() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.blue.shade400, Colors.blue.shade800])),
  );
}

///displays the error snackbar with the given [message]
void showErrorSnackBar(String message) {
  ScaffoldMessenger.of(App.context!).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 4),
      elevation: 5.0,
      content: formFieldLabel(label: message, fontSize: 16),
      backgroundColor: Colors.red,
    ),
  );
}

Widget formFieldLabel(
    {required String label,
    double? fontSize,
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.center,
    bool isUnderline = false}) {
  return Text(
    label,
    textAlign: textAlign,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize ?? App.textTheme.subtitle2!.fontSize,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      color: color,
    ),
    softWrap: true,
    maxLines: 2,
  );
}

///Displays the LinearProgressIndicator
Container buildLinearProgressIndicator() {
  return Container(
    margin: EdgeInsets.all(20),
    child: LinearProgressIndicator(),
  );
}

///draws AppBar 8984693524 sima
///takes [label] as parameter for displaying the appbar title
AppBar buildAppBar(String label, {Function()? callback}) {
  return AppBar(
    elevation: 1,
    leading: InkWell(
        child: Icon(Icons.arrow_back, size: 25),
        onTap: () {
          App.pop();
          if (callback != null) callback();
        }),
    title: Text(
      label,
      style: TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: false,
  );
}
