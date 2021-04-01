import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/get_main_category_model.dart';
import 'package:adam_company_consumer_app/network/model/get_service_model.dart';
import 'package:adam_company_consumer_app/ui/page_data/sub_service_listing.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/get_service_description.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceListingPage extends StatefulWidget {
  var serviceListing;

  ServiceListingPage({@required this.serviceListing});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<ServiceListingPage> {
  List<GetMainCategoryResult> servicesResult = [];

  @override
  initState() {

    // print("========>>ServiceListingPage first ${widget.serviceListing}");

    servicesResult = widget.serviceListing;
    super.initState();
  }

  Widget customText(
    var title,
    double height,
    Color color,
    FontWeight fontWeight,
  ) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: height,
        color: color,
        fontWeight: fontWeight,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  onWillPop() {
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 0,
          initialIndexJob: 0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: WidgetColors.themeColor,
            centerTitle: true,
            title: customText(
                all_services, 18, WidgetColors.blackColor, FontWeight.w400),
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
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: SafeArea(
              child: Container(
                  child: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: PlatformScrollbar(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
                    childAspectRatio: 0.9),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      InkWell(
                        splashColor: WidgetColors.buttonColor,
                        child: Card(
                            elevation: 8,
                            child: Column(
                              children: [
                                Expanded(
                                    child: FadeInImage(
                                  fit: BoxFit.fill,
                                  placeholder: AssetImage(splashScreenLogo),
                                  image: NetworkImage(
                                    servicesResult[index].image_path,
                                  ),
                                )),
                                Container(
                                    height: height * .06,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: customText(
                                          servicesResult[index].category,
                                          width * .03,
                                          Colors.black,
                                          FontWeight.w500),
                                    )

                                    ),
                              ],
                            )),
                        onTap: () {},
                      ),
                      Positioned(
                        left: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                        right: 0.0,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              BackFunction.slideRightNavigator(
                                  context,
                                  SubServiceListing(
                                    fromPage: "listing_page",
                                    categoryName: servicesResult[index].category.toString(),
                                    categoryId: servicesResult[index].id.toString(),
                                    serviceListing: widget.serviceListing,
                                  ));
                              // BackFunction.scaleNavigator(
                              //     context,
                              //     GetServiceDescription(
                              //       serviceDescription:
                              //           servicesResult[index].description,
                              //       image: servicesResult[index].image,
                              //       offerName:
                              //           servicesResult[index].serviceTitle,
                              //       service_id: servicesResult[index].serviceId,
                              //       payent_type: servicesResult[index]
                              //           .paymentPercent
                              //           .toString(),
                              //       category: servicesResult[index]
                              //           .serviceCategoriy
                              //           .toString(),
                              //       servicesResult: servicesResult,
                              //       fromPage: "serviceListingPage",
                              //     ));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: servicesResult.length,
              ),
            )),
          ))),
        ),
        onWillPop: () {
          return onWillPop();
        });
  }
}
