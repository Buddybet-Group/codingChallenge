import 'package:flutter/material.dart';
import '../../core/constants/entity_factory.dart';

class StateLayout extends StatelessWidget {
  const StateLayout({Key? key, required this.type, this.hintText})
      : super(key: key);

  final StateType type;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return _getWidget(context);
  }

  Widget _getWidget(BuildContext context) {
    if (type == StateType.loading) {
      return Center(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: hintText == null
                  ? MediaQuery.of(context).size.height * 0.75
                  : null,
              child: new CircularProgressIndicator(
                backgroundColor: Color(0xff0D7393),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                hintText ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xff0D7393),
                    fontSize: 14,
                    decoration: TextDecoration.none,
                    fontFamily: "Regular"),
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.no_meals, size: 150),
              Text(
                'No Data Found',
                style: AppStyles.customFontCalibri(context, fontSize: 21),
              ),
            ],
          ));
    }
  }
}
