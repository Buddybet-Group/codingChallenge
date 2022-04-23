import 'dart:async';

import 'package:coding_chal/src/app/pages/home/home_controller.dart';
import 'package:coding_chal/src/app/pages/home/widgets/search_result.dart';
import 'package:flutter/material.dart';

import '../../../res/strings.dart';
import '../../../utils/app_tools.dart';
import '../../common/common_stream.dart';
import '../../widgets/submit_button.dart';
import '../../widgets/text_form_field.dart';
import 'home_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = HomeController();

  late Future<HomeResponse> homeFuture;
  StreamController<HomeResponse> responseController =
      StreamController<HomeResponse>.broadcast();

  final FocusNode _searchFocus = FocusNode();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    responseController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BuddyBet Coding Challege")),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchTextFromField(
                  password: false,
                  hintText: Strings.enterName,
                  inputType: TextInputType.emailAddress,
                  controller: searchController,
                  focusNode: _searchFocus,
                  onFieldSubmitted: (val) {
                    _searchFocus.unfocus();
                    if (val != "") {
                      homeController
                          .getPridictedCountry(val)
                          .then((v) => responseController.add(v));
                    } else {
                      showToast("Please enter some Text");
                    }
                  },
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    homeController
                        .getPridictedCountry(searchController.text)
                        .then((v) => responseController.add(v));
                  },
                  child: const SubmitButton(height: 50, value: "Search"),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Expanded(
            child: CommonStream<HomeResponse>(
              stream: responseController.stream,
              data: (data) {
                return (data.country!.isNotEmpty)
                    ? SearchResultWidget(data)
                    : const Center(child: Text("Data not found"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
