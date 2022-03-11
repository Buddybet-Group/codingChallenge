import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> confirm(String text,
    {String content = '', String ok = 'OK', String cancel = 'CANCEL'}) async {
  bool? ret = await Get.dialog<bool>(
      AlertDialog(
        title: Text(
          text,
          style: TextStyle(color: Colors.teal),
        ),
        content: content.isEmpty ? null : Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: Get.back,
            style: TextButton.styleFrom(onSurface: Get.theme.accentColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cancel.toUpperCase()),
            ),
          ),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            style: TextButton.styleFrom(onSurface: Get.theme.accentColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ok.toUpperCase()),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      // useRootNavigator: false,
      barrierDismissible: false);
  return ret ?? false;
}

void toast(String? msg, [bool long = false]) {
  debugPrint(msg);
  BotToast.cleanAll();
  BotToast.showCustomText(
      align: Alignment.bottomRight,
      ignoreContentClick: true,
      toastBuilder: (c) {
        delay(long ? 3500 : 2000).then((value) => c());
        return Container(
          margin: const EdgeInsets.all(20),
          child: Card(
              color: Get.theme.backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  msg!,
                  style: TextStyle(
                      fontSize: 16,
                      color: Get.isDarkMode ? Colors.green : Colors.white),
                ),
              )),
        );
      });
}

CancelFunc loader() {
  return BotToast.showLoading(
    allowClick: false,
    animationDuration: Duration(milliseconds: 500),
    animationReverseDuration: Duration(milliseconds: 500),
    backButtonBehavior: BackButtonBehavior.ignore,
    clickClose: false,
    crossPage: true,
  );
}

Future<void> delay(int milli) async {
  await Future.delayed(Duration(milliseconds: milli));
}
