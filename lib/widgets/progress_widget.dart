import 'package:flutter/material.dart';

class ProgressWidget extends StatefulWidget {
  final double possibility;

  const ProgressWidget(this.possibility, {Key? key}) : super(key: key);

  @override
  ProgressWidgetState createState() => ProgressWidgetState();
}

class ProgressWidgetState extends State<ProgressWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
          height: 45.0,
          width: 45.0,
          child: CircularProgressIndicator(
            color: const Color(0xff0000CD).withOpacity(0.5),
            strokeWidth: 5.0,
            value: widget.possibility,
            backgroundColor: Colors.blue.withOpacity(0.3),
          )),
      Material(
          type: MaterialType.transparency,
          child: Text(
            (widget.possibility * 100).toInt().toString() + '%',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ))
    ]);
  }
}
