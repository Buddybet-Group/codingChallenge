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
  ValueNotifier<bool> enableButton = ValueNotifier(false);

  @override
  void initState() {
    CountryCodes.init(const Locale('en', 'US'));
    nameFieldController = TextEditingController(text: '');
    viewModel = NationalityCheckerViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomFormField(
          hintText: 'Enter name',
          controller: nameFieldController,
          onChange: (value) {
            enableButton.value = value?.isNotEmpty ?? false;
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(nameRegEx),
            )
          ],
        ),
        ValueListenableBuilder<bool>(
          valueListenable: enableButton,
          builder: (context, value, child) {
            return ElevatedButton(
                onPressed: value ? () => _checkNationality(nameFieldController.text) : null, child: const Text('Check Nationality'));
          },
        ),
        ChangeNotifierProvider<NationalityCheckerViewModel>(
            create: (BuildContext context) => viewModel,
            child: Consumer<NationalityCheckerViewModel>(builder: (context, viewModel, _) {
              switch (viewModel.nationalityResponse.status) {
                case Status.loading:
                  //enableButton.value = false;
                  return const LoadingWidget();
                case Status.error:
                  enableButton.value = true;
                  return ErrorMessageWidget(viewModel.nationalityResponse.message ?? '');
                case Status.completed:
                  enableButton.value = true;
                  return NationalityResultWidget(viewModel.nationality, Colors.deepOrange, 32);
                default:
              }
              return Container();
            }))
      ],
    );
  }

  void _checkNationality(String personName) {
    if (personName.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Enter the name'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      enableButton.value = false;
      viewModel.fetchNationality(personName);
    }
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }
}
