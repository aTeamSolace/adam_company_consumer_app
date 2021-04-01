import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/widget/full_screen_popup.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:location/location.dart';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  var loginMethod;
  var mobile_number;
  var user_id;

  var user_email;
  var user_name;
  var user_photo_url;

  ProfilePage(
      {@required this.loginMethod,
      this.mobile_number,
      @required this.user_id,
      this.user_email,
      this.user_name,
      this.user_photo_url});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<ProfilePage> {
  File img;
  var base64Image;
  var imageName;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;
  var latitude;
  var longitude;

  @override
  initState() {
    getDeviceToken();
    getCurrentLocation();
    super.initState();
  }

//  Location location = new Location();

  bool profileautoValidate = false;
  final GlobalKey<FormState> profileformKeyValidate = GlobalKey<FormState>();
  final profilescaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: profilescaffoldKey,
        appBar: AppBar(
          backgroundColor: WidgetColors.themeColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            profile,
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
                    children: [
                      Container(
                        height: height * .02,
                      ),
                      Container(
                          child: widget.loginMethod == "mobile"
                              ? CustomTextInputData(
                                  onChanged: () {},
                                  dy: 0,
                                  dx: 0,
                                  right: 25,
                                  left: 25,
                                  blurRadius: 0,
                                  spreadRadius: 0,
                                  title: full_name,
                                  hintText: "",
                                  textEditingController:
                                      AllControllers.nameController,
                                  formFieldValidator:
                                      ValidationData.nameValidator,
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
                                  borderColor: Colors.black)
                              : Container()),
                      Container(
                        height: height * .01,
                      ),
                      // Container(
                      //   child: widget.loginMethod == "mobile"
                      //       ? CustomTextInputData(
                      //           onChanged: () {},
                      //           dy: 0,
                      //           dx: 0,
                      //           right: 25,
                      //           left: 25,
                      //           blurRadius: 0,
                      //           spreadRadius: 0,
                      //           title: email,
                      //           hintText: "",
                      //           textEditingController:
                      //               AllControllers.emailController,
                      //           formFieldValidator:
                      //               ValidationData.emailValidator,
                      //           textInputType: TextInputType.emailAddress,
                      //           textCapitalization: TextCapitalization.none,
                      //           obsecureText: false,
                      //           filledColor: WidgetColors.whiteColor,
                      //           fill: true,
                      //           enabledborderColor: Colors.black12,
                      //           input_text_color: Colors.black,
                      //           titleColor: Colors.black,
                      //           hint_text_color: Colors.black45,
                      //           error_text_color: Colors.black54,
                      //           content_padding: 15,
                      //           borderColor: Colors.black)
                      //       : Container(),
                      // ),
                      CustomTextInputData(
                          onChanged: () {},
                          dy: 0,
                          dx: 0,
                          right: 25,
                          left: 25,
                          blurRadius: 0,
                          spreadRadius: 0,
                          title: mobile_number,
                          hintText: "",
                          textEditingController: AllControllers.phoneController,
                          formFieldValidator: ValidationData.mobileValidator,
                          textInputType: TextInputType.number,
                          textCapitalization: TextCapitalization.none,
                          obsecureText: false,
                          filledColor: WidgetColors.whiteColor,
                          fill: true,
                          enabledborderColor: Colors.black12,
                          input_text_color: Colors.black,
                          titleColor: Colors.black,
                          hint_text_color: Colors.black45,
                          error_text_color: Colors.black54,
                          content_padding: 15,
                          maxlength: 15,
                          borderColor: Colors.black),
                      Container(
                        height: height * .01,
                      ),
                      Container(
                        child: Padding(
                            padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: buildImage(height, width)),
                      ),
                      Container(
                        height: height * .01,
                      ),
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
                          formFieldValidator: ValidationData.addressValidator,
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
                              child: CustomTextInputData(
                                  maxline: 1,
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
                                  title: zip,
                                  hintText: "",
                                  textEditingController:
                                      AllControllers.zipController,
                                  formFieldValidator:
                                      ValidationData.zipValidator,
                                  textInputType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
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
                            )
                          ],
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
                        child: MaterialButtonClassPage(
                          height: height * .06,
                          radius: BorderRadius.circular(05),
                          buttonName: submit,
                          onPress: () {
                            if (img == null || img == "") {
                              Fluttertoast.showToast(
                                  msg: "Please add Image",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: WidgetColors.buttonColor);
                            } else {
                              validateInputs();
                            }
                          },
                          color: WidgetColors.buttonColor,
                          minwidth: width,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          left: false,
          bottom: false,
          right: false,
        ));
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

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
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
                  profile_photo,
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
                        upload_photo,
                        style: GoogleFonts.poppins(
                            color: WidgetColors.blackColor, fontSize: 14),
                      ),
                      MaterialButtonClassPage(
                        height: 20,
                        radius: BorderRadius.circular(00),
                        buttonName: upload_file,
                        onPress: () {
                          modalBottomSheetMenu(this.context);
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
            modalBottomSheetMenu(this.context);
          },
        )
      ],
    );
  }

  // Image Get from Gallery And Camera
  void modalBottomSheetMenu(BuildContext context) {
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
              File imageFile = await ImagePicker.pickImage(
                  source: ImageSource.camera, maxWidth: 1920, maxHeight: 1350);
              if (imageFile == null || imageFile == "") {
              } else {
                if (this.mounted) {
                  setState(() {
                    img = imageFile;
                    imageName = basename(img.path);
                    base64Image = base64Encode(img.readAsBytesSync());
                  });
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(gallery_photo),
            onPressed: () async {
              Navigator.of(context).pop();
              File imageFile =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (imageFile == null || imageFile == "") {
              } else {
                if (this.mounted) {
                  setState(() {
                    img = imageFile;
                    imageName = basename(img.path);
                    base64Image = base64Encode(img.readAsBytesSync());
                  });
                }
              }
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
                File imageFile = await ImagePicker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1920,
                    maxHeight: 1350);
                if (imageFile == null || imageFile == "") {
                } else {
                  if (this.mounted) {
                    setState(() {
                      img = imageFile;
                      imageName = basename(img.path);
                      base64Image = base64Encode(img.readAsBytesSync());
                    });
                  }
                }
              }),
          FlatButton(
              child: Text(gallery_photo),
              onPressed: () async {
                Navigator.of(context).pop();
                File imageFile =
                    await ImagePicker.pickImage(source: ImageSource.gallery);

                if (imageFile == null || imageFile == "") {
                } else {
                  if (this.mounted) {
                    setState(() {
                      img = imageFile;
                      imageName = basename(img.path);
                      base64Image = base64Encode(img.readAsBytesSync());
                    });
                  }
                }
              }),
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

  void validateInputs() {
    if (profileformKeyValidate.currentState.validate()) {
      setState(() {
        profileformKeyValidate.currentState.save();
        upload(img);
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
                  processing_data,
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            )));
      });
    } else {
      setState(() {
        profileautoValidate = true;
        Fluttertoast.showToast(msg: "Error");
        profilescaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
  }

  void closePopup() {
    Navigator.of(this.context).push(HomeScreenPopup(
        from_page: "profile_page",
        text_line_second: profile_popup_2,
        text_line: profile_popup));
    new Future.delayed(new Duration(milliseconds: 500), () {
      profilescaffoldKey.currentState.hideCurrentSnackBar();
    });
  }

  void upload(File file) async {
    // print("=========>> Phone :${AllControllers.phoneController.text}");
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "customer_profile_pic": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
      "user_id": widget.user_id.toString(),
      "name": widget.loginMethod == "mobile"
          ? AllControllers.nameController.text.toString()
          : widget.user_name.toString(),
      "email": widget.loginMethod == "mobile"
          ? widget.mobile_number.toString()
          : widget.user_email.toString(),
      "mobile": AllControllers.phoneController.text.toString(),
      "mobile_token": deviceToken.toString(),
      "status": "1",
      "city": AllControllers.cityController.text.toString(),
      "address": AllControllers.addressController.text.toString(),
      "zipcode": AllControllers.zipController.text.toString(),
      "state": AllControllers.stateController.text.toString(),
      "country": AllControllers.countryController.text.toString(),
      "address_latitude":
          latitude.toString() != null || latitude.toString() != ""
              ? latitude.toString()
              : ".",
      "address_longitude":
          longitude.toString() != null || longitude.toString() != ""
              ? longitude.toString()
              : ".",
      "role": "customer"
    });

    Dio dio = new Dio();

    dio.post(add_profile, data: data).then((response) async {
      // print("Profile set consumer : ${response.data}");
      var jsonData;
      if (this.mounted) {
        setState(() {
          jsonData = response.data;
        });
      }

      if (jsonData['status'] == "200" || jsonData['status'] == 200) {
        var data = jsonData['data'];
        // print("Profile set consumer : ${data['id']}");
        closePopup();
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("user_id", data['id'].toString());
        AllControllers.nameController.clear();
        AllControllers.emailController.clear();
        AllControllers.phoneController.clear();
        AllControllers.cityController.clear();
        AllControllers.addressController.clear();
        AllControllers.zipController.clear();
        AllControllers.stateController.clear();
        AllControllers.countryController.clear();
      } else if (jsonData['status'] == "400" || jsonData['status'] == 400) {
        profilescaffoldKey.currentState.hideCurrentSnackBar();
        ValidationData.customToast("Email Already Exist", Colors.red,
            Colors.white, ToastGravity.BOTTOM);
      } else {
        profilescaffoldKey.currentState.hideCurrentSnackBar();
        ValidationData.customToast(jsonData['message'].toString(), Colors.red,
            Colors.white, ToastGravity.BOTTOM);
      }
    }).catchError((error) {
      ValidationData.customToast(
          "$error", Colors.red, Colors.white, ToastGravity.BOTTOM);
    });
  }
}
