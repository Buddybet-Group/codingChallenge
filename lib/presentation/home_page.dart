import 'package:coding_chal/presentation/widgets/world_map.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BuddyBet Coding Challege"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.start,
                controller: nameController,
                textInputAction: TextInputAction.search,
                onSubmitted: (value){
                  setState(() {});
                },
                decoration:  InputDecoration(
                  suffixIcon: IconButton(onPressed:  () {
                    setState(() {});}, icon: const Icon(Icons.search)),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: Colors.grey)),
                    hintText: "Enter Name..",
                    hintStyle: const TextStyle(color: Colors.grey)),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              WorldMap(name: nameController.text),
         
            ],
          ),
        ),
      ),
    );
  }
}


