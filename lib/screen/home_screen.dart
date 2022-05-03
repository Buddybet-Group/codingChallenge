import 'package:coding_chal/model/api_status.dart';
import 'package:coding_chal/provider/nationality_model.dart';
import 'package:coding_chal/theme/string_resources.dart';
import 'package:coding_chal/utils/circle_loading_widget.dart';
import 'package:coding_chal/utils/widget_keys.dart';
import 'package:coding_chal/widgets/result_widget.dart';
import 'package:coding_chal/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late NationalityModel _nationalityModel;

  @override
  void initState() {
    _nationalityModel = NationalityModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _nationalityModel,
        child: SingleChildScrollView(
            child: Column(children: [
          _sizedBox,
          _nameField,
          _sizedBox,
          _predictBtn,
          _sizedBox,
          Consumer<NationalityModel>(builder: (context, model, child) {
            final _response = model.getResponse();
            switch (_response.status) {
              case ApiStatus.loading:
                return const CircleLoadingWidget();
              case ApiStatus.success:
                return ResultWidget(_response.data!.countries);
              default:
                return Container();
            }
          }),
        ])));
  }

  Widget get _sizedBox => const SizedBox(height: 20.0);

  Widget get _nameField => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: NameTextFieldWidget(const Key(WidgetKeys.nameTextField), _controller, _focusNode,
            onChange: (String value) {}),
      );

  Widget get _predictBtn => MaterialButton(
      child: Text(StringResources.predictNationality, style: Theme.of(context).textTheme.button),
      color: Colors.blueAccent,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        _nationalityModel.submitName(context, _controller.text.trim());
      });
}
