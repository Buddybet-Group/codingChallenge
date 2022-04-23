import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String value;
  final Color? color;
  final Color? textColor;
  final double? height;
  final void Function()? onTap;
  const SubmitButton(
      {Key? key,
      required this.value,
      this.color,
      this.textColor,
      this.height,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          // boxShadow: [BoxShadow(color: AppColors.black38, blurRadius: 15.0)],
          borderRadius: BorderRadius.circular(5.0),
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     AppColors.submitGradiantColor1,
          //     AppColors.submitGradiantColor2
          //   ],
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black54,
          //     offset: Offset(0, 5),
          //     blurRadius: 6.0,
          //   ),
          // ],
        ),
        child: Text(
          value,
          style: TextStyle(
              color: textColor ?? Colors.white,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              fontSize: 18),
        ),
      ),
    );
  }
}

class PlainSubmitBtn extends StatelessWidget {
  final String value;
  final Color? color;
  final Color? textColor;
  final double? height;
  const PlainSubmitBtn(
      {Key? key, required this.value, this.color, this.textColor, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      alignment: FractionalOffset.center,
      color: color,
      child: Text(
        value,
        style: TextStyle(
            color: textColor,
            letterSpacing: 0.5,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
