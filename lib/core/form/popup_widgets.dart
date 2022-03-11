import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/entity_factory.dart';
import '../form/form_builder.dart';
import '../form/fields_helper.dart';
import '../form/field_builder.dart';

class PopUp {
  static Future EditServerUrl(
    BuildContext context,
  ) async {
    GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    final domainController = TextEditingController();
    final portController = TextEditingController();

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        bool? sslType = true;
        String fulldomain = "";
        String fullport = "";
        domainlistener() {
          fulldomain = ":/" + domainController.text;
        }

        portlistener() {
          fullport = sslType == true ? "https" : "http" + portController.text;
        }

        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            child: FormBuilder(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          "HTTP",
                          textAlign: TextAlign.end,
                          style: GoogleFonts.openSans(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: FieldBuilder(
                          formKey: formKey,
                          attribute: 'switch',
                          type: FieldTypes.SWITCH,
                          defaultValue: sslType,
                          label: "",
                          onChanged: (v) {
                            sslType = v;
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "HTTPS",
                          style: GoogleFonts.openSans(
                              fontSize: 14.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.001),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: TextFormField(
                        onChanged: (v) {
                          portController.addListener(domainlistener);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your main domain",
                          hintStyle: AppStyles.customFontCalibri(context,
                              color: Colors.black12,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal),
                          counterText: "",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.height * 0.001),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: TextFormField(
                        controller: portController,
                        onChanged: (v) {
                          portController.addListener(portlistener);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter port number",
                          hintStyle: AppStyles.customFontCalibri(context,
                              color: Colors.black12,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal),
                          counterText: "",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  fulldomain != ""
                      ? Text(
                          fulldomain + fullport,
                          style: GoogleFonts.openSans(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          scrollable: true,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Cancel",
                    style: AppStyles.customFontCalibri(context,
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    return Navigator.pop(context, 'empty');
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  child: Text(
                    "Save",
                    style: AppStyles.customFontCalibri(context,
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    return Navigator.pop(context, 'empty');
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static Future termsandcondition(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            child: FormBuilder(
              // key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.015),
                          child: Text(
                            "This App uses Read the QR Code.\n\n",
                            textAlign: TextAlign.start,
                            style: AppStyles.customFontCalibri(context,
                                fontSize: AdaptiveTextSize()
                                    .getadaptiveTextSize(context, 12),
                                color: Colors.black54,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          scrollable: true,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01,
              vertical: 0),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstant.whiteColor),
                  ),
                  child: Text(
                    "AGREE",
                    style: AppStyles.customFontCalibri(context,
                        fontSize:
                            AdaptiveTextSize().getadaptiveTextSize(context, 14),
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    return Navigator.pop(context, true);
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static Future logoutPopUp(BuildContext context) async {
    GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: new Text(
            "Are you sure you want to Logout from the application?",
            textAlign: TextAlign.center,
            style: AppStyles.customFontCalibri(context,
                color: ColorConstant.dullColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontFamily: 'Proxima Nova'),
          ),
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    "No",
                    style: AppStyles.customFontCalibri(context,
                        color: ColorConstant.dullColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    return Navigator.pop(context, 'empty');
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                InkWell(
                  child: Text(
                    "Yes",
                    style: AppStyles.customFontCalibri(context,
                        color: ColorConstant.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    return Navigator.pop(context, 'yes');
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static Future deletescanedrecord(
      BuildContext context, String? countId) async {
    GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            countId == "All"
                ? "Are you sure you want to clear $countId scan inventory records?"
                : "Are you sure you want to clear Rec.No:$countId inventory record?",
            textAlign: TextAlign.center,
            style: AppStyles.customFontCalibri(context,
                color: ColorConstant.dullColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontFamily: 'Proxima Nova'),
          ),
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Text(
                    "No",
                    style: AppStyles.customFontCalibri(context,
                        color: ColorConstant.dullColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    return Navigator.pop(context, false);
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                InkWell(
                  child: Text(
                    "Yes",
                    style: AppStyles.customFontCalibri(context,
                        color: ColorConstant.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    return Navigator.pop(context, true);
                  },
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
