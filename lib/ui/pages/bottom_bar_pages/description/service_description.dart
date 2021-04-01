import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_screen.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDescription extends StatefulWidget {
  var serviceName;
  var serviceType;
  var serviceDate;
  var serviceLocation;
  var serviceStatus;
  var serviceDetails;
  var serviceImage;
  var fromPage;
  int pageId;
  var index;
  List images;
  var service_id;
  var tech_id;

  ServiceDescription(
      {@required this.serviceDate,
      @required this.serviceName,
      @required this.serviceDetails,
      @required this.serviceLocation,
      @required this.serviceStatus,
      @required this.serviceImage,
      @required this.fromPage,
      this.serviceType,
      this.images,
      this.service_id,
      @required this.index,
      @required this.pageId,
      this.tech_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<ServiceDescription> {
  @override
  initState() {

    print("Ongoing_tech_id ==>> ${widget.tech_id}");
    print("Ongoing_service_id ==>> ${widget.service_id}");
    imageSliders = widget.images
        .map(
          (item) => Container(
            height: 500,
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(
                service_img + "/" + item,
                fit: BoxFit.fill,
                width: 1000.0,
                height: 500,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          WidgetColors.buttonColor),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        )
        .toList();
    super.initState();
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

  onWillPop() {
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: widget.pageId,
        ));
  }

  navigateToTech() {
    return BackFunction.scaleNavigator(
        context,
        PaymentScreen(
          serviceId: widget.service_id.toString(),
          technician_id: widget.tech_id.toString(),
        ));
  }

  List<Widget> imageSliders;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                service_detail, width * .05, WidgetColors.blackColor, FontWeight.w400),
          ),
          body: SafeArea(
              child: Center(
                  child: Container(
                      width: width / 1.1,
                      height: height,
//              color: Colors.blueGrey,
                      child: Column(
                        children: [
                          Container(
//                        color: Colors.black,
                            height: height * .03,
                          ),
                          Hero(
                            tag: widget.index,
                            child: Material(
                              child: VerticalSlider(
                                items: imageSliders,
                              ),
                              // Card(
                              //     color: Colors.transparent,
                              //     elevation: 7,
                              //     child: Container(
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //         ),
                              //         height: height / 3,
                              //         width: width,
                              //         child: ClipRRect(
                              //           child: Image.network(
                              //             widget.serviceImage,
                              //             fit: BoxFit.fill,
                              //             loadingBuilder: (BuildContext context,
                              //                 Widget child,
                              //                 ImageChunkEvent loadingProgress) {
                              //               if (loadingProgress == null) return child;
                              //               return Center(
                              //                 child: CircularProgressIndicator(
                              //                   valueColor:
                              //                       new AlwaysStoppedAnimation<Color>(
                              //                           WidgetColors.buttonColor),
                              //                   value: loadingProgress
                              //                               .expectedTotalBytes !=
                              //                           null
                              //                       ? loadingProgress
                              //                               .cumulativeBytesLoaded /
                              //                           loadingProgress
                              //                               .expectedTotalBytes
                              //                       : null,
                              //                 ),
                              //               );
                              //             },
                              //           ),
                              //           borderRadius: BorderRadius.circular(10),
                              //         ))),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: height * .02,
                                  ),
                                  Center(
                                    child: customText(
                                        widget.serviceName
                                            .toString()
                                            .toUpperCase(),
                                        width * .06,
                                        Colors.black,
                                        FontWeight.w500),
                                  ),
//                    Container(
//                      height: height * .02,
//                    ),
//                    Row(
//                      children: [
//                        customText(
//                            "Type : ", 18, Colors.black, FontWeight.w500),
//                        Flexible(
//                          child: customText("Bathroom Cleaning", 17,
//                              Colors.black, FontWeight.normal),
//                          fit: FlexFit.loose,
//                        )
//                      ],
//                    ),
                                  Container(
                                    height: height * .02,
                                  ),
                                  Row(
                                    children: [
                                      customText(date_, width * .05,
                                          Colors.black, FontWeight.w500),
                                      Flexible(
                                        child: customText(
                                            widget.serviceDate,
                                            width * .05,
                                            Colors.black,
                                            FontWeight.normal),
                                        fit: FlexFit.loose,
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: height * .02,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     customText(
                                  //         "Location : ", 18, Colors.black, FontWeight.w500),
                                  //     Flexible(
                                  //       child: customText(widget.serviceLocation, 17,
                                  //           Colors.black, FontWeight.normal),
                                  //       fit: FlexFit.loose,
                                  //     )
                                  //   ],
                                  // ),

                                  RichText(
                                    text: TextSpan(
                                      text: location,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: width * .05,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: widget.serviceLocation,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: width * .05),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * .02,
                                  ),
                                  Row(
                                    children: [
                                      customText(status, width * .05,
                                          Colors.black, FontWeight.w500),
                                      Flexible(
                                        child: customText(
                                            widget.serviceStatus.toString(),
                                            width * .05,
                                            Colors.black,
                                            FontWeight.normal),
                                        fit: FlexFit.loose,
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: height * .02,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: job_detai,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: width * .05,
                                          fontWeight: FontWeight.w500),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: widget.serviceDetails,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: width * .05),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: height * .05,
                                  ),
                                  Container(
                                    child: widget.fromPage ==
                                            "completed_service"
                                        ? MaterialButtonClassPage(
                                            height: height * .06,
                                            radius: BorderRadius.circular(05),
                                            buttonName: bcak,
                                            onPress: () {
                                              onWillPop();
                                            },
                                            color: WidgetColors.buttonColor,
                                            minwidth: width,
                                            fontSize: height / 37,
                                          )
                                        : MaterialButtonClassPage(
                                            height: height * .06,
                                            radius: BorderRadius.circular(05),
                                            buttonName: payment_info,
                                            onPress: () {
                                              navigateToTech();
                                            },
                                            color: WidgetColors.buttonColor,
                                            minwidth: width,
                                            fontSize: height / 37,
                                          ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )))),
        ),
        onWillPop: () {
          return onWillPop();
        });
  }
}

class VerticalSlider extends StatelessWidget {
  List<Widget> items = [];

  VerticalSlider({this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: items,
    );
  }
}
