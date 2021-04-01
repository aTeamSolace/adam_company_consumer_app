import 'dart:convert';
import 'dart:io';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class UpdateProfile extends StatefulWidget {
  var name;
  var email;
  var mobile;
  var photoURL;
  var address;
  var city;
  var state;
  var country;
  var zip;
  var user_id;

  UpdateProfile(
      {@required this.name,
      @required this.country,
      @required this.state,
      @required this.city,
      @required this.email,
      @required this.zip,
      @required this.mobile,
      @required this.address,
      @required this.photoURL,
      @required this.user_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<UpdateProfile> {

  @override
  initState() {
    AllControllers.nameController = TextEditingController(text: widget.name);
    AllControllers.emailController = TextEditingController(text: widget.email);
    AllControllers.phoneController = TextEditingController(text: widget.mobile);
    AllControllers.addressController =
        TextEditingController(text: widget.address);
    AllControllers.cityController = TextEditingController(text: widget.city);
    AllControllers.stateController = TextEditingController(text: widget.state);
    AllControllers.countryController =
        TextEditingController(text: widget.country);
    AllControllers.zipController = TextEditingController(text: widget.zip);
    getCurrentLocation();
    super.initState();
  }

  bool profileautoValidate = false;
  final GlobalKey<FormState> profileformKeyValidate = GlobalKey<FormState>();
  final profilescaffoldKey = GlobalKey<ScaffoldState>();

  onWillPopMethod(BuildContext context) {
    return BackFunction.fadeNavigationWithPush(
        context,
        BottomNavBarPage(
          initialIndex: 3,
          initialIndexJob: 0,
        ));
  }

  void validateInputs(BuildContext context) {
    if (profileformKeyValidate.currentState.validate()) {
      setState(() {
        profileformKeyValidate.currentState.save();
        upload(context);

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
      });
    } else {
      setState(() {
        profileautoValidate = true;
        ValidationData.customToast("All Fields are mandetory",
            WidgetColors.buttonColor, Colors.white, ToastGravity.BOTTOM);
        profilescaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
  }

  var latitude;
  var longitude;
  var fileName;

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  void upload(BuildContext context) async {
//    print("update profile page image : ${img.path}");
//    String fileName = file.path.split('/').last;
    FormData data = FormData.fromMap({
      "customer_profile_pic": img == null || img == ""
          ? widget.photoURL.toString()
          : await MultipartFile.fromFile(
              img.path,
              filename: fileName,
            ),
      "consumer_id": widget.user_id,
      "name": AllControllers.nameController.text.toString(),
      "email": AllControllers.emailController.text.toString(),
      "mobile": AllControllers.phoneController.text.toString(),
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
    });

    Dio dio = new Dio();

    dio.post(update_consumer_profile, data: data).then((response) async {
//      print("update profile page responce : ${response.data}");
      var jsonData = response.data;
      if (jsonData['status'] == "200" || jsonData['status'] == 200) {
        ValidationData.customToast("${jsonData['message']}", Colors.white,
            Colors.red, ToastGravity.BOTTOM);
        onWillPopMethod(context);
        // profilescaffoldKey.currentState.hideCurrentSnackBar();
      } else {
        ValidationData.customToast(smth_wrng, Colors.red,
            Colors.white, ToastGravity.BOTTOM);
      }
    }).catchError((error) {
      ValidationData.customToast(
          "$error", Colors.red, Colors.white, ToastGravity.BOTTOM);
    });
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
                    onWillPopMethod(context);
                  }),
              backgroundColor: WidgetColors.themeColor,
              centerTitle: true,
              automaticallyImplyLeading: true,
              title: Text(
                edit_profile,
                style: TextStyle(fontSize: 18,color: WidgetColors.blackColor),
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
                          CustomTextInputData(onChanged: (){},
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
                              formFieldValidator: ValidationData.nameValidator,
                              textInputType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              obsecureText: false,
                              filledColor: WidgetColors.whiteColor,
                              fill: true,
                              enabledborderColor: Colors.black12,
                              input_text_color: Colors.black,
                              titleColor: Colors.black,
                              hint_text_color: Colors.black45,
                              error_text_color: WidgetColors.buttonColor,
                              content_padding: 15,
                              borderColor: Colors.black),
                          Container(
                            height: height * .01,
                          ),
                          CustomTextInputData(onChanged: (){},
                              dy: 0,
                              dx: 0,
                              right: 25,
                              left: 25,
                              blurRadius: 0,
                              spreadRadius: 0,
                              title: email,
                              hintText: "",
                              textEditingController:
                                  AllControllers.emailController,
                              formFieldValidator: ValidationData.emailValidator,
                              textInputType: TextInputType.emailAddress,
                              textCapitalization: TextCapitalization.none,
                              obsecureText: false,
                              filledColor: WidgetColors.whiteColor,
                              fill: true,
                              enabledborderColor: Colors.black12,
                              input_text_color: Colors.black,
                              titleColor: Colors.black,
                              hint_text_color: Colors.black45,
                              error_text_color: WidgetColors.buttonColor,
                              content_padding: 15,
                              borderColor: Colors.black),
                          Container(
                            height: height * .01,
                          ),
                          CustomTextInputData(onChanged: (){},
                              dy: 0,
                              dx: 0,
                              right: 25,
                              left: 25,
                              blurRadius: 0,
                              spreadRadius: 0,
                              title: mobile_number,
                              hintText: "",
                              textEditingController:
                                  AllControllers.phoneController,
                              formFieldValidator:
                                  ValidationData.mobileValidator,
                              textInputType: TextInputType.number,
                              textCapitalization: TextCapitalization.none,
                              obsecureText: false,
                              filledColor: WidgetColors.whiteColor,
                              fill: true,
                              enabledborderColor: Colors.black12,
                              input_text_color: Colors.black,
                              titleColor: Colors.black,
                              hint_text_color: Colors.black45,
                              error_text_color: WidgetColors.buttonColor,
                              content_padding: 15,
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
                          CustomTextInputData(onChanged: (){},
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
                              error_text_color: WidgetColors.buttonColor,
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
                                  child: CustomTextInputData(onChanged: (){},
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
                                      error_text_color:
                                          WidgetColors.buttonColor,
                                      content_padding: 15,
                                      borderColor: Colors.black),
                                ),
                                Expanded(
                                  child: CustomTextInputData(onChanged: (){},
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
                                      error_text_color:
                                          WidgetColors.buttonColor,
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
                                  child: CustomTextInputData(onChanged: (){},
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
                                      input_text_color: WidgetColors.blackColor,
                                      titleColor: WidgetColors.blackColor,
                                      hint_text_color: Colors.black45,
                                      error_text_color:
                                          WidgetColors.buttonColor,
                                      content_padding: 15,
                                      borderColor: Colors.black),
                                ),
                                Expanded(
                                  child: CustomTextInputData(onChanged: (){},
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
                                      input_text_color: WidgetColors.blackColor,
                                      titleColor: WidgetColors.blackColor,
                                      hint_text_color: Colors.black45,
                                      error_text_color:
                                          WidgetColors.buttonColor,
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
                                validateInputs(context);
//                            if (img == null || img == "") {
//                              Fluttertoast.showToast(
//                                  msg: "Please add Image",
//                                  gravity: ToastGravity.CENTER,
//                                  backgroundColor: WidgetColors.buttonColor);
//                            } else {
////                              validateInputs();
//                            }
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
            )),
        onWillPop: (){
          return onWillPopMethod(context);
        });
  }

  File img;
  var base64Image;
  var imageName;

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
                child: Container(
                    height: height / 7,
                    width: width,
                    child: Image.network(
                      "$technician_profile_img/${widget.photoURL}",
                      fit: BoxFit.fitWidth,
                    ))),
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



              File croppedFile = await ImageCropper.cropImage(
                sourcePath: imageFile.path,
                maxWidth: 520,
                maxHeight: 512,
              );

              var result = await FlutterImageCompress.compressAndGetFile(
                croppedFile.path,
                imageFile.path,
                quality: 50,
              );


              if (imageFile == null || imageFile == "" || result == null || result == "") {
              } else {
                if (this.mounted) {
                  setState(() {
                    img = result;
                    imageName = basename(img.path);
                    base64Image = base64Encode(img.readAsBytesSync());
                    fileName = img.path.split('/').last;
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

              File croppedFile = await ImageCropper.cropImage(
                sourcePath: imageFile.path,
                maxWidth: 520,
                maxHeight: 512,
              );

              var result = await FlutterImageCompress.compressAndGetFile(
                croppedFile.path,
                imageFile.path,
                quality: 50,
              );

              if (imageFile == null || imageFile == "" || result == null || result == "") {
              } else {
                if (this.mounted) {
                  setState(() {
                    img = result;
                    imageName = basename(img.path);
                    base64Image = base64Encode(img.readAsBytesSync());
                    fileName = img.path.split('/').last;
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
                File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  maxWidth: 520,
                  maxHeight: 512,
                );

                var result = await FlutterImageCompress.compressAndGetFile(
                  croppedFile.path,
                  imageFile.path,
                  quality: 50,
                );

                if (imageFile == null || imageFile == "" || result == null || result == "") {
                } else {
                  if (this.mounted) {
                    setState(() {
                      img = result;
                      imageName = basename(img.path);
                      base64Image = base64Encode(img.readAsBytesSync());
                      fileName = img.path.split('/').last;
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


                File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  maxWidth: 520,
                  maxHeight: 512,
                );

                var result = await FlutterImageCompress.compressAndGetFile(
                  croppedFile.path,
                  imageFile.path,
                  quality: 50,
                );


                if (imageFile == null || imageFile == "" || result == null || result == "") {
                } else {
                  if (this.mounted) {
                    setState(() {

                      // print("===============>>${result.path}");
                      img = result;
                      imageName = basename(img.path);
                      base64Image = base64Encode(img.readAsBytesSync());
                      fileName = img.path.split('/').last;
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
}
