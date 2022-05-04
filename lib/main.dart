// import 'package:flutter/material.dart';

import 'package:coding_chal/utils/app.dart';
import 'package:coding_chal/view_model/view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/widgets.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ListenableProvider<ViewModel>(create: (_) => ViewModel())],
      child: MaterialApp(
        navigatorKey: App.navigatorState,
        // debugShowCheckedModeBanner: false,
        home: Consumer<ViewModel>(
            builder: (context, value, child) => Scaffold(
                appBar: AppBar(
                  title: Text("BuddyBet Coding Challege"),
                ),
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: value.nameControler,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter a search term',
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 53,
                              child: MaterialButton(
                                onPressed: () => value.getAPIData(),
                                color: Colors.lightBlue,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(value.countries[index]["country_id"]),
                        subtitle: Text(
                            value.countries[index]["probability"].toString()),
                      ),
                      itemCount: value.countries.length,
                      shrinkWrap: true,
                    ),
                  ],
                ))),
      ),
    ),
  );
}
