import 'package:coding_chal/controllers/home-page-controller.dart';
import 'package:coding_chal/views/Widgets/search-List.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BuddyBet Coding Challege"),
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (HomeController _controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 22),
                child: textField(
                    title: "Enter Name",
                    onChanged: (String value) {
                      _name = value;
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => _controller.fetchResult(_name),
                child: const Text("Check Nationality"),
              ),
              const SizedBox(
                height: 40,
              ),
              _controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: SearchList(
                        countries: _controller.countries,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }

  Widget textField({String? title, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title!,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onChanged: onChanged,
        )
      ],
    );
  }
}
