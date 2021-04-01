// import 'package:adam_company_consumer_app/common/import_clases.dart';
// import 'package:adam_company_consumer_app/widget/custom_textinputdata.dart';
// import 'package:flutter/material.dart';
// import 'package:stripe_payment/stripe_payment.dart';
//
// class AddCreditCardDetails extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
//
// class _selectionScreen extends State<AddCreditCardDetails> {
//   void setError(dynamic error) {
//     // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error.toString())));
//     setState(() {
//       var _error = error.toString();
//     });
//   }
//
//   showAlertDialog(BuildContext context) {
//     Widget cancelButton = FlatButton(
//       child:
//           customText("Cancel", 14, WidgetColors.buttonColor, FontWeight.w500),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//     Widget continueButton = FlatButton(
//       child: customText("Continue", 14, WidgetColors.buttonColor, FontWeight.w500),
//       // Text("Continue"),
//       onPressed: () {},
//     );
//
//     AlertDialog alert = AlertDialog(
//       scrollable: true,
//       title: Text("AlertDialog"),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           CustomTextInputData(
//             onChanged: () {},
//             title: "",
//             hintText: card_number,
//             textEditingController: AllControllers.cardNumber,
//             formFieldValidator: null,
//             textInputType: TextInputType.number,
//             textCapitalization: TextCapitalization.none,
//             obsecureText: false,
//             filledColor: WidgetColors.whiteColor,
//             fill: true,
//             enabledborderColor: Colors.black12,
//             input_text_color: Colors.black,
//             titleColor: Colors.black,
//             hint_text_color: Colors.black45,
//             error_text_color: Colors.black54,
//             content_padding: 15,
//             borderColor: Colors.black,
//             blurRadius: 0,
//             spreadRadius: 0,
//             right: 0,
//             left: 0,
//             dy: 2,
//             dx: 2,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: CustomTextInputData(
//                   onChanged: () {},
//                   title: "",
//                   hintText: exp_month,
//                   textEditingController: AllControllers.monthExp,
//                   formFieldValidator: null,
//                   textInputType: TextInputType.number,
//                   textCapitalization: TextCapitalization.none,
//                   obsecureText: false,
//                   filledColor: WidgetColors.whiteColor,
//                   fill: true,
//                   enabledborderColor: Colors.black12,
//                   input_text_color: Colors.black,
//                   titleColor: Colors.black,
//                   hint_text_color: Colors.black45,
//                   error_text_color: Colors.black54,
//                   content_padding: 15,
//                   borderColor: Colors.black,
//                   blurRadius: 0,
//                   spreadRadius: 0,
//                   right: 0,
//                   left: 0,
//                   dy: 2,
//                   dx: 2,
//                 ),
//               ),
//               Expanded(
//                 child: CustomTextInputData(
//                   onChanged: () {},
//                   title: "",
//                   hintText: exp_year,
//                   textEditingController: AllControllers.yearExp,
//                   formFieldValidator: null,
//                   textInputType: TextInputType.number,
//                   textCapitalization: TextCapitalization.none,
//                   obsecureText: false,
//                   filledColor: WidgetColors.whiteColor,
//                   fill: true,
//                   enabledborderColor: Colors.black12,
//                   input_text_color: Colors.black,
//                   titleColor: Colors.black,
//                   hint_text_color: Colors.black45,
//                   error_text_color: Colors.black54,
//                   content_padding: 15,
//                   borderColor: Colors.black,
//                   blurRadius: 0,
//                   spreadRadius: 0,
//                   right: 0,
//                   left: 5,
//                   dy: 2,
//                   dx: 2,
//                 ),
//               )
//             ],
//           ),
//           CustomTextInputData(
//             onChanged: () {},
//             title: "",
//             hintText: cvc,
//             textEditingController: AllControllers.cvc,
//             formFieldValidator: null,
//             textInputType: TextInputType.number,
//             textCapitalization: TextCapitalization.none,
//             obsecureText: false,
//             filledColor: WidgetColors.whiteColor,
//             fill: true,
//             enabledborderColor: Colors.black12,
//             input_text_color: Colors.black,
//             titleColor: Colors.black,
//             hint_text_color: Colors.black45,
//             error_text_color: Colors.black54,
//             content_padding: 15,
//             borderColor: Colors.black,
//             blurRadius: 0,
//             spreadRadius: 0,
//             right: 0,
//             left: 0,
//             dy: 2,
//             dx: 2,
//           ),
//         ],
//       ),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//
//     // show the dialog
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return WillPopScope(
//       onWillPop: () {},
//       child: Scaffold(
//         body: Container(
//           child: Center(
//             child: RaisedButton(
//               child: Text("Create Token with Card Form"),
//               onPressed: () {
//                 showAlertDialog(context);
//                 // StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest()).then((paymentMethod) {
//                 //   // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Received ${paymentMethod.id}')));
//                 //   setState(() {
//                 //     // _paymentMethod = paymentMethod;
//                 //   });
//                 // }).catchError(setError);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
