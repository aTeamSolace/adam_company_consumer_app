import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BestOffersDescription extends StatefulWidget {
  var image;
  var offerName;
  var startDate;
  var endDate;
  var offerDescription;

  BestOffersDescription(
      {@required this.image,
      @required this.endDate,
      @required this.offerName,
      @required this.startDate,
      @required this.offerDescription});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<BestOffersDescription> {
  onWillPop() {
    return BackFunction.scaleNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 0,
          initialIndexJob: 0,
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

  var myFullFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var startdate = DateTime.parse(widget.startDate.toString());
    var enddate = DateTime.parse(widget.endDate.toString());
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
            title:
                customText(ofr_detail, 18, WidgetColors.blackColor, FontWeight.w400),
          ),
          body: SafeArea(
              child: Center(
                  child: Container(
            width: width / 1.1,
            height: height,
            child: PlatformScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height * .03,
                    ),
                    Card(
                        color: Colors.transparent,
                        elevation: 7,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height / 3,
                            width: width,
                            child: ClipRRect(
                              child: Image.network(
                                widget.image,
                                fit: BoxFit.fill,
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
                              borderRadius: BorderRadius.circular(10),
                            ))),
                    Container(
                      height: height * .02,
                    ),
                    customText(
                        widget.offerName, 20, Colors.black, FontWeight.w500),
                    Container(
                      height: height * .02,
                    ),

                    RichText(
                      text: TextSpan(
                        text: "$ofr_detail: ",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.offerDescription,
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade800, fontSize: 17),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   children: [
                    //     customText(
                    //         "Offer Limited to", 18, Colors.black, FontWeight.w500),
                    //     Flexible(
                    //       child: customText(widget.serviceDate, 17,
                    //           Colors.black, FontWeight.normal),
                    //       fit: FlexFit.loose,
                    //     )
                    //   ],
                    // ),
                    Container(
                      height: height * .02,
                    ),

                    RichText(
                      text: TextSpan(
                        text: ofer_valid_frm,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        children: <TextSpan>[
                          TextSpan(
                            text: myFullFormat.format(startdate),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                          TextSpan(
                            text: to_data,
                            style: GoogleFonts.poppins(
                                color: Colors.grey.shade800, fontSize: 18),
                          ),
                          TextSpan(
                            text: myFullFormat.format(enddate),
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: height * .04,
                    ),
                    MaterialButtonClassPage(
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
                  ],
                ),
              ),
            ),
          ))),
        ),
        onWillPop: () {
          return onWillPop();
        });
  }
}
