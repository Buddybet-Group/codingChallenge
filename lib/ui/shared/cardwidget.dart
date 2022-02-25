import 'package:coding_chal/ui/shared/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String countryvalue;
  final String probabiltyvalue;

  const CardWidget({Key? key, required this.countryvalue, required this.probabiltyvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin10,
      borderOnForeground: true,
      shadowColor: appColor009FDF,
      elevation: 2.0,
      child: Container(
        width: double.infinity,
        padding: padding10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpacing20,
            Text("Country:  " + countryvalue, textAlign: TextAlign.left,
              style: fontFamilyPoppinsRegular),
            verticalSpacing20,
            horizontalDivider,
            verticalSpacing20,
            Text("Probability:  " + probabiltyvalue,
                style: fontFamilyPoppinsRegular),
            verticalSpacing20,
          ],
        ),

      ),
    );
  }
}