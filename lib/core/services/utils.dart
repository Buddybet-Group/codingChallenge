import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/constants/entity_factory.dart';
import 'package:url_launcher/url_launcher.dart';

String isNotNull(dynamic value) {
  if (value != null && value.toString().length > 0) {
    return value;
  }
  return "";
}

class AppIcons {
  static IconData dashboard = Icons.dashboard;
  static IconData customers = Icons.group;
  static IconData settings = Icons.settings;
}

class AppColors {
  static const Color danger = Color(0xFFFF4759);
}

class Toast {
  static show(String msg, {duration = 2000}) {
    showToast(msg,
        position: ToastPosition.bottom,
        textPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        duration: Duration(milliseconds: duration),
        dismissOtherToast: true);
  }

  static cancelToast() {
    dismissAllToast();
  }
}

class AppUtils {
  static Future<File?> getFile(
      {FileType? type, List<String>? extension}) async {
    File? file;
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        PermissionStatus permission = await Permission.storage.status;
        if (permission == PermissionStatus.granted) {
          // file = await FilePicker.platform(
          //     type: type ?? FileType.custom,
          //     allowedExtensions: extension ?? null);
          file = (await FilePicker.platform.pickFiles(
            type: type ?? FileType.custom,
            allowedExtensions: extension ?? ['jpg', 'pdf', 'doc'],
          )) as File?;
          FilePickerResult? result = await FilePicker.platform.pickFiles();
          if (result != null) {
            file = File(result.files.single.path.toString());
          } else {
            // User canceled the picker
          }
        } else {
          await Permission.storage.request();
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return file;
  }

  static Future<bool?> popUpDialog(BuildContext context,
      {String? title, String? description, List<Widget>? items}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title ?? ''),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: items ?? [],
            ),
          ),
        );
      },
    );
  }

  static Future<bool?> showDialogWindow(BuildContext context,
      {String? title, Function? onTapyes, String? success, String? cancel}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title ?? "Do you want to Sign Out?"),
          actions: <Widget>[
            new OutlineButton(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              color: Theme.of(context).primaryColorLight,
              splashColor: Theme.of(context).primaryColorLight,
              child: new Text(
                cancel ?? "No",
                style: AppStyles.customFontCalibri(context, fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            Gaps.vGap(10),
            new OutlineButton(
                color: Theme.of(context).primaryColor,
                splashColor: Theme.of(context).primaryColorLight,
                child: new Text(
                  success ?? "Yes",
                  style: AppStyles.customFontCalibri(context,
                      fontSize: 16, color: AppColors.danger),
                ),
                onPressed: onTapyes as void Function()?)
          ],
        );
      },
    );
  }

  static Future<bool> onBackPressed(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
      return Future.value(false);
    } else {
      return showDialogWindow(
        context,
        title: "Do you want to exit?",
        onTapyes: () {
          Navigator.pop(context, true);
        },
      ).then((value) {
        return value ?? false;
      });
    }
  }

  static floatingActionButton(BuildContext context,
      {required Function onPressed,
      Type? type,
      String? tooltip,
      String? heroTag,
      Widget? child}) {
    return FloatingActionButton(
      heroTag: heroTag ?? 'fabNew',
      key: Key("fabNew"),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: onPressed as void Function()?,
      child: Icon(
        Icons.add,
        size: 18,
        color: Colors.white,
      ),
      tooltip: tooltip ?? 'New',
    );
  }

  static void launchTelURL(String phone) async {
    String url = 'tel:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Dialing failed!');
    }
  }

  static showCallPhoneDialog(BuildContext context, String? phone,
      {Color? color}) {
    return InkWell(
      child: Icon(
        Icons.phone_in_talk,
        size: 20,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        AppUtils.launchTelURL(phone!);
      },
    );
  }

  static void launchMailURL(String phone) async {
    String url = 'mailto:' + phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Toast.show('Mailing failed!');
    }
  }

  static showMailDialog(BuildContext context, String? mail, {Color? color}) {
    return InkWell(
      child: Icon(
        Icons.mail,
        size: 20,
        color: Theme.of(context).iconTheme.color,
      ),
      onTap: () {
        AppUtils.launchMailURL(mail!);
      },
    );
  }

  static showDirection(BuildContext context, String? lat, String? lang) {
    return InkWell(
      child: Icon(Icons.directions,
          size: 20, color: Theme.of(context).iconTheme.color),
      onTap: () {
        // LatLng latlang = new LatLng(double.tryParse(lat), double.tryParse(lang));
        // AppUtils.launchMap(latlang);
      },
    );
  }

  static appBarButton(BuildContext context,
      {required Function onPressed, ButtonType? type}) {
    switch (type) {
      case ButtonType.Save:
        return IconButton(
            icon: Icon(Icons.done), onPressed: onPressed as void Function()?);
        break;
      case ButtonType.Edit:
        return IconButton(
            icon: Icon(Icons.edit), onPressed: onPressed as void Function()?);
        break;
      case ButtonType.Delete:
        return IconButton(
            icon: Icon(Icons.delete), onPressed: onPressed as void Function()?);
        break;
    }
    return Gaps.empty;
  }

  static showDeleteDialog(BuildContext context,
      {required String type, required Function onPressed}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Do you want delete this $type ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: onPressed as void Function()?,
                textColor: AppColors.danger,
                child: Text('Delete'),
              ),
            ],
          );
        });
  }

  static void showToast(String message, int i) {
    if (message != null && message != '') {
      BotToast.showText(
          text: message,
          contentColor: ColorConstant.appbarColor,
          duration: Duration(seconds: i),
          textStyle: TextStyle(
              fontSize: 13, height: 1.5, color: ColorConstant.whiteColor),
          align: Alignment.center);
    }
  }

  static void showNotificationToast(String message) {
    if (message != null && message != '') {
      BotToast.showSimpleNotification(
          title: message,
          backgroundColor: ColorConstant.whiteColor,
          // backgroundColor: Colors.white,
          duration: Duration(seconds: 3),
          titleStyle:
              TextStyle(fontSize: 16, height: 2, color: Color(0XFF24428E))
          // align: Alignment.center
          );
    }
  }
}
