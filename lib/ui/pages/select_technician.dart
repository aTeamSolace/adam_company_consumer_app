import 'dart:convert';
import 'dart:io';
import 'package:adam_company_consumer_app/network/model/get_quotation_details.dart';
import 'package:adam_company_consumer_app/ui/page_data/technician_card.dart';
import 'package:http/http.dart' as http;
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
class SelectTechnician extends StatefulWidget {
  var serviceId;

  SelectTechnician({@required this.serviceId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<SelectTechnician> {
  var technicianResult;

  @override
  initState() {
    // getCurrentLocation();

    super.initState();
    // print("Select Technician :${widget.serviceId.toString()}");
    technicianResult = getTechnicianProfile(
        widget.serviceId.toString()); //widget.serviceId.toString()
  }

  onWillPop() {
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 0,
        ));
  }

  // getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //
  // }

  Future getTechnicianProfile(var serviceId) async {
    // final response = await http.post(technician_profile,
    //     body: {"latitude": latitude.toString(), "longitude": longitude.toString()}); // 18.5204  73.8567

    final responce = await http.get(quotation_detail + serviceId.toString());

    if (responce.statusCode == 200) {
      List<GetQuotationResult> technicianResult;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(responce.body);
          // print("Select Technician :$responseJson");
          technicianResult = GetQuotationModel.fromJson(responseJson).data;
        });
      }
      return technicianResult;
    } else {
      throw Exception('Failed to load technisian data');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Color(0xffE2E2E2),
          appBar: AppBar(
            leading: IconButton(
                icon: Platform.isIOS
                    ? Icon(
                        Icons.arrow_back_ios,
                        color: WidgetColors.blackColor,
                      )
                    : Icon(
                        Icons.arrow_back,
                        color: WidgetColors.blackColor,
                      ),
                onPressed: () {
                  onWillPop();
                }),
            iconTheme: IconThemeData(color: WidgetColors.blackColor),
            backgroundColor: WidgetColors.themeColor,
            centerTitle: true,
            title: customText(tech_name, width * .05, WidgetColors.blackColor,
                FontWeight.w400),
          ),
          body: SafeArea(
              child: Center(
                  child: PlatformScrollbar(
            child: Container(
                width: width,
                height: height,
                child: FutureBuilder(
                    future: technicianResult,
                    // Provider.of<GetApiDataProvider>(context, listen: false).getQuotationDetails("195"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              // double distanceData =
                              //     snapshot.data[index].distance.toDouble();
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 2, bottom: 2, left: 5, right: 5),
                                child: TechnisianCardSelect(
                                  serviceId: snapshot
                                      .data[index].serviceRequestId
                                      .toString(),
                                  tag: index,
                                  name: snapshot.data[index].technicinaName,
                                  location:
                                      snapshot.data[index].technicinaCity +
                                          " " +
                                          snapshot.data[index].technicianState,
                                  // distance: distanceData.toStringAsFixed(2),
                                  // rating: 3.5,
                                  profile_pic:
                                      "${technician_profile_img + "/" + snapshot.data[index].technicinaProfilePic}",
                                  type: snapshot.data[index].jobTitle,
                                  technician_id: snapshot
                                      .data[index].technicianId
                                      .toString(),
                                  service_price: snapshot
                                      .data[index].technicianCost
                                      .toString(),
                                  service_date: snapshot
                                      .data[index].tentativieDate
                                      .toString(),
                                  // job_details: snapshot.data[index].profileDescription,
                                  // phone: snapshot.data[index].mobile,
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: customText(no_quotstion, 16, Colors.black,
                                  FontWeight.w500),
                            ),
                          );
                        }
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error);
                      }
                      return Center(
                        child: PlatformLoader(
                          radius: 15,
                          color: WidgetColors.buttonColor,
                        ),
                      );
                    })),
          ))),
        ),
        onWillPop: () {
          return onWillPop();
        });
  }
}
