import 'dart:convert';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/get_ongoing_services.dart';
import 'package:adam_company_consumer_app/ui/page_data/tab_card.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/service_description.dart';
import 'package:adam_company_consumer_app/widget/blinking_widget.dart';
import 'package:adam_company_consumer_app/widget/list_view_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class OngoingServices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<OngoingServices> {
  var onGoingServicesData;

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
    // print("consumer id:- ${user_id}");
    onGoingServicesData = getOnGoingServices(user_id);
  }

  Future getOnGoingServices(var user_id) async {
    final response = await http
        .post(ongoing_services, body: {"consumer_id": user_id.toString()});
    if (response.statusCode == 200) {
      List<OngoingServiceResult> servicesResult;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          // for (var i in responseJson['data']) {
          //   print("===========>>${i}");
          // }
          // print("ongoing_services ${responseJson}");
          servicesResult = OngoingServiceModel.fromJson(responseJson).data;
        });
      }
      return servicesResult;
    } else {
      throw Exception('Failed to load ongoing services');
    }
  }

  confirmPaymentDialog(BuildContext context, Function customFunction) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertBox(
          title: Center(
            child: customText(
                "Payment", 14, WidgetColors.blackColor, FontWeight.w500),
          ),
          content: customText(
              "This is small service, So you need to pay to this service first, after that we will work on your service!",
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
                customFunction();
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
            future: onGoingServicesData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return Container(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: PlatformScrollbar(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            var dateTime = DateTime.parse(
                                snapshot.data[index].jobDoneByDate.toString());
                            var myFullFormat = DateFormat('dd-MM-yyyy');
                            // print("===============================>>${snapshot.data[index].id.toString()}");
                            return WidgetANimator(Stack(
                              children: [
                                InkWell(
                                    child: TabCard(
                                      service_id: snapshot.data[index].serviceId
                                          .toString(),
                                      serviceTitle:
                                          snapshot.data[index].jobTitle,
                                      serviceDate:
                                          myFullFormat.format(dateTime),
                                      serviceDescription:
                                          snapshot.data[index].jobDescription,
                                      serviceImage:
                                          "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                      viewDetails: () {
                                        if (snapshot
                                                .data[index].paymentstructure ==
                                            "100") {
                                          confirmPaymentDialog(
                                              context,
                                              () => BackFunction
                                                  .slideRightNavigator(
                                                      context,
                                                      ServiceDescription(
                                                        service_id: snapshot
                                                            .data[index].jobId
                                                            .toString(),
                                                        images: json.decode(
                                                            snapshot.data[index]
                                                                .documents),
                                                        index: index,
                                                        fromPage:
                                                            "ongoing_service",
                                                        serviceDate:
                                                            myFullFormat.format(
                                                                dateTime),
                                                        serviceName: snapshot
                                                            .data[index]
                                                            .jobTitle,
                                                        serviceDetails: snapshot
                                                            .data[index]
                                                            .jobDescription,
                                                        serviceLocation: snapshot
                                                                .data[index]
                                                                .jobAddress
                                                                .toString() +
                                                            " " +
                                                            snapshot.data[index]
                                                                .jobCity
                                                                .toString() +
                                                            " " +
                                                            snapshot.data[index]
                                                                .jobState
                                                                .toString() +
                                                            " " +
                                                            snapshot.data[index]
                                                                .jobCountry
                                                                .toString(),
                                                        serviceStatus: snapshot
                                                            .data[index]
                                                            .jobStatus
                                                            .toString(),
                                                        serviceImage:
                                                            "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                                        pageId: 1,
                                                        tech_id: snapshot
                                                            .data[index]
                                                            .technicianId
                                                            .toString(),
                                                      )));
                                        } else {
                                          BackFunction.slideRightNavigator(
                                              context,
                                              ServiceDescription(
                                                service_id: snapshot
                                                    .data[index].jobId
                                                    .toString(),
                                                images: json.decode(snapshot
                                                    .data[index].documents),
                                                index: index,
                                                fromPage: "ongoing_service",
                                                serviceDate: myFullFormat
                                                    .format(dateTime),
                                                serviceName: snapshot
                                                    .data[index].jobTitle,
                                                serviceDetails: snapshot
                                                    .data[index].jobDescription,
                                                serviceLocation: snapshot
                                                        .data[index].jobAddress
                                                        .toString() +
                                                    " " +
                                                    snapshot.data[index].jobCity
                                                        .toString() +
                                                    " " +
                                                    snapshot
                                                        .data[index].jobState
                                                        .toString() +
                                                    " " +
                                                    snapshot
                                                        .data[index].jobCountry
                                                        .toString(),
                                                serviceStatus: snapshot
                                                    .data[index].jobStatus
                                                    .toString(),
                                                serviceImage:
                                                    "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                                pageId: 1,
                                                tech_id: snapshot
                                                    .data[index].technicianId
                                                    .toString(),
                                              ));
                                        }
                                      },
                                      index: index,
                                    ),
                                    onTap: () {
                                      if (snapshot
                                              .data[index].paymentstructure ==
                                          "100") {
                                        confirmPaymentDialog(
                                            context,
                                            () => BackFunction
                                                .slideRightNavigator(
                                                    context,
                                                    ServiceDescription(
                                                      service_id: snapshot
                                                          .data[index].jobId
                                                          .toString(),
                                                      images: json.decode(
                                                          snapshot.data[index]
                                                              .documents),
                                                      index: index,
                                                      fromPage:
                                                          "ongoing_service",
                                                      serviceDate: myFullFormat
                                                          .format(dateTime),
                                                      serviceName: snapshot
                                                          .data[index].jobTitle,
                                                      serviceDetails: snapshot
                                                          .data[index]
                                                          .jobDescription,
                                                      serviceLocation: snapshot
                                                              .data[index]
                                                              .jobAddress
                                                              .toString() +
                                                          " " +
                                                          snapshot.data[index]
                                                              .jobCity
                                                              .toString() +
                                                          " " +
                                                          snapshot.data[index]
                                                              .jobState
                                                              .toString() +
                                                          " " +
                                                          snapshot.data[index]
                                                              .jobCountry
                                                              .toString(),
                                                      serviceStatus: snapshot
                                                          .data[index].jobStatus
                                                          .toString(),
                                                      serviceImage:
                                                          "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                                      pageId: 1,
                                                      tech_id: snapshot
                                                          .data[index]
                                                          .technicianId
                                                          .toString(),
                                                    )));
                                      } else {
                                        BackFunction.slideLeftNavigator(
                                            context,
                                            ServiceDescription(
                                              service_id: snapshot
                                                  .data[index].jobId
                                                  .toString(),
                                              images: json.decode(snapshot
                                                  .data[index].documents),
                                              index: index,
                                              fromPage: "ongoing_service",
                                              serviceDate:
                                                  myFullFormat.format(dateTime),
                                              serviceName:
                                                  snapshot.data[index].jobTitle,
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
                                                  snapshot
                                                      .data[index].jobCountry
                                                      .toString(),
                                              serviceStatus: snapshot
                                                  .data[index].jobStatus
                                                  .toString(),
                                              serviceImage:
                                                  "$service_img/${json.decode(snapshot.data[index].documents)[0]}",
                                              pageId: 1,
                                              tech_id: snapshot
                                                  .data[index].technicianId
                                                  .toString(),
                                            ));
                                      }
                                    }),
                                Positioned(
                                  right: 10,
                                  top: 2,
                                  child:
                                      snapshot.data[index].paymentstructure ==
                                              "100"
                                          ? BlinkingText()
                                          : Container(),
                                )
                              ],
                            ));
                          }),
                    ),
                  ));
                } else {
                  return Center(
                    child: customText(
                        no_ongoing_service_yet,
                        MediaQuery.of(context).size.width * .05,
                        Colors.black,
                        FontWeight.w500),
                  );
                }
              } else if (snapshot.hasError) {
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
//                                    color: Colors.brown,
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
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      width: 120.0,
                                                      height: 27.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 3,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      width: 120.0,
                                                      height: 27.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
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
