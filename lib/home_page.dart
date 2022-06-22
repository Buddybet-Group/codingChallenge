import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coding_chal/nationality_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _nameController = TextEditingController();
  late NationalityMOdel nationalityMOdel =
      NationalityMOdel(name: 'name', country: []);
  bool lodaing = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              textAlign: TextAlign.start,
              controller: _nameController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.grey)),
                  hintText: "Enter Name..",
                  hintStyle: TextStyle(color: Colors.grey)),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  // lodaing = true;
                  // setState(() {});
                  getNationality(_nameController.text.toString())
                      .then((value) => {
                            nationalityMOdel = value,
                            print(nationalityMOdel.name),
                          });
                  print(lodaing);
                  lodaing = true;
                  setState(() {});
                },
                child: const Text('Get Nationality')),
            lodaing == false
                ?const  Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: FutureBuilder(
                    future: getNationality(_nameController.text),
                    builder: (context, snapshot) {
                      NationalityMOdel obj = snapshot.data as NationalityMOdel;
                      return Text(obj.country[0].countryId??"NO Data ");
                    },
                  )),
          ],
        ),
      ),
    );
  }
}

Future getNationality(String Name) async {
  var _dio = Dio();
  String url = "https://api.nationalize.io/";
  Map<String, String> qParams = {
    'name': '$Name',
  };
  var res = await _dio.get(url, queryParameters: qParams);
  switch (res.statusCode) {
    case 200:
      print('SUCESSS');
      // print('${nationalityMOdelFromJson(res.data)}');
      return NationalityMOdel.fromJson(res.data);
      break;
    case 401:
      print('UNATHORIZED');
      break;
    case 422:
      print('NAME PARAMETER IS MISSING');
      break;
    default:
      print('ISSUE');
      break;
  }
}
