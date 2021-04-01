// import 'dart:io';
//
// import 'package:adam_company_consumer_app/common/import_clases.dart';
// import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class ContactUs extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
//
// class _selectionScreen extends State<ContactUs> {
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
//   onWillPop() {
//     return BackFunction.slideLeftNavigator(
//         context,
//         BottomNavBarPage(
//           initialIndex: 4,
//           initialIndexJob: 0,
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return WillPopScope(
//       onWillPop: () {
//         return onWillPop();
//       },
//       child: Scaffold(
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
//             title: customText(cnt_us, 18, Colors.white, FontWeight.w400),
//           ),
//           body: Container(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     height: height * 0.02,
//                   ),
//                   CustomTextInputData(
//                       onChanged: () {},
//                       maxline: 1,
//                       dy: 0,
//                       dx: 0,
//                       right: 25,
//                       left: 25,
//                       blurRadius: 0,
//                       spreadRadius: 0,
//                       title: full_name,
//                       hintText: "",
//                       textEditingController: AllControllers.cntNameController,
//                       formFieldValidator: null,
//                       textInputType: TextInputType.text,
//                       textCapitalization: TextCapitalization.words,
//                       obsecureText: false,
//                       filledColor: WidgetColors.whiteColor,
//                       fill: true,
//                       enabledborderColor: Colors.black12,
//                       input_text_color: Colors.black,
//                       titleColor: Colors.black,
//                       hint_text_color: Colors.black45,
//                       error_text_color: Colors.black54,
//                       content_padding: 15,
//                       borderColor: Colors.black),
//                   Container(
//                     height: height * 0.01,
//                   ),
//                   CustomTextInputData(
//                       onChanged: () {},
//                       maxline: 1,
//                       dy: 0,
//                       dx: 0,
//                       right: 25,
//                       left: 25,
//                       blurRadius: 0,
//                       spreadRadius: 0,
//                       title: email,
//                       hintText: "",
//                       textEditingController: AllControllers.cntEmailController,
//                       formFieldValidator: null,
//                       textInputType: TextInputType.emailAddress,
//                       textCapitalization: TextCapitalization.words,
//                       obsecureText: false,
//                       filledColor: WidgetColors.whiteColor,
//                       fill: true,
//                       enabledborderColor: Colors.black12,
//                       input_text_color: Colors.black,
//                       titleColor: Colors.black,
//                       hint_text_color: Colors.black45,
//                       error_text_color: Colors.black54,
//                       content_padding: 15,
//                       borderColor: Colors.black),
//                   Container(
//                     height: height * 0.01,
//                   ),
//                   CustomTextInputData(
//                       onChanged: () {},
//                       maxline: 1,
//                       dy: 0,
//                       dx: 0,
//                       right: 25,
//                       left: 25,
//                       blurRadius: 0,
//                       spreadRadius: 0,
//                       title: mobile_number,
//                       hintText: "",
//                       textEditingController: AllControllers.cntPhoneController,
//                       formFieldValidator: null,
//                       textInputType: TextInputType.number,
//                       textCapitalization: TextCapitalization.words,
//                       obsecureText: false,
//                       filledColor: WidgetColors.whiteColor,
//                       fill: true,
//                       enabledborderColor: Colors.black12,
//                       input_text_color: Colors.black,
//                       titleColor: Colors.black,
//                       hint_text_color: Colors.black45,
//                       error_text_color: Colors.black54,
//                       content_padding: 15,
//                       borderColor: Colors.black),
//                   Container(
//                     height: height * 0.01,
//                   ),
//                   CustomTextInputData(
//                       onChanged: () {},
//                       maxline: 1,
//                       dy: 0,
//                       dx: 0,
//                       right: 25,
//                       left: 25,
//                       blurRadius: 0,
//                       spreadRadius: 0,
//                       title: country,
//                       hintText: "",
//                       textEditingController:
//                           AllControllers.cntCountryController,
//                       formFieldValidator: null,
//                       textInputType: TextInputType.text,
//                       textCapitalization: TextCapitalization.words,
//                       obsecureText: false,
//                       filledColor: WidgetColors.whiteColor,
//                       fill: true,
//                       enabledborderColor: Colors.black12,
//                       input_text_color: Colors.black,
//                       titleColor: Colors.black,
//                       hint_text_color: Colors.black45,
//                       error_text_color: Colors.black54,
//                       content_padding: 15,
//                       borderColor: Colors.black),
//                   Container(
//                     height: height * 0.01,
//                   ),
//                   CustomTextInputData(
//                       onChanged: () {},
//                       maxline: 3,
//                       dy: 0,
//                       dx: 0,
//                       right: 25,
//                       left: 25,
//                       blurRadius: 0,
//                       spreadRadius: 0,
//                       title: message,
//                       hintText: "",
//                       textEditingController:
//                           AllControllers.cntMessageController,
//                       formFieldValidator: null,
//                       textInputType: TextInputType.text,
//                       textCapitalization: TextCapitalization.words,
//                       obsecureText: false,
//                       filledColor: WidgetColors.whiteColor,
//                       fill: true,
//                       enabledborderColor: Colors.black12,
//                       input_text_color: Colors.black,
//                       titleColor: Colors.black,
//                       hint_text_color: Colors.black45,
//                       error_text_color: Colors.black54,
//                       content_padding: 15,
//                       borderColor: Colors.black),
//                   Container(
//                     height: height * 0.04,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 32,
//                       right: 32,
//                     ),
//                     child: MaterialButtonClassPage(
//                       height: height * .06,
//                       radius: BorderRadius.circular(05),
//                       buttonName: send_data,
//                       onPress: () {},
//                       color: WidgetColors.buttonColor,
//                       minwidth: width,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
