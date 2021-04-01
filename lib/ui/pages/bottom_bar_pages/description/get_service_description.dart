import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/page_data/sub_service_listing.dart';
import 'package:adam_company_consumer_app/ui/pages/forms/service_request_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class GetServiceDescription extends StatefulWidget {
  var image;
  var offerName;
  var category;
  var payent_type;
  var service_id;
  var serviceDescription;
  var servicesResult;
  var fromPage;
  var fromPageName;
  var navigatePage;

  GetServiceDescription(
      {@required this.image,
      @required this.service_id,
      @required this.category,
      @required this.offerName,
      @required this.serviceDescription,
      @required this.payent_type,
      @required this.servicesResult,
      @required this.fromPage,
      this.fromPageName, this.navigatePage});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<GetServiceDescription> {
  // onWillPop() {
  //   return BackFunction.scaleNavigator(
  //       context,
  //       BottomNavBarPage(
  //         initialIndex: 0,
  //         initialIndexJob: 0,
  //       ));
  // }

  @override
  initState() {
    // print("========>>ServiceListingPage ${widget.fromPageName}");
    // print("========>>ServiceListingPage ${widget.fromPage}");
    // print("========>>ServiceListingPage GetServiceDescription ${widget.servicesResult}");

    super.initState();
  }

  onWillPop() {
    return BackFunction.scaleNavigator(
        context,
        SubServiceListing(
          categoryName: widget.fromPageName,
          categoryId: widget.fromPage.toString(),
          fromPage: widget.navigatePage.toString(),
          serviceListing: widget.servicesResult,
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
                service_detail, 18, WidgetColors.blackColor, FontWeight.w400),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height / 3,
                            width: width,
                            child: ClipRRect(
                              child: FadeInImage(
                                fit: BoxFit.fill,
                                placeholder: AssetImage(splashScreenLogo),
                                image: NetworkImage(
                                  "http://socialenginespecialist.com/PuneDC/adamcompanies/public/public/uploads/tech_service_simage/" +
                                      widget.image,
                                ),
                              ),
                              // Image.network(
                              //   "http://socialenginespecialist.com/PuneDC/adamcompanies/public/public/uploads/tech_service_simage/" + widget.image,
                              //   fit: BoxFit.fill,
                              //   loadingBuilder: (BuildContext context,
                              //       Widget child,
                              //       ImageChunkEvent loadingProgress) {
                              //     if (loadingProgress == null) return child;
                              //     return Center(
                              //       child: CircularProgressIndicator(
                              //         valueColor:
                              //             new AlwaysStoppedAnimation<Color>(
                              //                 WidgetColors.buttonColor),
                              //         value: loadingProgress
                              //                     .expectedTotalBytes !=
                              //                 null
                              //             ? loadingProgress
                              //                     .cumulativeBytesLoaded /
                              //                 loadingProgress.expectedTotalBytes
                              //             : null,
                              //       ),
                              //     );
                              //   },
                              // ),
                              borderRadius: BorderRadius.circular(10),
                            ))),
                    Container(
                      height: height * .02,
                    ),
                    customText(widget.offerName, width * .06, Colors.black,
                        FontWeight.w500),
                    Container(
                      height: height * .02,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "$service_detail: ",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: width * .05,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.serviceDescription,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width * .05),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .02,
                    ),
                    RichText(
                      text: TextSpan(
                        text: service_cat,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: width * .05,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.category,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width * .05),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .02,
                    ),
                    RichText(
                      text: TextSpan(
                        text: payment_type,
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: width * .05,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.payent_type,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: width * .05),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * .02,
                    ),
                    MaterialButtonClassPage(
                      height: height * .06,
                      radius: BorderRadius.circular(05),
                      buttonName: service_book,
                      onPress: () {
                        BackFunction.scaleNavigator(
                            context,
                            ServiceRequestClass(
                              service_name: widget.offerName,
                              service_id: widget.service_id.toString(),
                              fromPage: widget.fromPage,
                              servicesResult: widget.servicesResult,
                            ));
                      },
                      color: Colors.white38,
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
