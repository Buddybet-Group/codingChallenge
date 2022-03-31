import 'dart:convert';

import 'package:buddybet_assignment/controller/landing_controller.dart';
import 'package:buddybet_assignment/model/country_model.dart';
import 'package:buddybet_assignment/widgets/ReuseableWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

   OverViewController ovc = Get.put(OverViewController());
  @override
  Widget build(BuildContext context) {
    ovc.getCountryList();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF646464),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                controller: ovc.search.value,
                onChanged: (val){
                  // if (ovc.search.value.text.trim() != '') {
                  //
                  //   ovc.searchCountryList(ovc.search.value.text.trim());
                  //
                  // }
                },
                decoration: InputDecoration(
                  fillColor: Colors.blue,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (ovc.search.value.text.trim() != '') {
                        ovc.searchCountryList(ovc.search.value.text.trim());

                      }
                    },
                  ),
                  counterText: '',
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontFamily: 'Roboto',
                    color: Color(0xFF646464),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFDFDFDF))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFDFDFDF))),
                ),
              ),
            ),),
            Obx(()=>  Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    ovc.searchcountrylist == null? Container(): Obx(()=>   Container(
                      child: ovc.isloading2.value ?
                      const Center(child: CircularProgressIndicator(color: Colors.blue,),):

                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: ovc.searchcountrylist.country == null ? 0 : ovc.searchcountrylist.country!.length,
                        itemBuilder: (BuildContext context, int index) {
                          String? countryId = ovc.searchcountrylist.country![index].countryId;
                          double? probability = ovc.searchcountrylist.country![index].probability;

                          return Container(
                            margin: EdgeInsets.only(left: 15,right: 15,top: 20,),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Table(
                                    // columnWidths:{1:FractionColumnWidth(.5),},
                                    children: [
                                      TableRow(
                                          children: [
                                            customText(EdgeInsets.only(top: Get.height *0),"Name",),
                                            customText(EdgeInsets.only(top: Get.height *0),":",),
                                            customText(EdgeInsets.only(top: Get.height *0,),ovc.searchcountrylist.name,),
                                          ]
                                      )
                                    ],
                                  ),
                                  Table(
                                    children: [
                                      TableRow(
                                          children: [
                                            customText(EdgeInsets.only(top: Get.height *0.01),"Country ID",),
                                            customText(EdgeInsets.only(top: Get.height *0.01),":",),
                                            customText(EdgeInsets.only(top: Get.height *0.01,),countryId,),

                                          ]
                                      )
                                    ],
                                  ),
                                  Table(
                                    // columnWidths:{1:FractionColumnWidth(.5),},
                                    children: [
                                      TableRow(

                                          children: [
                                            customText(EdgeInsets.only(top: Get.height *0.01),"Probability",),
                                            customText(EdgeInsets.only(top: Get.height *0.01),":",),
                                            customText(EdgeInsets.only(top: Get.height *0.01,),probability!.toStringAsFixed(3),),


                                          ]
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),),

                    Container(
                      child: ovc.isLoading.value ?
                      const Center(child: CircularProgressIndicator(color: Colors.blue,),):
                      ovc.countrylist.isEmpty?
                      Center(
                        child: Container(
                          alignment: Alignment(0,0),
                          child: const Text("No Country"),
                        ),
                      ):
                      ListView.builder(
                          itemCount: ovc.countrylist.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = ovc.countrylist[index];
                            var innerData = ovc.countrylist[index].country;
                            return Container(
                              margin: EdgeInsets.only(left: 15,right: 15,top: 20,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200]!,
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(0.0,5.0,),
                                    )],
                                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10,right: 10,top: 10,),
                                    child: Table(
                                      // columnWidths:{1:FractionColumnWidth(.5),},
                                      children: [
                                        TableRow(
                                            children: [
                                              customText(EdgeInsets.only(top: Get.height *0),"Name",),
                                              customText(EdgeInsets.only(top: Get.height *0),":",),
                                              customText(EdgeInsets.only(top: Get.height *0,),data.name,),
                                            ]
                                        )
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: innerData == null ? 0 : innerData.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      String? countryId = innerData![index].countryId;
                                      double? probability = innerData[index].probability;

                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Table(
                                                children: [
                                                  TableRow(
                                                      children: [
                                                        customText(EdgeInsets.only(top: Get.height *0.01),"Country ID",),
                                                        customText(EdgeInsets.only(top: Get.height *0.01),":",),
                                                        customText(EdgeInsets.only(top: Get.height *0.01,),countryId,),

                                                      ]
                                                  )
                                                ],
                                              ),
                                              Table(
                                                // columnWidths:{1:FractionColumnWidth(.5),},
                                                children: [
                                                  TableRow(

                                                      children: [
                                                        customText(EdgeInsets.only(top: Get.height *0.01),"Probability",),
                                                        customText(EdgeInsets.only(top: Get.height *0.01),":",),
                                                        customText(EdgeInsets.only(top: Get.height *0.01,),probability!.toStringAsFixed(3),),


                                                      ]
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                            return Container();

                          }
                      ),
                    ),
                  ],
                ),),),

            ),

          ],
        ),
      ),
    );
  }

}
