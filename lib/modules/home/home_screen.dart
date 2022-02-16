import 'package:coding_chal/modules/home/home_controller.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import '../../global_widgets/bb_result_sheet.dart';
import '../../global_widgets/bb_search_button.dart';

/// Home screen of the app.
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const vSpacing = SizedBox(height: 20);
    const initialSpace = SizedBox(height: 100);
    final textTheme = Theme.of(context).textTheme;
    if (controller.fresh) {
      ever(controller.country, (country) => _showResults(context));
      ever(controller.errorTrigger, (country) => _showSomethingWrong(context));
      controller.fresh = false;
    }
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            initialSpace,
            Text(
              controller.greetingText,
              style: textTheme.bodyLarge,
            ),
            Image.network(
                'https://www.buddybet.com/wp-content/uploads/2021/06/Group-34-300x72.png'),
            vSpacing,
            Text(
              controller.codingChallengeTitle,
              style: textTheme.bodyLarge!.copyWith(fontSize: 20),
            ),
            vSpacing,
            vSpacing,
            Text(
              controller.iGuessDescription,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge!.copyWith(fontSize: 17),
            ),
            vSpacing,
            Text(
              controller.letsTryText,
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge!.copyWith(fontSize: 17, color: Colors.lightBlue),
            ),
            vSpacing,
            TextField(
              decoration: InputDecoration(
                  border: const OutlineInputBorder(), labelText: controller.hintText),
              controller: controller.textController,
              onSubmitted: (text) {
                _showLoadingProgress(context);
                controller.search();
              },
            ),
            vSpacing,
            BBSearchButton(
              buttonTitle: controller.buttonTitle,
              onClick: () {
                _showLoadingProgress(context);
                controller.search();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingProgress(context) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.loading,
      text: controller.guessingText,
    );
  }

  void _showSomethingWrong(context) {
    Navigator.pop(context);
    CoolAlert.show(
      context: context,
      type: CoolAlertType.error,
      title: 'Oops...',
      text: controller.somethingWentWrongText,
      loopAnimation: false,
    );
  }

  void _showResults(context) {
    Navigator.pop(context);
    const decoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ));

    showStickyFlexibleBottomSheet(
      initHeight: 0.45,
      headerHeight: 10,
      isExpand: false,
      context: context,
      decoration: decoration,
      headerBuilder: (c, o) => Container(),
      bodyBuilder: (context, offset) => bbResultSheet(context),
      anchors: [0, 0.5, 1],
    );
  }
}
