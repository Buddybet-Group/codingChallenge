import 'package:coding_chal/data/remote/response/status.dart';
import 'package:coding_chal/util/validator.dart';
import 'package:coding_chal/viewmodel/nationality_checker_vm.dart';
import 'package:coding_chal/widget/nationality_result_widget.dart';
import 'package:country_codes/country_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'custom_form_field.dart';
import 'error_widget.dart';
import 'loading_widget.dart';

class NationalityCheckerWidget extends StatefulWidget {
  const NationalityCheckerWidget({Key? key}) : super(key: key);

  @override
  _NationalityCheckerWidgetState createState() => _NationalityCheckerWidgetState();
}

class _NationalityCheckerWidgetState extends State<NationalityCheckerWidget> {
  late TextEditingController nameFieldController;
  late NationalityCheckerViewModel viewModel;

  @override
  void initState() {
    CountryCodes.init(const Locale('en', 'US'));
    nameFieldController = TextEditingController(text: '');
    viewModel = NationalityCheckerViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NationalityCheckerViewModel>(
        create: (BuildContext context) => viewModel,
        child: Column(
          children: [
            CustomFormField(
              hintText: 'Enter name',
              controller: nameFieldController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(nameRegEx),
                )
              ],
            ),
            Consumer<NationalityCheckerViewModel>(builder: (context, viewModel, _) {
              return ElevatedButton(
                  onPressed: enableButton2() ? () => _checkNationality(nameFieldController.text) : null, child: const Text('Check Nationality'));
            }),
            const SizedBox(
              height: 40,
            ),
            Consumer<NationalityCheckerViewModel>(builder: (context, viewModel, _) {
              switch (viewModel.nationalityResponse.status) {
                case Status.loading:
                  return const LoadingWidget();
                case Status.error:
                  return ErrorMessageWidget(viewModel.nationalityResponse.message ?? '');
                case Status.completed:
                  return NationalityResultWidget(viewModel.nationality, Colors.deepOrange, 22);
                default:
              }
              return Container();
            })
          ],
        ));
  }

  bool enableButton2() {
    return viewModel.nationalityResponse.status != Status.loading;
  }

  void _checkNationality(String personName) {
    if (personName.isEmpty) {
      showToastMessage('Enter the name');
    } else {
      if (viewModel.nationalityResponse.status != Status.loading) {
        viewModel.fetchNationality(personName);
      } else {
        showToastMessage('Please wait..');
      }
    }
  }

  void showToastMessage(String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
