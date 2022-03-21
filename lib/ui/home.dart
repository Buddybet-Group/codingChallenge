import 'package:coding_chal/service/repository/nationality_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/nationality_bloc.dart';

class Nationality extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NationalityState();
  }

}

class NationalityState extends State<Nationality>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding:  EdgeInsets.all(10),
            child: Text("Enter name below to discover the nationalities ",style:  TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: BlocProvider.of<NationalityBloc>(context).nameCtrl,

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: "Type in your name here...",
              suffixIcon: IconButton(
                onPressed:BlocProvider.of<NationalityBloc>(context).nameCtrl.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        Flexible(
          child: Align(
            alignment: Alignment.topCenter,
            child: BlocConsumer<NationalityBloc,NationalityUserInputState>(listener: (BuildContext context, state) {

            }, builder: (BuildContext context, NationalityUserInputState? state) {


              return state?.results != null && state?.status == Status.success?ListView.builder(itemBuilder: (context,pos){
                String countryName = state!.results![pos].toString();
                return Padding(padding: const EdgeInsets.all(8),
                child: Text(countryName,style: const TextStyle(color: Colors.black,fontSize: 16),));
              }
              , itemCount: state?.results!.length,
              ): state?.status == Status.loading?  const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(

                ),
              ):Text(state?.status == Status.noCountry?"No results found":state?.status == Status.error?"Error loading results":""
                  ,
                style: const TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),
              );

            },

            ),
          ),
        )

      ],
    );
  }

}