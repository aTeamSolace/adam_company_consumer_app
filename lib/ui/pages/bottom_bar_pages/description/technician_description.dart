import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/technician_comments.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_option.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_screen.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TechnisianDetails extends StatefulWidget {
  var tag;
  var name;
  var type;
  var location;
  var phone;
  var job_details;
  var id;
  var profile_pic;
  var serviceId;
  var tech_cost;
  var tech_date;

  TechnisianDetails(
      {@required this.tag,
      @required this.id,
      @required this.name,
      @required this.location,
      @required this.phone,
      @required this.job_details,
      @required this.type,
      @required this.tech_date,
      @required this.tech_cost,
      this.profile_pic,
      this.serviceId});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TechnisianDetails();
  }
}

class _TechnisianDetails extends State<TechnisianDetails> {
  var technicianCommentsResult;

  @override
  initState() {
    // print("Service Id:${widget.serviceId}");
    // print("Technician Id:${widget.id}");
    technicianCommentsResult = getTechnicianProfileComments(widget.id.toString());
    getGraphData(widget.id.toString());
    loadingGraph = false;
    nullData = false;
    super.initState();
  }

  onWillPop() {
    return BackFunction.slideLeftNavigator(
        context,
        SelectTechnician(
          serviceId: widget.serviceId.toString(),
        ));
  }

  // Widget customText(
  //   var title,
  //   double height,
  //   Color color,
  //   FontWeight fontWeight,
  // ) {
  //   return Text(
  //     title.toString(),
  //     style: GoogleFonts.montserrat(
  //       fontSize: height,
  //       color: color,
  //       fontWeight: fontWeight,
  //     ),
  //   );
  // }

  Future getTechnicianProfileComments(var tech_id) async {
    final response = await http.post(technician_profile_comment,
        body: {"technician_id": tech_id.toString()});
    if (response.statusCode == 200) {
      List<TechnicianCommentsResult> technicianResult;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          // print("Review and Rating:$responseJson");
          technicianResult =
              TechnicianCommentsModel.fromJson(responseJson).data;
        });
      }
      return technicianResult;
    } else {
      throw Exception('Failed to load technisian data');
    }
  }

  Widget commentsSection(double height, double width) {
    return FutureBuilder(
      future: technicianCommentsResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            // print("Comment Length:${snapshot.data.length}");
            return Container(
                child: Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: PlatformScrollbar(
                child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var dateTime = DateTime.parse(
                          snapshot.data[index].createdAt.toString());
                      var myFullFormat = DateFormat('dd-MM-yyyy');
                      return Center(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      technician_profile_img +
                                          "/" +
                                          snapshot.data[index].profilePic),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        customText(
                                            snapshot.data[index].name
                                                .toString(),
                                            width * .04,
                                            Colors.black,
                                            FontWeight.w400),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: customText(
                                                  myFullFormat
                                                      .format(dateTime)
                                                      .toString(),
                                                  width * .03,
                                                  Colors.black54,
                                                  FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.green,
                                                ),
                                                customText(
                                                    snapshot.data[index].rating,
                                                    width * .03,
                                                    Colors.green,
                                                    FontWeight.w500),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          height: height * .02,
                                        ),
                                        customText(
                                            snapshot.data[index].reviewComments
                                                .toString(),
                                            width * .04,
                                            Colors.black,
                                            FontWeight.normal),
                                      ],
                                    ),
                                  ),
                                  width: width,
//                                        color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ));
          } else {
            return Center(
              child: customText("No Reviews Found", width * .05, Colors.black,
                  FontWeight.w500),
            );
          }
        } else if (snapshot.hasError) {
          // print("============>>${snapshot.hasError}");
          return Text("${snapshot.error}");
        }
        return Container(
          child: Center(
            child: PlatformLoader(
              radius: 15,
              color: WidgetColors.buttonColor,
            ),
          ),
        );
      },
    );
  }

  double rateing_five;
  String rateing_five_string;
  double rateing_four;
  String rateing_four_string;
  double rateing_three;
  String rateing_three_string;
  double rateing_two;
  String rateing_two_string;
  double rateing_one;
  String rateing_one_string;

  bool loadingGraph;
  bool nullData;
  var graph_data;

  Future getGraphData(var user_id) async {
    final response = await http.get(get_graph_data + user_id.toString());
    final responseJson = json.decode(response.body);
    print("get graph data : ${responseJson}");

    if (responseJson['data'] == null || responseJson['data'] == "null") {
      loadingGraph = true;
      nullData = true;
      graph_data = "not_null";
      setState(() {});
    } else {
      if (this.mounted) {
        setState(() {
          loadingGraph = true;
          nullData = false;

          if (responseJson['data']['5'] == null ||
              responseJson['data']['5'] == "null") {
            rateing_five = 0.0;
          } else {
            rateing_five_string =
                double.parse(responseJson['data']['5']).toStringAsFixed(1);
            rateing_five = double.parse(rateing_five_string);
          }

          if (responseJson['data']['4'] == null ||
              responseJson['data']['4'] == "null") {
            rateing_four = 0.0;
          } else {
            rateing_four_string =
                double.parse(responseJson['data']['4']).toStringAsFixed(1);
            rateing_four = double.parse(rateing_four_string);
          }

          if (responseJson['data']['3'] == null ||
              responseJson['data']['3'] == "null") {
            rateing_three = 0.0;
          } else {
            rateing_three_string =
                double.parse(responseJson['data']['3']).toStringAsFixed(1);
            rateing_three = double.parse(rateing_three_string);
          }

          if (responseJson['data']['2'] == null ||
              responseJson['data']['2'] == "null") {
            rateing_two = 0.0;
          } else {
            rateing_two_string =
                double.parse(responseJson['data']['2']).toStringAsFixed(1);
            rateing_two = double.parse(rateing_two_string);
          }

          if (responseJson['data']['1'] == null ||
              responseJson['data']['1'] == "null") {
            rateing_one = 0.0;
          } else {
            rateing_one_string =
                double.parse(responseJson['data']['1']).toStringAsFixed(1);
            rateing_one = double.parse(rateing_one_string);
          }
          // print("rateing_five : ${rateing_five * 100}");
          // rateing_four = responseJson['data']['4'];
          // rateing_three = responseJson['data']['3'];
          // rateing_two = responseJson['data']['2'];
          // rateing_one = responseJson['data']['1'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var dateTime = DateTime.parse(widget.tech_date.toString());
    var myFullFormat = DateFormat('dd-MM-yyyy');
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
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
            title: customText(
                tech_etail, width * .05, WidgetColors.blackColor, FontWeight.w400),
          ),
          body: Container(
              height: height,
              width: width,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Container(
                    height: height * .02,
                  ),
                  Hero(
                      tag: widget.tag,
                      child: Material(
                          child: Center(
                        child: Card(
                            elevation: 8,
                            child: Container(
                              child: Image.network(
                                widget.profile_pic,
                                height: height / 3.5,
                                fit: BoxFit.contain,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              WidgetColors.buttonColor),
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         color: WidgetColors.buttonColor)),
                            )),
                      ))),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * .03,
                          ),
                          RichText(
                            text: TextSpan(
                              text: name_tech,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.name,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade800,
                                      fontSize: width * .05),
                                ),
                              ],
                            ),
                            maxLines: 2,
                          ),
                          Container(
                            height: height * .01,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Service : ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.type,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade800,
                                      fontSize: width * .05),
                                ),
                              ],
                            ),
                            maxLines: 2,
                          ),
                          Container(
                            height: height * .01,
                          ),
                          RichText(
                            text: TextSpan(
                              text: location,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.location,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade800,
                                      fontSize: width * .05),
                                ),
                              ],
                            ),
                            maxLines: 2,
                          ),
                          // Container(
                          //   height: height * .01,
                          // ),
                          // RichText(
                          //   text: TextSpan(
                          //     text: phone,
                          //     style: GoogleFonts.poppins(
                          //         color: Colors.black,
                          //         fontSize: width * .05,
                          //         fontWeight: FontWeight.w500),
                          //     children: <TextSpan>[
                          //       TextSpan(
                          //         text: widget.phone,
                          //         style: GoogleFonts.poppins(
                          //             color: Colors.grey.shade800,
                          //             fontSize: width * .05),
                          //       ),
                          //     ],
                          //   ),
                          //   maxLines: 2,
                          // ),
                          Container(
                            height: height * .01,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "$tech_cost : ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: widget.tech_cost.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade800,
                                      fontSize: width * .05),
                                ),
                              ],
                            ),
                            maxLines: 2,
                          ),
                          Container(
                            height: height * .01,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "$tentitave_date : ",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: width * .05,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                  text: myFullFormat.format(dateTime),
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey.shade800,
                                      fontSize: width * .05),
                                ),
                              ],
                            ),
                            maxLines: 2,
                          ),
                          Container(
                            height: height * .02,
                          ),
                          Container(
                            width: width,
                            margin: EdgeInsets.only(left: 00),
                            child: loadingGraph
                                ? Container(
                                    child: graph_data == "not_null"
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              customText(
                                                  "Reviews in past month",
                                                  width * .05,
                                                  Colors.black,
                                                  FontWeight.w500),
                                              Container(
                                                height: height * .02,
                                              ),
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  // height: height / 4.5,
                                                  width: width,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // color: Colors.black,
                                                            width: width / 3.5,
                                                            child: customText(
                                                                excellant,
                                                                width * .05,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              // width: width ,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            04.0),
                                                                child:
                                                                    new LinearPercentIndicator(
                                                                  // width: width / 7,
                                                                  center: new Text(
                                                                      "${rateing_five * 100}%"),
                                                                  animation:
                                                                      true,
                                                                  lineHeight:
                                                                      15.0,
                                                                  animationDuration:
                                                                      2500,
                                                                  percent:
                                                                      rateing_five,
                                                                  linearStrokeCap:
                                                                      LinearStrokeCap
                                                                          .roundAll,
                                                                  progressColor:
                                                                      WidgetColors
                                                                          .graph2,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              // color: Colors.black,
                                                              width:
                                                                  width / 3.5,
                                                              child: customText(
                                                                  good,
                                                                  width * .05,
                                                                  Colors.black,
                                                                  FontWeight
                                                                      .w400),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                // width: width ,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              04.0),
                                                                  child:
                                                                      new LinearPercentIndicator(
                                                                    // width: width / 7,
                                                                    center: new Text(
                                                                        "${rateing_four * 100}%"),
                                                                    animation:
                                                                        true,
                                                                    lineHeight:
                                                                        15.0,
                                                                    animationDuration:
                                                                        2500,
                                                                    percent:
                                                                        rateing_four,

                                                                    linearStrokeCap:
                                                                        LinearStrokeCap
                                                                            .roundAll,
                                                                    progressColor:
                                                                        WidgetColors
                                                                            .graph2,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        // color: Colors.black,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // color: Colors.black,
                                                            width: width / 3.5,
                                                            child: customText(
                                                                avg,
                                                                width * .05,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              // width: width ,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            04.0),
                                                                child:
                                                                    new LinearPercentIndicator(
                                                                  // width: width / 7,
                                                                  center: new Text(
                                                                      "${rateing_three * 100}%"),
                                                                  animation:
                                                                      true,
                                                                  lineHeight:
                                                                      15.0,
                                                                  animationDuration:
                                                                      2500,
                                                                  percent:
                                                                      rateing_three,
                                                                  linearStrokeCap:
                                                                      LinearStrokeCap
                                                                          .roundAll,
                                                                  progressColor:
                                                                      WidgetColors
                                                                          .graph3,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // color: Colors.black,
                                                            width: width / 3.5,
                                                            child: customText(
                                                                poor,
                                                                width * .05,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              // width: width ,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            04.0),
                                                                child:
                                                                    new LinearPercentIndicator(
                                                                  // width: width / 7,
                                                                  center: new Text(
                                                                      "${rateing_two * 100}%"),
                                                                  animation:
                                                                      true,
                                                                  lineHeight:
                                                                      15.0,
                                                                  animationDuration:
                                                                      2500,
                                                                  percent:
                                                                      rateing_two,
                                                                  linearStrokeCap:
                                                                      LinearStrokeCap
                                                                          .roundAll,
                                                                  progressColor:
                                                                      WidgetColors
                                                                          .graph4,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            // color: Colors.black,
                                                            width: width / 3.5,
                                                            child: customText(
                                                                worst,
                                                                width * .05,
                                                                Colors.black,
                                                                FontWeight
                                                                    .w400),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              // width: width ,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            04.0),
                                                                child:
                                                                    new LinearPercentIndicator(
                                                                  // width: width / 7,
                                                                  center: new Text(
                                                                      "${rateing_one * 100}%"),
                                                                  animation:
                                                                      true,
                                                                  lineHeight:
                                                                      15.0,
                                                                  animationDuration:
                                                                      2500,
                                                                  percent:
                                                                      rateing_one,
                                                                  linearStrokeCap:
                                                                      LinearStrokeCap
                                                                          .roundAll,
                                                                  progressColor:
                                                                      WidgetColors
                                                                          .graph5,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                  )
                                : Center(
                                    child: PlatformLoader(
                                      color: WidgetColors.buttonColor,
                                      radius: 15,
                                    ),
                                  ),
                          ),
                          Container(
                            height: height * .02,
                          ),
                          Container(
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                customText(most_helpful_review, width * .05,
                                    Colors.black, FontWeight.w500),
                                Container(
                                  height: height * .02,
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: height / 5.5,
                                    width: width,
                                    child: commentsSection(height, width))
                              ],
                            ),
                          ),
                          Container(
                            height: height * .03,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: MaterialButtonClassPage(
                                  height: height * .06,
                                  radius: BorderRadius.circular(05),
                                  buttonName: book_data,
                                  onPress: () {
                                    // BackFunction.commonNavigator(
                                    //     context,
                                    //     PaymentScreen(
                                    //       serviceId:
                                    //           widget.serviceId.toString(),
                                    //       technician_id: widget.id.toString(),
                                    //     ));
                                    bookTechnician();
                                  },
                                  color: WidgetColors.buttonColor,
                                  minwidth: width,
                                  fontSize: width * .04,
                                ),
                              ),
                              Container(
                                width: 10,
                              ),
                              Expanded(
                                  child: Stack(
                                children: [
                                  Container(
                                    height: height * .06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(05),
                                        border: Border.all(
                                            color: WidgetColors.buttonColor)),
                                    child: Center(
                                      child: Text(
                                        cancel,
                                        style: GoogleFonts.poppins(
                                            color: WidgetColors.buttonColor,
                                            fontSize: width * .04),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0.0,
                                    top: 0.0,
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        splashColor: WidgetColors.buttonColor,
                                        onTap: () async {
                                          await Future.delayed(
                                              Duration(milliseconds: 200));
                                          onWillPop();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ],
                          ),
                          Container(
                            height: height * .04,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
      onWillPop: () {
        return onWillPop();
      },
    );
  }

  Future bookTechnician() async {
    final responce = await http.post(update_job_status, body: {
      "service_request_id": widget.serviceId.toString(),
      "technician_id": widget.id.toString()
    });
    if (responce.statusCode == 200) {
      final data = json.decode(responce.body);
      if (data['data'] == "1" || data['data'] == 1) {
        BackFunction.slideLeftNavigator(
            context,
            BottomNavBarPage(
              initialIndex: 1,
              initialIndexJob: 1,
            ));
      } else {
        ValidationData.customToast(
            data['message'], Colors.black, Colors.white, ToastGravity.BOTTOM);
      }
    }
  }
}
