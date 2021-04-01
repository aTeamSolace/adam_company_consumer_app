import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/page_data/service_listing.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:adam_company_consumer_app/widget/full_screen_popup.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRequestClass extends StatefulWidget {
  PersistentTabController persistentTabController;
  var service_id;
  var service_name;
  var fromPage;
  var servicesResult;

  var s_address;
  var s_city;
  var s_state;
  var s_country;
  var s_zipcode;

  ServiceRequestClass(
      {this.persistentTabController,
      @required this.service_id,
      @required this.service_name,
      @required this.fromPage,
      @required this.servicesResult,
      this.s_address,
      this.s_city,
      this.s_country,
      this.s_state,
      this.s_zipcode});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<ServiceRequestClass> {
  File img;
  var base64Image;
  var imageName;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;

  @override
  initState() {
    AllControllers.cityController.clear();
    AllControllers.addressController.clear();
    AllControllers.zipController.clear();
    AllControllers.stateController.clear();
    AllControllers.countryController.clear();
    checkSessionValue();
    AllControllers.serviceNameController =
        TextEditingController(text: widget.service_name);
    images.add("Add Image");
    images.add("Add Image");
    images.add("Add Image");
    getDeviceToken();
    button_tap_event = true;
    super.initState();
  }

  getDeviceToken() {
    firebaseMessaging.getToken().then((token) {
      if (this.mounted) {
        setState(() {
          deviceToken = token.toString();
        });
      }
    });
  }

  var user_id;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id = preferences.getString("user_id");
    });
  }

  var latitude;
  var longitude;

  bool profileautoValidate = false;
  final GlobalKey<FormState> profileformKeyValidate = GlobalKey<FormState>();
  final profilescaffoldKey = GlobalKey<ScaffoldState>();

  onWillPop(BuildContext context) {
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 0,
          initialIndexJob: 0,
        ));
    // if (widget.fromPage == "mainPage") {
    //   AllControllers.serviceDateController.clear();
    //   AllControllers.serviceDescriptionController.clear();
    //   AllControllers.serviceNameController.clear();
    //   AllControllers.phoneController.clear();
    //   AllControllers.cityController.clear();
    //   AllControllers.addressController.clear();
    //   AllControllers.zipController.clear();
    //   AllControllers.stateController.clear();
    //   AllControllers.countryController.clear();
    //   return BackFunction.slideLeftNavigator(
    //       context,
    //       BottomNavBarPage(
    //         initialIndex: 0,
    //         initialIndexJob: 0,
    //       ));
    // } else if (widget.fromPage == "serviceListingPage") {
    //   AllControllers.serviceDateController.clear();
    //   AllControllers.serviceDescriptionController.clear();
    //   AllControllers.serviceNameController.clear();
    //   AllControllers.phoneController.clear();
    //   AllControllers.cityController.clear();
    //   AllControllers.addressController.clear();
    //   AllControllers.zipController.clear();
    //   AllControllers.stateController.clear();
    //   AllControllers.countryController.clear();
    //   return BackFunction.sizeNavigator(
    //       context,
    //       ServiceListingPage(
    //         serviceListing: widget.servicesResult,
    //       ));
    // }
  }

  getAddress() async {
    LocationResult result = await showLocationPicker(
        context, "AIzaSyAO8dCr_tSOIoRgnSjil-ajIgbIjJqBlZo",
        // initialCenter: latLng,
        myLocationButtonEnabled: true,
        layersButtonEnabled: true,
        desiredAccuracy: LocationAccuracy.best,
        resultCardDecoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: WidgetColors.buttonColor, width: 2)));
    List<Placemark> placemarks = await placemarkFromCoordinates(
        result.latLng.latitude, result.latLng.longitude);

    setState(() {
      latitude = result.latLng.latitude.toString();
      longitude = result.latLng.longitude.toString();
      AllControllers.addressController = TextEditingController(
          text: placemarks.first.street.toString() +
              " " +
              placemarks.first.subLocality.toString());
      AllControllers.cityController = TextEditingController(
          text: placemarks.first.subAdministrativeArea.toString());
      AllControllers.stateController = TextEditingController(
          text: placemarks.first.administrativeArea.toString());
      AllControllers.countryController =
          TextEditingController(text: placemarks.first.country.toString());
      AllControllers.zipController =
          TextEditingController(text: placemarks.first.postalCode.toString());
    });

    //
    // print(
    //     "====================>>${placemarks.first.street}"); // n 32
    // print(
    //     "====================>>${placemarks.first.subLocality}"); // chowk
    // print(
    //     "====================>>${placemarks.first.subAdministrativeArea}"); // city
    // print(
    //     "====================>>${placemarks.first.administrativeArea}"); // mh
    // print(
    //     "====================>>${placemarks.first.country}"); //indiz
    // print(
    //     "====================>>${placemarks.first.postalCode}"); // post code

    // Navigator.of(context).pop();
    BackFunction.commonNavigator(
        context,
        ServiceRequestClass(
            service_id: widget.service_id.toString(),
            service_name: widget.service_name.toString(),
            fromPage: widget.fromPage.toString(),
            servicesResult: widget.servicesResult.toString()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
            key: profilescaffoldKey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: WidgetColors.blackColor),
              backgroundColor: WidgetColors.themeColor,
              centerTitle: true,
              automaticallyImplyLeading: true,
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
                    onWillPop(context);
//                    Navigator.pop(context);
//                    widget.persistentTabController.jumpToTab(0);
//                    pushNewScreen(context, screen: BottomNavBarPage(initialIndex: 0));
                  }),
              title: Text(
                service,
                style: TextStyle(fontSize: 18, color: WidgetColors.blackColor),
              ),
            ),
            body: SafeArea(
              child: Form(
                autovalidate: profileautoValidate,
                key: profileformKeyValidate,
                child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * .02,
                          ),
                          AbsorbPointer(
                            absorbing: true,
                            child: CustomTextInputData(
                                onChanged: () {},
                                dy: 0,
                                dx: 0,
                                right: 25,
                                left: 25,
                                blurRadius: 0,
                                spreadRadius: 0,
                                title: s_name,
                                hintText: "",
                                textEditingController:
                                    AllControllers.serviceNameController,
                                formFieldValidator: null,
                                textInputType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                obsecureText: false,
                                filledColor: WidgetColors.whiteColor,
                                fill: true,
                                enabledborderColor: Colors.black12,
                                input_text_color: Colors.black,
                                titleColor: Colors.black,
                                hint_text_color: Colors.black45,
                                error_text_color: Colors.black54,
                                content_padding: 15,
                                borderColor: Colors.black),
                          ),
                          Container(
                            height: height * .01,
                          ),
                          CustomTextInputData(
                              onChanged: () {},
                              maxline: 3,
                              dy: 0,
                              dx: 0,
                              right: 25,
                              left: 25,
                              blurRadius: 0,
                              spreadRadius: 0,
                              title: s_desc,
                              hintText: "",
                              textEditingController:
                                  AllControllers.serviceDescriptionController,
                              formFieldValidator: ValidationData.descValidator,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.sentences,
                              obsecureText: false,
                              filledColor: WidgetColors.whiteColor,
                              fill: true,
                              enabledborderColor: Colors.black12,
                              input_text_color: Colors.black,
                              titleColor: Colors.black,
                              hint_text_color: Colors.black45,
                              error_text_color: Colors.black54,
                              content_padding: 15,
                              borderColor: Colors.black),
                          Container(
                            height: height * .01,
                          ),
                          GestureDetector(
                            child: AbsorbPointer(
                              child: CustomTextInputData(
                                  onChanged: () {},
                                  suffix_icon: Icon(Icons.calendar_today),
                                  dy: 0,
                                  dx: 0,
                                  right: 25,
                                  left: 25,
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  title: s_date,
                                  hintText: select_date,
                                  textEditingController:
                                      AllControllers.serviceDateController,
                                  formFieldValidator:
                                      ValidationData.otpValidator,
                                  textInputType: TextInputType.datetime,
                                  textCapitalization: TextCapitalization.words,
                                  obsecureText: false,
                                  filledColor: WidgetColors.whiteColor,
                                  fill: true,
                                  enabledborderColor: Colors.black12,
                                  input_text_color: WidgetColors.blackColor,
                                  titleColor: WidgetColors.blackColor,
                                  hint_text_color: Colors.black45,
                                  error_text_color: Colors.black54,
                                  content_padding: 15,
                                  borderColor: Colors.black),
                              absorbing: true,
                            ),
                            onTap: () {
                              if (Platform.isIOS) {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: selectedDate,
                                    maxTime: DateTime(2050, 12, 31),
                                    theme: DatePickerTheme(
                                        headerColor: Colors.black12,
                                        backgroundColor:
                                            WidgetColors.themeColor,
                                        itemStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    onChanged: (date) {}, onConfirm: (date) {
                                  setState(() {
                                    AllControllers.serviceDateController =
                                        TextEditingController(
                                            text: myFormat.format(date));
                                  });
                                },
                                    currentTime: DateTime.now(),
                                    locale: LocaleType.en);
                              } else {
                                selectDate(context);
                              }
                            },
                          ),
                          Container(
                            height: height * .01,
                          ),
                          // InkWell(
                          //   child: AbsorbPointer(
                          //     absorbing: true,
                          //     child: CustomTextInputData(
                          //         onChanged: () {},
                          //         dy: 0,
                          //         dx: 0,
                          //         right: 25,
                          //         left: 25,
                          //         blurRadius: 0,
                          //         spreadRadius: 0,
                          //         title: addres,
                          //         hintText: "",
                          //         textEditingController:
                          //             AllControllers.addressController,
                          //         formFieldValidator:
                          //             ValidationData.addressValidator,
                          //         textInputType: TextInputType.text,
                          //         textCapitalization: TextCapitalization.words,
                          //         obsecureText: false,
                          //         filledColor: WidgetColors.whiteColor,
                          //         fill: true,
                          //         enabledborderColor: Colors.black12,
                          //         input_text_color: WidgetColors.blackColor,
                          //         titleColor: WidgetColors.blackColor,
                          //         hint_text_color: Colors.black45,
                          //         error_text_color: Colors.black54,
                          //         content_padding: 15,
                          //         borderColor: Colors.black),
                          //   ),
                          //   onTap: () {
                          //     // getAddress();
                          //     _onLoading();
                          //   },
                          // ),
                          CustomTextInputData(
                              onChanged: () {},
                              dy: 0,
                              dx: 0,
                              right: 25,
                              left: 25,
                              blurRadius: 0,
                              spreadRadius: 0,
                              title: addres,
                              hintText: "",
                              textEditingController:
                                  AllControllers.addressController,
                              formFieldValidator:
                                  ValidationData.addressValidator,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              obsecureText: false,
                              filledColor: WidgetColors.whiteColor,
                              fill: true,
                              enabledborderColor: Colors.black12,
                              input_text_color: WidgetColors.blackColor,
                              titleColor: WidgetColors.blackColor,
                              hint_text_color: Colors.black45,
                              error_text_color: Colors.black54,
                              content_padding: 15,
                              borderColor: Colors.black),
                          Container(
                            height: height * .01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomTextInputData(
                                      onChanged: () {},
                                      dy: 0,
                                      dx: 0,
                                      right: 5,
                                      left: 0,
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      title: city,
                                      hintText: "",
                                      textEditingController:
                                          AllControllers.cityController,
                                      formFieldValidator:
                                          ValidationData.cityValidator,
                                      textInputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obsecureText: false,
                                      filledColor: WidgetColors.whiteColor,
                                      fill: true,
                                      enabledborderColor: Colors.black12,
                                      input_text_color: WidgetColors.blackColor,
                                      titleColor: WidgetColors.blackColor,
                                      hint_text_color: Colors.black45,
                                      error_text_color: Colors.black54,
                                      content_padding: 15,
                                      borderColor: Colors.black),
                                  //     InkWell(
                                  //   onTap: () {
                                  //     // getAddress();
                                  //     _onLoading();
                                  //   },
                                  //   child: AbsorbPointer(
                                  //     absorbing: true,
                                  //     child: CustomTextInputData(
                                  //         onChanged: () {},
                                  //         dy: 0,
                                  //         dx: 0,
                                  //         right: 5,
                                  //         left: 0,
                                  //         blurRadius: 0,
                                  //         spreadRadius: 0,
                                  //         title: city,
                                  //         hintText: "",
                                  //         textEditingController:
                                  //             AllControllers.cityController,
                                  //         formFieldValidator:
                                  //             ValidationData.cityValidator,
                                  //         textInputType: TextInputType.text,
                                  //         textCapitalization:
                                  //             TextCapitalization.words,
                                  //         obsecureText: false,
                                  //         filledColor: WidgetColors.whiteColor,
                                  //         fill: true,
                                  //         enabledborderColor: Colors.black12,
                                  //         input_text_color:
                                  //             WidgetColors.blackColor,
                                  //         titleColor: WidgetColors.blackColor,
                                  //         hint_text_color: Colors.black45,
                                  //         error_text_color: Colors.black54,
                                  //         content_padding: 15,
                                  //         borderColor: Colors.black),
                                  //   ),
                                  // )
                                ),
                                Expanded(
                                  child: CustomTextInputData(
                                      onChanged: () {},
                                      dy: 0,
                                      dx: 0,
                                      right: 0,
                                      left: 5,
                                      blurRadius: 0,
                                      spreadRadius: 0,
                                      title: state,
                                      hintText: "",
                                      textEditingController:
                                          AllControllers.stateController,
                                      formFieldValidator:
                                          ValidationData.stateValidator,
                                      textInputType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obsecureText: false,
                                      filledColor: WidgetColors.whiteColor,
                                      fill: true,
                                      enabledborderColor: Colors.black12,
                                      input_text_color: WidgetColors.blackColor,
                                      titleColor: WidgetColors.blackColor,
                                      hint_text_color: Colors.black45,
                                      error_text_color: Colors.black54,
                                      content_padding: 15,
                                      borderColor: Colors.black),
                                  //     InkWell(
                                  //   onTap: () {
                                  //     // getAddress();
                                  //     _onLoading();
                                  //   },
                                  //   child: AbsorbPointer(
                                  //     absorbing: true,
                                  //     child: CustomTextInputData(
                                  //         onChanged: () {},
                                  //         dy: 0,
                                  //         dx: 0,
                                  //         right: 0,
                                  //         left: 5,
                                  //         blurRadius: 0,
                                  //         spreadRadius: 0,
                                  //         title: state,
                                  //         hintText: "",
                                  //         textEditingController:
                                  //             AllControllers.stateController,
                                  //         formFieldValidator:
                                  //             ValidationData.stateValidator,
                                  //         textInputType: TextInputType.text,
                                  //         textCapitalization:
                                  //             TextCapitalization.words,
                                  //         obsecureText: false,
                                  //         filledColor: WidgetColors.whiteColor,
                                  //         fill: true,
                                  //         enabledborderColor: Colors.black12,
                                  //         input_text_color:
                                  //             WidgetColors.blackColor,
                                  //         titleColor: WidgetColors.blackColor,
                                  //         hint_text_color: Colors.black45,
                                  //         error_text_color: Colors.black54,
                                  //         content_padding: 15,
                                  //         borderColor: Colors.black),
                                  //   ),
                                  // )
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * .01,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              children: [
                                Expanded(
                                  child:
                                      //     InkWell(
                                      //   onTap: () {
                                      //     _onLoading();
                                      //     // getAddress();
                                      //   },
                                      //   child: AbsorbPointer(
                                      //     absorbing: true,
                                      //     child: CustomTextInputData(
                                      //         onChanged: () {},
                                      //         dy: 0,
                                      //         dx: 0,
                                      //         right: 5,
                                      //         left: 0,
                                      //         blurRadius: 0,
                                      //         spreadRadius: 0,
                                      //         title: country,
                                      //         hintText: "",
                                      //         textEditingController:
                                      //             AllControllers.countryController,
                                      //         formFieldValidator:
                                      //             ValidationData.countryValidator,
                                      //         textInputType: TextInputType.text,
                                      //         textCapitalization:
                                      //             TextCapitalization.words,
                                      //         obsecureText: false,
                                      //         filledColor: WidgetColors.whiteColor,
                                      //         fill: true,
                                      //         enabledborderColor: Colors.black12,
                                      //         input_text_color:
                                      //             WidgetColors.blackColor,
                                      //         titleColor: WidgetColors.blackColor,
                                      //         hint_text_color: Colors.black45,
                                      //         error_text_color: Colors.black54,
                                      //         content_padding: 15,
                                      //         borderColor: Colors.black),
                                      //   ),
                                      // )
                                      CustomTextInputData(
                                          onChanged: () {},
                                          dy: 0,
                                          dx: 0,
                                          right: 5,
                                          left: 0,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          title: country,
                                          hintText: "",
                                          textEditingController:
                                              AllControllers.countryController,
                                          formFieldValidator:
                                              ValidationData.countryValidator,
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.words,
                                          obsecureText: false,
                                          filledColor: WidgetColors.whiteColor,
                                          fill: true,
                                          enabledborderColor: Colors.black12,
                                          input_text_color:
                                              WidgetColors.blackColor,
                                          titleColor: WidgetColors.blackColor,
                                          hint_text_color: Colors.black45,
                                          error_text_color: Colors.black54,
                                          content_padding: 15,
                                          borderColor: Colors.black),
                                ),
                                Expanded(
                                  child:
                                      //     InkWell(
                                      //   onTap: () {
                                      //     _onLoading();
                                      //   },
                                      //   child: AbsorbPointer(
                                      //     absorbing: true,
                                      //     child: CustomTextInputData(
                                      //         onChanged: () {},
                                      //         dy: 0,
                                      //         dx: 0,
                                      //         right: 0,
                                      //         left: 5,
                                      //         blurRadius: 0,
                                      //         spreadRadius: 0,
                                      //         title: zip,
                                      //         hintText: "",
                                      //         textEditingController:
                                      //             AllControllers.zipController,
                                      //         formFieldValidator:
                                      //             ValidationData.zipValidator,
                                      //         textInputType: TextInputType.text,
                                      //         textCapitalization:
                                      //             TextCapitalization.none,
                                      //         obsecureText: false,
                                      //         filledColor: WidgetColors.whiteColor,
                                      //         fill: true,
                                      //         enabledborderColor: Colors.black12,
                                      //         input_text_color:
                                      //             WidgetColors.blackColor,
                                      //         titleColor: WidgetColors.blackColor,
                                      //         hint_text_color: Colors.black45,
                                      //         error_text_color: Colors.black54,
                                      //         content_padding: 15,
                                      //         borderColor: Colors.black),
                                      //   ),
                                      // )
                                      CustomTextInputData(
                                          onChanged: () {},
                                          dy: 0,
                                          dx: 0,
                                          right: 0,
                                          left: 5,
                                          blurRadius: 0,
                                          spreadRadius: 0,
                                          title: zip,
                                          hintText: "",
                                          textEditingController:
                                              AllControllers.zipController,
                                          formFieldValidator:
                                              ValidationData.zipValidator,
                                          textInputType: TextInputType.text,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          obsecureText: false,
                                          filledColor: WidgetColors.whiteColor,
                                          fill: true,
                                          enabledborderColor: Colors.black12,
                                          input_text_color:
                                              WidgetColors.blackColor,
                                          titleColor: WidgetColors.blackColor,
                                          hint_text_color: Colors.black45,
                                          error_text_color: Colors.black54,
                                          content_padding: 15,
                                          borderColor: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * .01,
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              child: Text(
                                img_v,
                                style: GoogleFonts.poppins(
                                    color: WidgetColors.blackColor,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                ),
                                child: buildGridView(context)
//                                buildImage(height, width)
                                ),
                          ),
                          Container(
                            height: height * .03,
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 25,
                                right: 25,
                              ),
                              child: button_tap_event
                                  ? MaterialButtonClassPage(
                                      height: height * .06,
                                      radius: BorderRadius.circular(05),
                                      buttonName: submit,
                                      onPress: () {
                                        if (imageFileData.length == 0 ||
                                            imageFileData == "") {
                                          Fluttertoast.showToast(
                                              msg: "Please add Image",
                                              gravity: ToastGravity.CENTER,
                                              backgroundColor:
                                                  WidgetColors.buttonColor);
                                        } else {
                                          showSnacBar();
                                          validateInputs();
                                          // setState(() {
                                          //   button_tap_event = false;
                                          // });
                                        }

                                        // print("================Button 1");
                                      },
                                      color: WidgetColors.buttonColor,
                                      minwidth: width,
                                      fontSize: 14,
                                    )
                                  : AbsorbPointer(
                                      absorbing: true,
                                      child: MaterialButtonClassPage(
                                        height: height * .06,
                                        radius: BorderRadius.circular(05),
                                        buttonName: submit,
                                        onPress: () {},
                                        color: WidgetColors.bgColor,
                                        minwidth: width,
                                        fontSize: 14,
                                      ),
                                    )),
                        ],
                      ),
                    )),
              ),
              left: false,
              bottom: false,
              right: false,
            )),
        onWillPop: () {
          return onWillPop(context);
        });
  }

  bool button_tap_event;

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                height: 100,
                child: Center(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlatformLoader(
                          radius: 15, color: WidgetColors.buttonColor),
                      Container(
                        width: 10,
                      ),
                      new Text("Converting your location.."),
                    ],
                  ),
                )));
      },
    );
    // new Future.delayed(new Duration(seconds: 2), () {
    //   Navigator.pop(context); //pop dialog
    //   // getAddress();
    // });
  }

  Widget buildGridView(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(3, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                        _imageFile.then((value) => imageFileData.remove(value));
                        // imageFileData.remove(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                getCurrentLocation(
                    AllControllers.addressController.text
                        .toLowerCase()
                        .toString(),
                    AllControllers.cityController.text.toLowerCase().toString(),
                    AllControllers.stateController.text
                        .toLowerCase()
                        .toString(),
                    AllControllers.countryController.text
                        .toLowerCase()
                        .toString(),
                    AllControllers.zipController.text.toLowerCase().toString());
                _onAddImageClick(index, context);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index, BuildContext context) async {
    setState(() {
      modalBottomSheetMenu(context, index);
    });
  }

  List<Object> images = List<Object>();
  Future<File> _imageFile;
  var imageData = [];
  var imageFileData = [];

  void getFileImage(int index) async {
    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
        var fileName = file.path.split('/').last;
        imageData.add(fileName);
        imageFileData.add(file);
      });
    });
  }

  DateTime selectedDate = DateTime.now();
  var myFormat = DateFormat('yyyy-MM-dd');
  var myFormat2 = DateFormat('yyyy-MM-dd hh:mm');

  Future selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: WidgetColors.themeColor,
            accentColor: WidgetColors.themeColor,
            colorScheme: ColorScheme.light(primary: WidgetColors.themeColor),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        AllControllers.serviceDateController =
            TextEditingController(text: myFormat.format(picked));
      });
    } else {}
  }

  Widget buildImage(double height, double width) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        img != null
            ? Container(
                height: height / 7,
                width: width,
                child: Image.file(
                  img,
                  fit: BoxFit.fitWidth,
                ))
            : Center(
                child: Container(),
              ),
        InkWell(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  img_v,
                  style: GoogleFonts.poppins(
                      color: WidgetColors.blackColor, fontSize: 14),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: height / 7,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black12,
                  )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: Colors.black38,
                      ),
                      Text(
                        img_v,
                        style: GoogleFonts.poppins(
                            color: WidgetColors.blackColor, fontSize: 14),
                      ),
                      MaterialButtonClassPage(
                        height: 20,
                        radius: BorderRadius.circular(00),
                        buttonName: upload_file,
                        onPress: () {
                          modalBottomSheetMenu(this.context, 0);
                        },
                        color: WidgetColors.buttonColor,
                        minwidth: width / 8,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            modalBottomSheetMenu(this.context, 0);
          },
        )
      ],
    );
  }

  void modalBottomSheetMenu(BuildContext context, int index) {
    final action = CupertinoActionSheet(
        title: Padding(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Text(
            'Select Avatar',
            style: TextStyle(fontSize: 18),
          ),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(take_photo),
            onPressed: () async {
              Navigator.pop(context);
              _imageFile = ImagePicker.pickImage(
                  source: ImageSource.camera, maxWidth: 1920, maxHeight: 1350);
              _imageFile.then((file) {
                // print("error exception:$file");
                if (file == null || file == "") {
                  // print("error exception");
                } else {
                  getFileImage(index);
                }
              });
              // if (_imageFile == null || _imageFile == "") {
              // } else {
              //   if (this.mounted) {
              //     setState(() {
              //       getFileImage(index);
              //     });
              //   }
              // }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(gallery_photo),
            onPressed: () async {
              Navigator.pop(context);
              _imageFile = ImagePicker.pickImage(
                  source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1350);

              _imageFile.then((file) {
                // print("error exception:$file");
                if (file == null || file == "") {
                  // print("error exception");
                } else {
                  getFileImage(index);
                }
              });

//               if (_imageFile == null || _imageFile == "") {
//               } else {
//                 if (this.mounted) {
//                   setState(() {
// //                    img = _imageFile;
// //                    imageName = basename(img.path);
// //                    base64Image = base64Encode(img.readAsBytesSync());
//                     getFileImage(index);
//                   });
//                 }
//               }
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    AlertDialog alert = AlertDialog(
      title: Center(
        child: Text("Create a Post"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            child: Text(take_photo),
            onPressed: () async {
              Navigator.pop(context);
              _imageFile = ImagePicker.pickImage(
                  source: ImageSource.camera, maxWidth: 1920, maxHeight: 1350);
              _imageFile.then((file) {
                // print("error exception:$file");
                if (file == null || file == "") {
                  // print("error exception");
                } else {
                  getFileImage(index);
                }
              });

//               if (_imageFile == null || _imageFile == "") {
//               } else {
//                 if (this.mounted) {
//                   setState(() {
// //                    img = _imageFile;
// //                    imageName = basename(img.path);
// //                    base64Image = base64Encode(img.readAsBytesSync());
//                     getFileImage(index);
//                   });
//                 }
//               }
            },
          ),
          FlatButton(
            child: Text(gallery_photo),
            onPressed: () async {
              Navigator.pop(context);
              _imageFile = ImagePicker.pickImage(
                  source: ImageSource.gallery, maxWidth: 1920, maxHeight: 1350);

              _imageFile.then((file) {
                // print("error exception:$file");
                if (file == null || file == "") {
                  // print("error exception");
                } else {
                  getFileImage(index);
                }
              });

//               if (_imageFile == null || _imageFile == "") {
//               } else {
//                 if (this.mounted) {
//                   setState(() {
// //                    img = _imageFile;
// //                    imageName = basename(img.path);
// //                    base64Image = base64Encode(img.readAsBytesSync());
//                     getFileImage(index);
//                   });
//                 }
//               }
            },
          ),
          FlatButton(
            child: Text(cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );

    if (Platform.isAndroid) {
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context, builder: (BuildContext context) => action);
    }
  }

  showSnacBar() {
    profilescaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.black26,
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.black87,
            ),
            SizedBox(
              height: 0,
              width: 20,
            ),
            Text(
              "Processing Data",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        )));
  }

  void closePopup() {
    Navigator.of(this.context).push(HomeScreenPopup(
        from_page: "service_form",
        text_line_second: thanks_second,
        text_line: thanks));
    new Future.delayed(new Duration(seconds: 2), () {
      profilescaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  getCurrentLocation(
      var address, var city, var state, var country, var zip) async {
    List<Location> addresses =
        await locationFromAddress(address + city + state + country + zip)
            .then((value) {
      var first = value.first;
      if (this.mounted) {
        setState(() {
          latitude = first.latitude;
          longitude = first.longitude;
          print("GetAddressLocation latitude : ${latitude}");
          print("GetAddressLocation longitude : ${longitude}");
          // Navigator.pop(context);
        });
      }
      return value;
    }).catchError((onError) {
      profilescaffoldKey.currentState.hideCurrentSnackBar();
      ValidationData.customToast("Please Add Correct Address!", Colors.black,
          Colors.white, ToastGravity.BOTTOM);
      // print("====================>>${onError}");
    });
  }

  void validateInputs() {
    if (profileformKeyValidate.currentState.validate()) {
      setState(() {
        profileformKeyValidate.currentState.save();
        // upload(imageFileData);
        setState(() {
          button_tap_event = false;
        });
        upload(imageFileData);
        // _onLoading();
        // getCurrentLocation(
        //     AllControllers.addressController.text.toLowerCase().toString(),
        //     AllControllers.cityController.text.toLowerCase().toString(),
        //     AllControllers.stateController.text.toLowerCase().toString(),
        //     AllControllers.countryController.text.toLowerCase().toString(),
        //     AllControllers.zipController.text.toLowerCase().toString());
      });
    } else {
      setState(() {
        profileautoValidate = true;
        Fluttertoast.showToast(msg: "Please fill all fields!");
        profilescaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
  }

  void upload(var imageData) async {
    var imgData = [];

    for (var i = 0; i < imageFileData.length; i++) {
      File mydata = imageFileData[i];
      String fileName = mydata.path.split('/').last;
      imgData.add(MultipartFile.fromFileSync(mydata.path, filename: fileName));
    }

    FormData data = FormData.fromMap({
      "documents": imgData,
      "service_id": widget.service_id.toString(),
      "job_title": widget.service_name.toString(),
      "mobile_token": deviceToken.toString(),
      "job_description":
          AllControllers.serviceDescriptionController.text.toString(),
      "consumer_id": user_id.toString(),
      "job_status": "0",
      "job_city": AllControllers.cityController.text.toString(),
      "job_address": AllControllers.addressController.text.toString(),
      "job_zipcode": AllControllers.zipController.text.toString(),
      "job_state": AllControllers.stateController.text.toString(),
      "job_country": AllControllers.countryController.text.toString(),
      "job_location_latitude":
          latitude.toString() != null || latitude.toString() != ""
              ? latitude.toString()
              : "a",
      "job_location_longitude":
          longitude.toString() != null || longitude.toString() != ""
              ? longitude.toString()
              : "a",
      "job_done_by_date": AllControllers.serviceDateController.text.toString(),
      "job_address_details": ".",
      "technician_id": "0",
      "technician_status": "0",
      "payment_type": ".",
      "payment_percentage_details": ".",
      "overall_payment_status": ".",
      "job_cost_currency": ".",
      "job_cost": ".",
      "total_amount_paid": ".",
    });

    Dio dio = new Dio();

    dio.post(customer_service, data: data).then((response) async {
      // print("customer_service: ${response.data}");
      // print("getCurrentLocation customer_service : ${response.data}");
      var jsonData;
      if (this.mounted) {
        setState(() {
          jsonData = response.data;
        });
      }
      if (jsonData['status'] == "200" || jsonData['status'] == 200) {
        var data = jsonData['data'];

        AllControllers.serviceDateController.clear();
        AllControllers.serviceDescriptionController.clear();
        AllControllers.serviceNameController.clear();
        AllControllers.phoneController.clear();
        AllControllers.cityController.clear();
        AllControllers.addressController.clear();
        AllControllers.zipController.clear();
        AllControllers.stateController.clear();
        AllControllers.countryController.clear();
        if (this.mounted) {
          setState(() {
            closePopup();
          });
        }
      } else {
        profilescaffoldKey.currentState.hideCurrentSnackBar();
        ValidationData.customToast(
            jsonData["message"], Colors.red, Colors.white, ToastGravity.BOTTOM);
        setState(() {
          button_tap_event = true;
        });
      }
    }).catchError((error) {
      profilescaffoldKey.currentState.hideCurrentSnackBar();
      ValidationData.customToast(
          "$error", Colors.red, Colors.white, ToastGravity.BOTTOM);
      setState(() {
        button_tap_event = true;
      });
    });
  }
}

class ImageUploadModel {
  bool isUploaded;
  bool uploading;
  File imageFile;
  String imageUrl;

  ImageUploadModel({
    this.isUploaded,
    this.uploading,
    this.imageFile,
    this.imageUrl,
  });
}
