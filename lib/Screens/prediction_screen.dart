import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/prediction_provider.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {

  late String _countryName = '';
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProProvider()),
      ],
       child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text("BuddyBet Coding Challenge"),
              backgroundColor: Colors.blueAccent,
            ),
            backgroundColor: Colors.black26,
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blueAccent, Colors.purpleAccent])),
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  createMessageInputComponent(context),
                  const SizedBox(height: 40,),
                  ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.isNotEmpty) {
                          if(mounted){
                            setState(() {
                              _countryName = "Please wait...";
                              //_countryName = onValue.toString();
                            });
                          }
                          getCountry(_nameController.text.trim());
                        }else{
                          if(mounted){
                            setState(() {
                              _countryName = "Please Enter Name...";
                              //_countryName = onValue.toString();
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          fixedSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text('Get Nationality',style: TextStyle(color: Colors.black87),)),
                  const SizedBox(height: 40,),
                  Column(
                    children: [
                      Text(_countryName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                          ))
                    ],
                  )
                ],
              ),
            ),
            //body: HomePage(),
          ),
        )
    );
  }


  Widget createMessageInputComponent(BuildContext context) {
    // wrapped around a column so that the avatar doesn't stretch
    return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 150,
              ),

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent,
                ),
                cursorColor: Colors.black,
                controller: _nameController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 1,
                // onChanged: (value) => _nameInputChange(),
                autofocus: false,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  hintText: "Enter Name...",
                  hintStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  border: InputBorder.none,
                  // filled: true,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }



  Future<void> getCountry(String token) async {
    await ProProvider.getCountry(token).then((onValue) {
      try {
        if(onValue != null){
          if(mounted){
            setState(() {
              _countryName = "Predicted Country is : " + onValue.toString();
            });
          }
        }else{
          if(mounted){
            setState(() {
              _countryName = "Country not Found " ;
            });
          }
        }
        if (kDebugMode) {
          print(onValue);
        }
        return onValue;
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    });
  }


}
