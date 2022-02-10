import 'package:coding_chal/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/resources.dart';
import '../widgets/search_result_display.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BuddyBet Coding Challege"),
      ),
      body: GetX<HomePageController>(
        init: HomePageController(),
        builder: (HomePageController _controller) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network(
                      buddyBetLogo,
                      height: 70,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Expanded(
                    child: Text(
                      "I bet i can guess your country using your name",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: "Enter your name",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String value) {
                    // setState(() {
                    _name = value;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton.icon(
                onPressed: () => _controller.fetchResult(_name),
                icon: const Icon(Icons.search),
                label: const Text("Search"),
              ),
              const SizedBox(
                height: 20,
              ),
              _controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: SearchResultDisplay(
                      countries: _controller.countries,
                    )),
            ],
          );
        },
      ),
    );
  }
}
