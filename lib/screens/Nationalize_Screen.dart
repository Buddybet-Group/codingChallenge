import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../../core/services/locator.dart';
import '../../core/services/navigation/navigation_service.dart';
import '../../core/services/start_view_model.dart';
import '../../core/services/utils.dart';
import '../../core/constants/entity_factory.dart';
import '../../utils/bloc_listener_notifier/code_challenge_bloc.dart';
import '../core/form/field_builder.dart';
import '../core/form/fields/mytext_filed.dart';
import '../core/form/form_builder.dart';
import '../core/form/validators.dart';
import '../core/localization/localization.dart';

class NationalizeScreen extends StatefulWidget {
  const NationalizeScreen({Key? key}) : super(key: key);

  @override
  _NationalizeScreenState createState() => _NationalizeScreenState();
}

class _NationalizeScreenState extends State<NationalizeScreen>
    with TickerProviderStateMixin {
  final NavigationService? navigationService = locator<NavigationService>();
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final TextEditingController nameCtrl = TextEditingController();

  bool isProgrerss = false;
  late List data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getNationalizeName(
    BuildContext context,
    StartUpViewModel? model,
    Map<dynamic, dynamic>? value,
  ) async {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => setState(() {
        isProgrerss = true;
      }),
    );
    print(value);
    await model!.getNationalizeName({
      "name": value!["name"],
    }, context).then((value) async {
      if (model.nationalizeResponse.country!.isEmpty) {
        AppUtils.showToast("Nationalize Name Not Found!", 3);
        setState(() {
          isProgrerss = false;
        });
      } else if (model.nationalizeResponse.name != null &&
          model.nationalizeResponse.name != "null") {
        data = model.nationalizeResponse.country!;
        setState(() {
          isProgrerss = false;
        });
      } else {
        AppUtils.showToast(
            model.nationalizeResponse.name! != null
                ? model.nationalizeResponse.error!
                : AppLocalizations.of(context)!.somethinkwentwrong!,
            3);
        setState(() {
          isProgrerss = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData? mediaQueryData = MediaQuery.of(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<CodeChallengeBloc>(
      builder: (context, codechallengebloc, _) => WillPopScope(
        onWillPop: () async {
          return AppUtils.onBackPressed(context);
        },
        child: ViewModelBuilder<StartUpViewModel>.reactive(
            viewModelBuilder: () {
              return StartUpViewModel();
            },
            onModelReady: (model) async {},
            builder: (context, model, child) {
              return SafeArea(
                child: Scaffold(
                  backgroundColor: ColorConstant.pageColor,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorConstant.appbarColor,
                    centerTitle: true,
                    title: Text(
                      "BuddyBet Coding Challege",
                      // AppLocalizations.of(context)!.dashboard!,
                      style: AppStyles.customFontCalibri(context,
                          color: ColorConstant.whiteColor,
                          fontSize: AdaptiveTextSize()
                              .getadaptiveTextSize(context, 16),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  body: Stack(
                    children: [
                      ListView(
                        children: [
                          FormBuilder(
                            key: formKey,
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: mediaQueryData.size.height * 0.01),
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaQueryData.size.height * 0.02,
                                        vertical:
                                            mediaQueryData.size.height * 0.02),
                                    child: FieldBuilder(
                                      surefixIcon: data.length != 0
                                          ? IconButton(
                                              icon: Icon(
                                                Icons.clear,
                                                color:
                                                    ColorConstant.appbarColor,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  data = [];
                                                  nameCtrl.text = "";
                                                });
                                              },
                                            )
                                          : null,
                                      contentpadding: EdgeInsets.only(
                                          left: mediaQueryData.size.height *
                                              0.02),
                                      enable: true,
                                      controller: nameCtrl,
                                      formKey: formKey,
                                      textAlign: TextAlign.start,
                                      autoFocus: true,
                                      attribute: 'name',
                                      type: FieldTypes.INPUT,
                                      label: isNotNull(
                                          AppLocalizations.of(context)!
                                              .userId!),
                                      labelStyle: AppStyles.customFontCalibri(
                                          context,
                                          color: ColorConstant.dullColor,
                                          fontWeight: FontWeight.w400),
                                      maxLength: 50,
                                      maxLengthEnforced: true,
                                      validators: [
                                        Validators.name_required(),
                                      ],
                                    ),
                                  ),

                                  data.length == 0
                                      ? FieldBuilder(
                                          formKey: formKey,
                                          attribute: 'button',
                                          type: FieldTypes.TEXTICONBUTTON,
                                          TextIcon: Icon(
                                            Icons.navigate_next_outlined,
                                            size: mediaQueryData.size.height *
                                                0.03,
                                            color: ColorConstant.pageColor,
                                          ),
                                          decoration: BoxDecoration(
                                              color: ColorConstant.pageColor),
                                          label: "Submit",
                                          labelStyle: AppStyles
                                              .customFontCalibri(context,
                                                  fontSize: AdaptiveTextSize()
                                                      .getadaptiveTextSize(
                                                          context, 16),
                                                  color:
                                                      ColorConstant.pageColor),
                                          onChanged: (v) async {
                                            if (formKey.currentState!
                                                .saveAndValidate()) {
                                              _getNationalizeName(
                                                  context,
                                                  model,
                                                  formKey.currentState!.value);
                                            }
                                          },
                                        )
                                      : Container(
                                          height: 0.0,
                                          width: 0.0,
                                        ),
                                  isProgrerss == true
                                      ? AppStyles.progress(context)
                                      : Container(width: 0.0, height: 0.0),
                                  // Gaps.vGap(mediaQueryData.size.height * 0.04),
                                ],
                              ),
                            ),
                          ),
                          data.length != 0
                              ? Card(
                                  color: ColorConstant.appbarColor,
                                  elevation: 1.0,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: size.width * 0.01,
                                      vertical: size.width * 0.01),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 5),
                                    // height: mediaQueryData.size.height * 0.01,
                                    color: ColorConstant.appbarColor,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(size.height * 0.03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Name",
                                            style: AppStyles.customFontCalibri(
                                                context,
                                                color: ColorConstant.pageColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          Text(
                                            "${model.nationalizeResponse.name}",
                                            style: AppStyles.customFontCalibri(
                                                context,
                                                color: ColorConstant.pageColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 0.0,
                                  height: 0.0,
                                ),
                          data.length != 0
                              ? SingleChildScrollView(
                                  physics: ScrollPhysics(),
                                  // controller: _controller,
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    // physics: const ClampingScrollPhysics(),
                                    // controller: _controller,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AnimatedSize(
                                        curve: Curves.easeInToLinear,
                                        duration: Duration(seconds: 5),
                                        child: Card(
                                          elevation: 2.0,
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: size.width * 0.01,
                                              vertical: size.width * 0.01),
                                          child: ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        size.width * 0.05,
                                                    vertical:
                                                        size.width * 0.03),
                                            leading: Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Country Id",
                                                    style: AppStyles
                                                        .customFontCalibri(
                                                            context,
                                                            color: ColorConstant
                                                                .dullColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  Text(
                                                    "${data[index]["country_id"]}",
                                                    style: AppStyles
                                                        .customFontCalibri(
                                                            context,
                                                            color: ColorConstant
                                                                .dullColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            trailing: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Probability",
                                                  style: AppStyles
                                                      .customFontCalibri(
                                                          context,
                                                          color: ColorConstant
                                                              .dullColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Text(
                                                  "${data[index]["probability"].toString()}",
                                                  style: AppStyles
                                                      .customFontCalibri(
                                                          context,
                                                          color: ColorConstant
                                                              .dullColor,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width: 0.0,
                                  height: 0.0,
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
