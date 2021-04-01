// import 'dart:io';
//
// import 'package:adam_company_consumer_app/common/back_function.dart';
// import 'package:adam_company_consumer_app/common/import_clases.dart';
// import 'package:adam_company_consumer_app/network/api_provider/insert_data_api_provider.dart';
// import 'package:adam_company_consumer_app/network/model/user_insert_model.dart';
// import 'package:adam_company_consumer_app/widget/full_screen_contact_popup.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ContactTechnician extends StatefulWidget {
//   var service_id;
//   var technician_id;
//
//   ContactTechnician({this.service_id, this.technician_id});
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
//
// class _selectionScreen extends State<ContactTechnician> {
//   @override
//   initState() {
//     super.initState();
//
//     checkSessionValue();
//   }
//
//   onWillPop() {
//     return BackFunction.slideLeftNavigator(
//         context,
//         BottomNavBarPage(
//           initialIndex: 1,
//           initialIndexJob: 1,
//         ));
//   }
//
//   // Widget customText(
//   //     var title, double height, Color color, FontWeight fontWeight) {
//   //   return Text(
//   //     title.toString(),
//   //     style: GoogleFonts.montserrat(
//   //       fontSize: height,
//   //       color: color,
//   //       fontWeight: fontWeight,
//   //     ),
//   //   );
//   // }
//
//   var user_id;
//
//   checkSessionValue() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     user_id = preferences.getString("user_id");
//
//     // print("====>>${widget.service_id}");
//     // print("====>>${widget.technician_id}");
//   }
//
//   bool profileautoValidate = false;
//   final GlobalKey<FormState> profileformKeyValidate = GlobalKey<FormState>();
//   final profilescaffoldKey = GlobalKey<ScaffoldState>();
//
//   void validateInputs() {
//     if (profileformKeyValidate.currentState.validate()) {
//       setState(() {
//         profileformKeyValidate.currentState.save();
//         insertData();
//         profilescaffoldKey.currentState.showSnackBar(new SnackBar(
//             backgroundColor: Colors.black26,
//             content: Row(
//               children: [
//                 CircularProgressIndicator(
//                   valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
//                   backgroundColor: Colors.black87,
//                 ),
//                 SizedBox(
//                   height: 0,
//                   width: 20,
//                 ),
//                 Text(
//                   processing_data,
//                   style: GoogleFonts.poppins(
//                       color: Colors.white, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             )));
//       });
//     } else {
//       setState(() {
//         profileautoValidate = true;
//         Fluttertoast.showToast(msg: "Error");
//         profilescaffoldKey.currentState.hideCurrentSnackBar();
//       });
//     }
//   }
//
//   insertData() {
//     // print("=============>>${AllControllers.messageController.text.toString()}");
//     // print("=============>>${img}");
//     Provider.of<AddDataApiProvider>(context, listen: false)
//         .sendMessage(UserInsert(
//             consumer_id: user_id.toString(),
//             service_id: widget.service_id.toString(),
//             message: AllControllers.messageController.text.toString(),
//             technician_id: widget.technician_id.toString(),
//             image: img))
//         .then((value) {
//       if (value.status == 200) {
//         BackFunction.scaleNavigator(
//             context,
//             BottomNavBarPage(
//               initialIndex: 0,
//               initialIndexJob: 0,
//             ));
//
//         ValidationData.customToast(thnk_for_cnt, Colors.black,
//             Colors.white, ToastGravity.BOTTOM);
//       } else {
//         ValidationData.customToast(smth_wrng, Colors.red,
//             Colors.white, ToastGravity.BOTTOM);
//         profilescaffoldKey.currentState.hideCurrentSnackBar();
//       }
//     }).catchError((e) {
//       profilescaffoldKey.currentState.hideCurrentSnackBar();
//       ValidationData.customToast(
//           e.toString(), Colors.red, Colors.white, ToastGravity.BOTTOM);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//         child: Scaffold(
//           key: profilescaffoldKey,
//           backgroundColor: Color(0xffE2E2E2),
//           appBar: AppBar(
//             leading: IconButton(
//                 icon: Platform.isIOS
//                     ? Icon(
//                         Icons.arrow_back_ios,
//                         color: Colors.white,
//                       )
//                     : Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                       ),
//                 onPressed: () {
//                   onWillPop();
//                 }),
//             iconTheme: IconThemeData(color: Colors.white),
//             backgroundColor: Colors.black,
//             centerTitle: true,
//             title: customText(
//                 cnt_tech, 18, Colors.white, FontWeight.w400),
//           ),
//           body: SafeArea(
//               child: Center(
//                   child: PlatformScrollbar(
//             child: Container(
//                 width: width,
//                 height: height,
//                 margin: EdgeInsets.only(top: 20, left: 20, right: 20),
//                 child: Form(
//                   key: profileformKeyValidate,
//                   autovalidate: profileautoValidate,
//                   child: SingleChildScrollView(
//                     physics: BouncingScrollPhysics(),
//                     child: Column(
//                       children: [
//                         CustomTextInputData(
//                             onChanged: () {},
//                             dy: 0,
//                             dx: 0,
//                             right: 0,
//                             left: 0,
//                             blurRadius: 0,
//                             spreadRadius: 0,
//                             title: message,
//                             hintText: "",
//                             textEditingController:
//                                 AllControllers.messageController,
//                             formFieldValidator: ValidationData.messageValidator,
//                             textInputType: TextInputType.text,
//                             textCapitalization: TextCapitalization.words,
//                             obsecureText: false,
//                             filledColor: WidgetColors.bgColor,
//                             fill: true,
//                             enabledborderColor: Colors.black,
//                             input_text_color: WidgetColors.blackColor,
//                             titleColor: WidgetColors.blackColor,
//                             hint_text_color: Colors.black45,
//                             error_text_color: Colors.black54,
//                             content_padding: 15,
//                             borderColor: Colors.black),
//                         Container(
//                           height: height * .03,
//                         ),
//                         buildImage(height, width),
//                         Container(
//                           height: height * .04,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                             left: 0,
//                             right: 0,
//                           ),
//                           child: MaterialButtonClassPage(
//                             height: height * .06,
//                             radius: BorderRadius.circular(05),
//                             buttonName: send_message,
//                             onPress: () {
//                               validateInputs();
//                             },
//                             color: WidgetColors.buttonColor,
//                             minwidth: width,
//                             fontSize: 14,
//                           ),
//                         ),
//                         Container(
//                           height: height * .02,
//                         ),
//                         InkWell(
//                           child: Container(
//                               height: height * .06,
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(05),
//                                   border: Border.all(
//                                       color: WidgetColors.buttonColor)),
//                               child: Center(
//                                 child: customText(
//                                     cancel,
//                                     14,
//                                     WidgetColors.buttonColor,
//                                     FontWeight.normal),
//                               )),
//                           onTap: () {
//                             BackFunction.scaleNavigator(
//                                 context,
//                                 BottomNavBarPage(
//                                   initialIndex: 0,
//                                   initialIndexJob: 0,
//                                 ));
//                             // Navigator.of(this.context)
//                             //     .push(ContactPopup());
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//           ))),
//         ),
//         onWillPop: () {
//           return onWillPop();
//         });
//   }
//
//   File img;
//   var fileName;
//
//   Widget buildImage(double height, double width) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: <Widget>[
//         img != null
//             ? Container(
//                 height: height / 7,
//                 width: width,
//                 child: Image.file(
//                   img,
//                   fit: BoxFit.fitWidth,
//                 ))
//             : Center(
//                 child: Container(
//                 height: height / 7,
//                 width: width,
//               )),
//         InkWell(
//           child: Container(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Container(
//                     height: height / 7,
//                     width: width,
//                     decoration: BoxDecoration(
//                         border: Border.all(
//                       color: Colors.black,
//                     )),
//                     child: Center(
//                       child: Text(
//                         add_photo,
//                         style: GoogleFonts.poppins(
//                             color: WidgetColors.blackColor, fontSize: 14),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//           onTap: () {
//             modalBottomSheetMenu(this.context);
//           },
//         )
//       ],
//     );
//   }
//
//   // Image Get from Gallery And Camera
//   void modalBottomSheetMenu(BuildContext context) {
//     final action = CupertinoActionSheet(
//         title: Padding(
//           padding: EdgeInsets.only(top: 5, bottom: 5),
//           child: Text(
//             select_photo,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             child: Text(take_photo),
//             onPressed: () async {
//               Navigator.pop(context);
//               File imageFile = await ImagePicker.pickImage(
//                   source: ImageSource.camera, maxWidth: 1920, maxHeight: 1350);
//               if (imageFile == null || imageFile == "") {
//               } else {
//                 if (this.mounted) {
//                   setState(() {
//                     img = imageFile;
//                     fileName = img.path.split('/').last;
//                   });
//                 }
//               }
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text(gallery_photo),
//             onPressed: () async {
//               Navigator.of(context).pop();
//               File imageFile =
//                   await ImagePicker.pickImage(source: ImageSource.gallery);
//               if (imageFile == null || imageFile == "") {
//               } else {
//                 if (this.mounted) {
//                   setState(() {
//                     img = imageFile;
//                     fileName = img.path.split('/').last;
//                   });
//                 }
//               }
//             },
//           )
//         ],
//         cancelButton: CupertinoActionSheetAction(
//           child: Text(cancel),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ));
//
//     AlertDialog alert = AlertDialog(
//       title: Center(
//         child: Text(select_photo),
//       ),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FlatButton(
//               child: Text(take_photo),
//               onPressed: () async {
//                 Navigator.pop(context);
//                 File imageFile = await ImagePicker.pickImage(
//                     source: ImageSource.camera,
//                     maxWidth: 1920,
//                     maxHeight: 1350);
//                 if (imageFile == null || imageFile == "") {
//                 } else {
//                   if (this.mounted) {
//                     setState(() {
//                       img = imageFile;
//                       fileName = img.path.split('/').last;
//                     });
//                   }
//                 }
//               }),
//           FlatButton(
//               child: Text(gallery_photo),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 File imageFile =
//                     await ImagePicker.pickImage(source: ImageSource.gallery);
//
//                 if (imageFile == null || imageFile == "") {
//                 } else {
//                   if (this.mounted) {
//                     setState(() {
//                       img = imageFile;
//                       fileName = img.path.split('/').last;
//                     });
//                   }
//                 }
//               }),
//           FlatButton(
//             child: Text(cancel),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           )
//         ],
//       ),
//     );
//
//     if (Platform.isAndroid) {
//       showDialog<Null>(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return alert;
//         },
//       );
//     } else if (Platform.isIOS) {
//       showCupertinoModalPopup(
//           context: context, builder: (BuildContext context) => action);
//     }
//   }
// }
