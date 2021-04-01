import 'dart:convert';
import 'dart:io';
import 'package:adam_company_consumer_app/network/model/get_service_model.dart';
import 'package:adam_company_consumer_app/ui/page_data/service_listing.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/get_service_description.dart';
import 'package:adam_company_consumer_app/widget/list_view_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class SubServiceListing extends StatefulWidget {
  var categoryId;
  var categoryName;
  var fromPage;
  var serviceListing;


  SubServiceListing(
      {this.categoryId, this.categoryName, this.fromPage, this.serviceListing});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<SubServiceListing> {
  @override
  void initState() {
    // print("========>>SubServiceListing 2dddddsfdf${widget.serviceListing}");

    // TODO: implement initState
    loading = true;
    getServices(widget.categoryId.toString());
    super.initState();
  }

  onWillPop() {
    if (widget.fromPage.toString() == "main_page") {
      return BackFunction.slideLeftNavigator(
          context,
          BottomNavBarPage(
            initialIndex: 0,
            initialIndexJob: 0,
          ));
    } else {
      return BackFunction.slideLeftNavigator(
          context,
          ServiceListingPage(
            serviceListing: widget.serviceListing,
          ));
    }
  }

  bool loading;
  List<SubCategoryResult> searchResult = [];

  List<SubCategoryResult> servicesResult = [];

  Future<SubCategoryResult> getServices(var categoryId) async {
    final response = await http.get(get_sub_services + categoryId.toString());
    final responseJson = json.decode(response.body);
    // print("getSubServices : ${responseJson}");
    // print("getSubServices : ${categoryId}");
    if (this.mounted) {
      setState(() {
        if (responseJson['status'] == 200 || responseJson['status'] == "200") {
          loading = false;
          // setState(() {
          //   servicesResult.add(responseJson);
          //   print("getSubServices : ${servicesResult}");
          // });
          for (Map service in responseJson['data']) {
            setState(() {
              // print("getSubServices : ${service}");
              return servicesResult.add(SubCategoryResult.fromJson(service));
            });
          }
        } else {
          ValidationData.customToast(
              smth_wrng, Colors.red, Colors.white, ToastGravity.BOTTOM);
        }
      });
    }
  }

  TextEditingController controller = new TextEditingController();

  Widget gridLayout(double height) {
    if (loading == true) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Center(
          child:
          // LoadingBouncingGrid.circle(
          //   borderColor: WidgetColors.bgColor,
          //   backgroundColor: WidgetColors.buttonColor,
          // )
          PlatformLoader(
            color: WidgetColors.buttonColor,
            radius: 15,
          ),
        ),
      );
    } else if (searchResult.length == 0 && controller.text.isNotEmpty ||
        servicesResult.length == 0) {
      return Container(
          child: Center(
            child: Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: customText(
                    no_services_found, 14, Colors.black, FontWeight.w500)),
          ));
    } else {
      return Container(
          child: searchResult.length != 0 || controller.text.isNotEmpty
              ? Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 3.0,
                  mainAxisSpacing: 3.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    splashColor: WidgetColors.buttonColor,
                    child: Card(
                      elevation: 8,
                      child: Container(
                        decoration: BoxDecoration(
//                                border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: AssetImage(splashScreenLogo),
                                  image: NetworkImage(
                                    searchResult[index].image,
                                  ),
                                )),
                            Container(
                              height: height * .01,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  searchResult[index].serviceTitle,
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        .03,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      // BackFunction.scaleNavigator(
                      //     context,
                      //     GetServiceDescription(
                      //       serviceDescription:
                      //       searchResult[index].description,
                      //       image: searchResult[index].image,
                      //       offerName: searchResult[index].serviceTitle,
                      //       service_id: searchResult[index].serviceId,
                      //       payent_type: searchResult[index]
                      //           .paymentPercent
                      //           .toString(),
                      //       category: searchResult[index]
                      //           .serviceCategoriy
                      //           .toString(),
                      //       servicesResult: searchResult,
                      //       fromPage: "mainPage",
                      //     ));
                    },
                  );
                },
                itemCount: searchResult.length,
              ))
              : Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: GridView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 3.0,
                mainAxisSpacing: 3.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return WidgetANimator(Stack(
                  children: [
                    InkWell(
                      child: Card(
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder:
                                    AssetImage(splashScreenLogo),
                                    image: NetworkImage(
                                      "https://adamcompanies.com:8008/public/public/uploads/tech_service_simage/" +
                                          servicesResult[index].image,
                                    ),
                                  ),
                                )),
                            Container(
                              height: height * .01,
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  servicesResult[index].serviceTitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: MediaQuery
                                        .of(context)
                                        .size
                                        .width *
                                        .03,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  softWrap: true,
                                  maxLines: 2,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
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
                            await Future.delayed(
                                Duration(milliseconds: 200));

                            // print("========>>SubServiceListing 3");

                            BackFunction.scaleNavigator(
                                context,
                                GetServiceDescription(
                                  serviceDescription:
                                  servicesResult[index].description,
                                  image: servicesResult[index].image,
                                  offerName:
                                  servicesResult[index].serviceTitle,
                                  service_id:
                                  servicesResult[index].serviceId,
                                  payent_type: servicesResult[index]
                                      .paymentPercent
                                      .toString(),
                                  category: servicesResult[index]
                                      .serviceCategoriy
                                      .toString(),
                                  servicesResult: widget.serviceListing,
                                  // servicesResult,
                                  fromPage: widget.categoryId.toString(),
                                  fromPageName:
                                  widget.categoryName.toString(),
                                  navigatePage:
                                  widget.fromPage.toString(),
                                ));
                          },
                        ),
                      ),
                    ),
                  ],
                ));
              },
              itemCount: servicesResult.length,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: WidgetColors.themeColor,
          centerTitle: true,
          title: customText(widget.categoryName.toString(), 18,
              WidgetColors.blackColor, FontWeight.w400),
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
        body: Container(
          child: gridLayout(height),
        ),
      ),
      onWillPop: () {
        return onWillPop();
      },
    );
  }
}
