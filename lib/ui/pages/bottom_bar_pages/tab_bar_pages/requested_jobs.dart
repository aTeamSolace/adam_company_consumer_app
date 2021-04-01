import 'dart:convert';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/get_ongoing_services.dart';
import 'package:adam_company_consumer_app/network/model/get_requested_job.dart';
import 'package:adam_company_consumer_app/ui/page_data/requested_job_card.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/service_description.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:adam_company_consumer_app/widget/blinking_widget.dart';
import 'package:adam_company_consumer_app/widget/list_view_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class RequestedJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<RequestedJob> {
  var requestedServicesData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSessionValue();
  }

  var user_id;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
//    print("user_id:${user_id}");
    requestedServicesData = getRequestedServices(user_id.toString());
  }

  // Widget customText(
  //   var title,
  //   double height,
  //   Color color,
  //   FontWeight fontWeight,
  // ) {
  //   return Text(title,
  //       style: GoogleFonts.montserrat(
  //         fontSize: height,
  //         color: color,
  //         fontWeight: fontWeight,
  //       ),
  //       overflow: TextOverflow.ellipsis,
  //       textAlign: TextAlign.left);
  // }

  Future getRequestedServices(var user_id) async {
    final response = await http.get("$get_requested_services" + "$user_id");

    if (response.statusCode == 200) {
      List<GetRequestedModelResult> requestedService;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);


          requestedService = GetRequestedModel.fromJson(responseJson).data;
        });
      }
      return requestedService;
    } else {
      throw Exception('Failed to load requested services');
    }
  }

  confirmPaymentDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertBox(
          title: customText(
              "Payment", 14, WidgetColors.blackColor, FontWeight.w500),
          content: customText(
              "This is small service, So you need to pay to this service!",
              14,
              WidgetColors.blackColor,
              FontWeight.w500),
          list: [
            PlatformActionButton(
              title: cancel,
              onPress: () {
                Navigator.pop(context);
              },
              boolValue: false,
            ),
            PlatformActionButton(
              title: continue_data,
              onPress: () {
                // getCardTokenDetails(cardId, custId);
                // creatingToken();
              },
              boolValue: true,
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: WidgetColors.whiteColor,
        body: Padding(
          child: FutureBuilder(
            future: requestedServicesData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return Container(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: PlatformScrollbar(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var dateTime = DateTime.parse(
                                snapshot.data[index].updatedAt.toString());
                            var myFullFormat = DateFormat('dd-MM-yyyy');
                            return WidgetANimator(Stack(
                              children: [
                                RequestedTabCard(
                                  serviceTitle: snapshot.data[index].jobTitle,
                                  serviceDate: myFullFormat.format(dateTime),
                                  serviceDescription:
                                      snapshot.data[index].jobDescription,
                                  serviceImage:
                                      "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                  serviceAmount: snapshot.data[index].jobCost,
                                  viewDetails: () {
                                    BackFunction.slideLeftNavigator(
                                        context,
                                        ServiceDescription(
                                          images: json.decode(
                                              snapshot.data[index].documents),
                                          index: index,
                                          fromPage: "completed_service",
                                          serviceDate:
                                          myFullFormat.format(dateTime),
                                          serviceName: snapshot
                                              .data[index].jobTitle
                                              .toString()
                                              .toUpperCase(),
                                          serviceDetails: snapshot
                                              .data[index].jobDescription,
                                          serviceLocation: snapshot
                                              .data[index].jobAddress
                                              .toString() +
                                              " " +
                                              snapshot.data[index].jobCity
                                                  .toString() +
                                              " " +
                                              snapshot.data[index].jobState
                                                  .toString() +
                                              " " +
                                              snapshot.data[index].jobCountry
                                                  .toString(),
                                          serviceStatus: snapshot
                                              .data[index].jobStatus
                                              .toString(),
                                          serviceImage:
                                          "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                          pageId: 0,
                                        ));
                                    // if (snapshot.data[index].paymentstructure !=
                                    //     "100%") {
                                    //   BackFunction.slideLeftNavigator(
                                    //       context,
                                    //       ServiceDescription(
                                    //         images: json.decode(
                                    //             snapshot.data[index].documents),
                                    //         index: index,
                                    //         fromPage: "completed_service",
                                    //         serviceDate:
                                    //             myFullFormat.format(dateTime),
                                    //         serviceName: snapshot
                                    //             .data[index].jobTitle
                                    //             .toString()
                                    //             .toUpperCase(),
                                    //         serviceDetails: snapshot
                                    //             .data[index].jobDescription,
                                    //         serviceLocation: snapshot
                                    //                 .data[index].jobAddress
                                    //                 .toString() +
                                    //             " " +
                                    //             snapshot.data[index].jobCity
                                    //                 .toString() +
                                    //             " " +
                                    //             snapshot.data[index].jobState
                                    //                 .toString() +
                                    //             " " +
                                    //             snapshot.data[index].jobCountry
                                    //                 .toString(),
                                    //         serviceStatus: snapshot
                                    //             .data[index].jobStatus
                                    //             .toString(),
                                    //         serviceImage:
                                    //             "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                    //         pageId: 0,
                                    //       ));
                                    // } else {
                                    //   confirmPaymentDialog(context);
                                    // }
                                  },
                                  selectTech: () {
                                    BackFunction.commonNavigator(
                                        context,
                                        SelectTechnician(
                                            serviceId: snapshot.data[index].id
                                                .toString()));
                                  },
                                  index: index,
                                ),
                                // Positioned(
                                //   right: 10,
                                //   top: 2,
                                //   child:
                                //       snapshot.data[index].paymentstructure ==
                                //               "100%"
                                //           ? BlinkingText()
                                //           : Container(),
                                // )
                              ],
                            ));
                          }),
                    ),
                  ));
                } else {
                  return Center(
                    child: customText(
                        no_requested_service,
                        MediaQuery.of(context).size.width * .05,
                        Colors.black,
                        FontWeight.w500),
                  );
                }
              } else if (snapshot.hasError) {
                // print("============>>${snapshot.error}");
                return Text("${snapshot.error}");
              }
              return Container(
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: PlatformScrollbar(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[500],
                            highlightColor: Colors.grey[100],
                            child: ListView.builder(
                              itemBuilder: (_, __) => Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 60.0,
                                          height: 60.0,
                                          color: Colors.white,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 8.0,
                                                color: Colors.white,
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2.0),
                                              ),
                                              Container(
                                                width: 120.0,
                                                height: 27.0,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              itemCount: 6,
                            ),
                          ),
                        ))),
              );
            },
          ),
          padding: EdgeInsets.only(top: 10),
        ));
  }
}
