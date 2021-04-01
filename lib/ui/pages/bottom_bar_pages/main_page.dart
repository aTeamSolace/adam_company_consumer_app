import 'dart:convert';

import 'package:adam_company_consumer_app/common/color_helper.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/common/validation_data.dart';
import 'package:adam_company_consumer_app/network/api_provider/api_provider.dart';
import 'package:adam_company_consumer_app/network/model/get_best_offers.dart';
import 'package:adam_company_consumer_app/network/model/get_main_category_model.dart';
import 'package:adam_company_consumer_app/network/model/get_service_model.dart';
import 'package:adam_company_consumer_app/platform_widget/custom_scoffold.dart';
import 'package:adam_company_consumer_app/ui/page_data/service_listing.dart';
import 'package:adam_company_consumer_app/ui/page_data/sub_service_listing.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/best_offers.dart';
import 'package:adam_company_consumer_app/ui/pages/terms_and_condition.dart';
import 'package:adam_company_consumer_app/widget/list_view_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animations/loading_animations.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  PersistentTabController persistentTabController;
  var location;

  MainPage({this.persistentTabController, this.location});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<MainPage> {
  bool loading;
  bool activeBanner;
  var bestServices;

  @override
  void initState() {
    // TODO: implement initState
    getCurrentLocation();
    loading = true;
    activeBanner = true;
    partnerLogoLoading = true;
    checkStoredAdress();
    getPartnersLogo();
    clearFields();
    checkSessionValue();
    super.initState();
  }

  clearFields() {
    setState(() {
      AllControllers.cityController.clear();
      AllControllers.addressController.clear();
      AllControllers.zipController.clear();
      AllControllers.stateController.clear();
      AllControllers.countryController.clear();
      AllControllers.serviceDescriptionController.clear();
    });
  }

  var user_id;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    getDeviceToken();
  }

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;

  getDeviceToken() {
    firebaseMessaging.getToken().then((token) {
      if (this.mounted) {
        setState(() {
          deviceToken = token.toString();
          DateTime now = new DateTime.now();
          if (now.day == "25" || now.day == 25) {
            updateToken(deviceToken);
          }
        });
      }
    });
  }

  Future updateToken(var devicetoekn) async {
    final response = await http.post(update_token, body: {
      "user_id": user_id.toString(),
      "role": "customer",
      "mobile_token": devicetoekn.toString()
    });
  }

  List<Widget> imageSliders;
  List<Widget> bestOffersdata;
  bool partnerLogoLoading;

  Future getPartnersLogo() async {
    final response = await http.get(get_partenrs_logo);
    // print("account responce:${response.body}");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          var myData = [];
          myData = responseJson['data'];
          partnerLogoLoading = false;
          imageSliders = myData
              .map(
                (item) =>
                Container(
                  // color: Colors.red,
                  // height: 50,
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Image.network(
                      item,
                      // fit: BoxFit.fill,
                      // width: 200.0,
                      // height: 50,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                WidgetColors.blackColor),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                      // color: Colors.red,
                    ),
                  ),
                ),
          )
              .toList();

          // print("account responce:${responseJson}");
//          print("account responce:${user_id.toString()}");
          loading = false;
        });
      }
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  var fullAddress;
  var fullAddressLat;
  var fullAddressLng;

  checkStoredAdress() async {
    SharedPreferences setLocation = await SharedPreferences.getInstance();
    fullAddress = setLocation.getString("fullAddress");
    fullAddressLat = setLocation.getString("addressLatitude");
    fullAddressLng = setLocation.getString("addressLongitude");

//    print("============>>${fullAddress}");
  }

  var currentAddress = ".";
  LatLng latLng;
  var countryName;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    var userLocation = placemarks.first;

    if (this.mounted) {
      setState(() {
        latLng = new LatLng(position.latitude, position.longitude);

        currentAddress = userLocation.name +
            " " +
            userLocation.subLocality +
            " " +
            userLocation.locality;
        countryName = userLocation.country.toLowerCase();

        getServices();
        bestServices = getBestOffers();
        getActiveBanner();
      });
    }
  }

  List<ResultData> searchResult = [];

  List<ResultData> servicesResult = [];
  List<GetMainCategryModel> getMainServiecs = [];

  Future<ResultData> getServices() async {
    final response = await http
        .post(get_services, body: {"country": countryName.toString()});
    final responseJson = json.decode(response.body);
    // print("getServices : ${responseJson}");
    if (this.mounted) {
      setState(() {
        if (responseJson['status'] == 200 || responseJson['status'] == "200") {
          loading = false;
          for (Map service in responseJson['data']) {
            setState(() {
              return servicesResult.add(ResultData.fromJson(service));
            });
          }
        } else {
          ValidationData.customToast(
              smth_wrng, Colors.red, Colors.white, ToastGravity.BOTTOM);
        }
      });
    }
  }

  var bannerData;

  Future getActiveBanner() async {
    final response = await http.post(get_active_banner, body: {
      "country": countryName.toString() // "Anguilla"  // countryName.toString()
    });
    // + "?country=${countryName.toString()}");
    // print("getActiveBanner : ${response.body}");
    // print("getActiveBanner : ${countryName}");
    final responseJson = json.decode(response.body);
    if (this.mounted) {
      setState(() {
        if (responseJson['status'] == 200 || responseJson['status'] == "200") {
          bannerData = responseJson['data'];
          activeBanner = false;
        } else {
          ValidationData.customToast(
              smth_wrng, Colors.red, Colors.white, ToastGravity.BOTTOM);
        }
      });
    }
  }

  // ${countryName.toString()}
  Future getBestOffers() async {
    final response = await http.get(get_best_offers +
        "?country=${countryName.toString()}"); //${countryName.toString()}
    if (response.statusCode == 200) {
      List<GetBestOffersResult> bestServices;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          // print("Best Offers Responce${responseJson}");
          // print("Best Offers Responce${countryName.toString()}");
          bestServices = GetBestOffersModel
              .fromJson(responseJson)
              .data;
        });
      }
      return bestServices;
    } else {
      throw Exception('Failed to load Best Offers');
    }
  }

  Widget bestOffers() {
    return FutureBuilder(
      future: bestServices,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 0),
                  child: PlatformScrollbar(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(5),
                              itemBuilder: (BuildContext context, int index) {
                                return WidgetANimator(Stack(
                                  children: [
                                    Card(
                                        elevation: 8,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
//                                mainAxisSize: MainAxisSize.min,
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              child: ClipRRect(
                                                child: Image.network(
                                                  snapshot.data[index]
                                                      .imagePath,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder: (
                                                      BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child: CircularProgressIndicator(
                                                        valueColor:
                                                        new AlwaysStoppedAnimation<
                                                            Color>(
                                                            WidgetColors
                                                                .blackColor),
                                                        value: loadingProgress
                                                            .expectedTotalBytes !=
                                                            null
                                                            ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight: Radius.circular(
                                                        5)),
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              height:
                                              MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width /
                                                  2.5,
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width,
                                            ),
                                            // Container(
                                            //   height: MediaQuery.of(context).size.height *
                                            //       .01,
                                            // ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Container(
                                                // color: Colors.blue,
                                                height:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    .06,
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: customText(
                                                      snapshot.data[index]
                                                          .offerName
                                                          .toString(),
                                                      MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height *
                                                          .06,
                                                      Colors.black,
                                                      FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 5),
                                              child: Container(
                                                // color: Colors.blue,
                                                height:
                                                MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width *
                                                    .05,
                                                child: FittedBox(
                                                    fit: BoxFit.contain,
                                                    child: Text(
                                                      snapshot.data[index]
                                                          .description
                                                          .toString(),
                                                      maxLines: 1,
                                                      style: GoogleFonts
                                                          .poppins(
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .size
                                                            .width *
                                                            .05,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .normal,
                                                      ),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    )),
                                              ),
                                            ),
                                            Container(
                                              height: 2,
                                            ),
                                          ],
                                        )),
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
                                            BackFunction.fadeNavigation(
                                                context,
                                                BestOffersDescription(
                                                  startDate: snapshot
                                                      .data[index].startDate
                                                      .toString(),
                                                  endDate: snapshot.data[index]
                                                      .endDate
                                                      .toString(),
                                                  offerDescription: snapshot
                                                      .data[index].description
                                                      .toString(),
                                                  offerName: snapshot
                                                      .data[index].offerName
                                                      .toString(),
                                                  image: snapshot.data[index]
                                                      .imagePath,
                                                ));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                              },
                              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //   crossAxisCount: 2,
                              //   crossAxisSpacing: 5.0,
                              //   mainAxisSpacing: 5.0,
                              // ),
                            ),
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 3,
                          ),
                          Container(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * .02,
                          ),
                        ],
                      )),
                ));
          } else {
            return Container(
              height: 150,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: customText(
                        no_offers_found, 14, Colors.black, FontWeight.w500)),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 3.5,
            child: Card(
              child: Center(
                  child: LoadingBouncingGrid.circle(
                    borderColor: WidgetColors.whiteColor,
                    backgroundColor: WidgetColors.blackColor,
                  )),
            ));
      },
    );
  }

  Future clearAddress() async {
    SharedPreferences setLocation = await SharedPreferences.getInstance();
    setLocation.setString("fullAddress", "null");
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndexJob: 0,
          initialIndex: 0,
        ));
  }

  LocationResult _pickedLocation;
  Geolocator geolocator = Geolocator();

  void modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 3,
            color: Colors.transparent,
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ListTile(
                          title: customText(select_location, 16, Colors.black,
                              FontWeight.w500),
                          trailing: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                        Positioned(
                          left: 0.0,
                          top: 0.0,
                          bottom: 0.0,
                          right: 0.0,
                          child: InkWell(
                            // splashColor: WidgetColors.whiteColor,
                            onTap: () async {
                              await Future.delayed(Duration(milliseconds: 200));
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.my_location_rounded,
                            color: Colors.red,
                          ),
                          title: customText(use_other_locatn, 16, Colors.red,
                              FontWeight.w500),
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
                              // splashColor: WidgetColors.blackColor,
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                Navigator.pop(context);
                                clearAddress();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.location_on_sharp,
                            color: Colors.black,
                          ),
                          title: customText(select_other_location, 16,
                              Colors.black, FontWeight.w500),
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
                              // splashColor: WidgetColors.blackColor,
                              onTap: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                LocationResult result = await showLocationPicker(
                                    context,
                                    "AIzaSyAO8dCr_tSOIoRgnSjil-ajIgbIjJqBlZo",
                                    initialCenter: latLng,
                                    myLocationButtonEnabled: true,
                                    layersButtonEnabled: true,
                                    desiredAccuracy: LocationAccuracy.best,
                                    resultCardDecoration: BoxDecoration(
                                        color: Colors.black,
                                        border: Border.all(
                                            color: WidgetColors.buttonColor,
                                            width: 2)));
                                setState(() => _pickedLocation = result);

                                SharedPreferences setLocation =
                                await SharedPreferences.getInstance();
                                setLocation.setString(
                                    "fullAddress", result.address.toString());
                                setLocation.setString("addressLatitude",
                                    result.latLng.latitude.toString());
                                setLocation.setString("addressLongitude",
                                    result.latLng.longitude.toString());
                                // Navigator.of(context).pop();
                                BackFunction.commonNavigator(
                                    context,
                                    BottomNavBarPage(
                                      initialIndexJob: 0,
                                      initialIndex: 0,
                                      location: result.address.toString(),
                                    ));

                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        });
  }

  List<GetMainCategoryResult> getMainCategoryResult = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: WidgetColors.themeColor, //Colors.white,
          title: InkWell(
            child: Stack(
              children: [
                ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: WidgetColors.blackColor,
                      size: 20,
                    ),
                    title: Text(
                      fullAddress == null || fullAddress == "null"
                          ? currentAddress.toString()
                          : fullAddress.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: WidgetColors.blackColor,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 1,
                    )),
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
                        modalBottomSheetMenu(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            onTap: () {},
          ),
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            child: Container(
              color: WidgetColors.bgColor,
              height: height,
              width: width,
              child: PlatformScrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height / 3.0,
                        child: activeBanner
                            ? Center(
                            child: LoadingBouncingGrid.circle(
                              borderColor: WidgetColors.whiteColor,
                              backgroundColor: WidgetColors.blackColor,
                            ))
                            : Card(
                          color: Colors.transparent,
                          child: Container(
                            width: width,
                            child: bannerData != null
                                ? ClipRRect(
                              child: Image.network(
                                bannerData['image_path'],
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent
                                    loadingProgress) {
                                  if (loadingProgress == null)
                                    return child;
                                  return Center(
                                    child:
                                    CircularProgressIndicator(
                                      valueColor:
                                      new AlwaysStoppedAnimation<
                                          Color>(
                                          WidgetColors
                                              .blackColor),
                                      value: loadingProgress
                                          .expectedTotalBytes !=
                                          null
                                          ? loadingProgress
                                          .cumulativeBytesLoaded /
                                          loadingProgress
                                              .expectedTotalBytes
                                          : null,
                                    ),
                                  );
                                },
                              ),
                              borderRadius:
                              BorderRadius.circular(10),
                            )
                                : Container(
                              child: Center(
                                child: customText(
                                    no_actiove_banner_yet,
                                    14,
                                    Colors.black,
                                    FontWeight.w500),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          elevation: 8,
                        ),
                        margin: EdgeInsets.all(10),
                      ),
                      // Container(
                      //     child: servicesResult.length >= 16 &&
                      //             searchResult.length == 0
                      //         ? Container(
                      //             // color: Colors.black,
                      //             child: MediaQuery.removePadding(
                      //                 context: context,
                      //                 removeTop: true,
                      //                 child: Center(
                      //                   child: gridLayout(height),
                      //                 )),
                      //             height: height / 1.6,
                      //           )
                      //         : MediaQuery.removePadding(
                      //             context: context,
                      //             removeTop: true,
                      //             child: gridLayout(height),
                      //           )),
                      Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: 0, left: 10, right: 10),
                                  child: FutureBuilder(
                                    future: Provider.of<GetApiDataProvider>(
                                        context,
                                        listen: false)
                                        .getMainCategory(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<GetMainCategryModel>
                                        snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.data.length > 0) {
                                          getMainCategoryResult =
                                              snapshot.data.data.toList();
                                          // print("============>>${snapshot.data.data.length}");
                                          return MediaQuery.removePadding(
                                            child: Column(
                                              children: [
                                                MaterialButtonClassPage(
                                                  height: height * .06,
                                                  radius:
                                                  BorderRadius.circular(05),
                                                  buttonName: show_all_services,
                                                  onPress: () {
                                                    BackFunction.sizeNavigator(
                                                        context,
                                                        ServiceListingPage(
                                                          serviceListing:
                                                          getMainCategoryResult,
                                                        ));
                                                  },
                                                  color: Colors.yellow.shade600,
                                                  // WidgetColors.secondButton,
                                                  minwidth:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width /
                                                      1.5,
                                                  fontSize:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width *
                                                      .04,
                                                ),
                                                Container(
                                                  height: 10,
                                                ),
                                                GridView.builder(
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: 6,
                                                  // padding: EdgeInsets.only(
                                                  //     bottom: kFloatingActionButtonMargin + 48),
                                                  gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 5.0,
                                                    mainAxisSpacing: 5.0,
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return WidgetANimator(
                                                        InkWell(
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                  Colors.white,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8)),
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                      ClipRRect(
                                                                          child:
                                                                          FadeInImage(
                                                                            fit:
                                                                            BoxFit
                                                                                .fill,
                                                                            placeholder:
                                                                            AssetImage(
                                                                                splashScreenLogo),
                                                                            image:
                                                                            NetworkImage(
                                                                              snapshot
                                                                                  .data
                                                                                  .data[index]
                                                                                  .image_path,
                                                                            ),
                                                                          ),
                                                                          borderRadius: BorderRadius
                                                                              .only(
                                                                              topLeft: Radius
                                                                                  .circular(
                                                                                  8),
                                                                              topRight: Radius
                                                                                  .circular(
                                                                                  8)))),
                                                                  Expanded(
                                                                      child: Center(
                                                                        child: customText(
                                                                            snapshot
                                                                                .data
                                                                                .data[
                                                                            index]
                                                                                .category
                                                                                .toString(),
                                                                            MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width *
                                                                                .03,
                                                                            Colors
                                                                                .black,
                                                                            FontWeight
                                                                                .normal),
                                                                      )
                                                                    // flex: 1,
                                                                  )
                                                                ],
                                                              )),
                                                          onTap: () {
                                                            // print("========>>main page 1");
                                                            BackFunction
                                                                .slideRightNavigator(
                                                                context,
                                                                SubServiceListing(
                                                                  fromPage:
                                                                  "main_page",
                                                                  categoryName: snapshot
                                                                      .data
                                                                      .data[
                                                                  index]
                                                                      .category
                                                                      .toString(),
                                                                  categoryId: snapshot
                                                                      .data
                                                                      .data[
                                                                  index]
                                                                      .id
                                                                      .toString(),
                                                                ));
                                                          },
                                                        ));
                                                  },
                                                ),
                                              ],
                                            ),
                                            removeTop: true,
                                            context: context,
                                          );
                                        } else {
                                          return Center(
                                            child: Text(
                                              no_services_found,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Text(
                                            snapshot.hasError.toString());
                                      }
                                      return Container(
                                        child: Center(
                                            child: LoadingBouncingGrid.circle(
                                              borderColor: WidgetColors.bgColor,
                                              backgroundColor:
                                              WidgetColors.blackColor,
                                            )),
                                        height: 150,
                                      );
                                    },
                                  )),
                              Container(
                                height: 10,
                              ),
                            ],
                          )),
                      Container(
                        height: 10,
                        color: Colors.white,
                        width: width,
                      ),
                      Container(
                        color: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .width * .05,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: customText(
                                      best_offers,
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width * .04,
                                      Colors.black,
                                      FontWeight.w500))),
                        ),
                        width: width,
                      ),
                      Container(
                        color: Colors.white,
                        child: bestOffers(),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        width: width,
                        // height: height / 6,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height * .02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: customText(proud_partenrs, width * .04,
                                  Colors.black, FontWeight.w500),
                            ),
                            Container(
                              height: height * .02,
                            ),
                            Padding(
                                padding: EdgeInsets.only(bottom: 0),
                                child: partnerLogoLoading
                                    ? Center(
                                    child: LoadingBouncingGrid.circle(
                                      borderColor: WidgetColors.whiteColor,
                                      backgroundColor:
                                      WidgetColors.blackColor,
                                    ))
                                    : Center(
                                    child: Container(
                                      // color: Colors.blue,
                                      child: VerticalSliderMain(
                                        items: imageSliders,
                                      ),
                                      height: height / 11,
                                      width: width,
                                    ))
                              // FlutterLogo(
                              //   size: 50,
                              // ),
                            )
                          ],
                        ),
                      ),
                      MaterialButtonClassPage(
                        height: height * .06,
                        radius: BorderRadius.circular(0),
                        buttonName: termscond,
                        onPress: () {
                          BackFunction.commonNavigator(
                              context, TermsAndCondition());
                        },
                        color: WidgetColors.secondButton,
                        minwidth: width / 1.5,
                        fontSize: width * .04,
                      ),
                      Container(
                        height: height * .09,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            padding: EdgeInsets.only(bottom: 0),
          ),
        ));
  }
}

class VerticalSliderMain extends StatelessWidget {
  List<Widget> items = [];

  VerticalSliderMain({@required this.items});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: .2,
        aspectRatio: 1.0,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
      ),
      items: items,
    );
  }
}
