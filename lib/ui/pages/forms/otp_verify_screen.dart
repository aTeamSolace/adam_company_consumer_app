import 'dart:async';
import 'dart:convert';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'profile_page.dart';

// class PinCodeVerificationScreen extends StatefulWidget {
//   var mobileP;
//   var otp;
//   var user_status;
//   var user_id;
//
//   PinCodeVerificationScreen(
//       {this.mobileP, this.otp, this.user_status, @required this.user_id});
//
//   @override
//   _PinCodeVerificationScreenState createState() =>
//       _PinCodeVerificationScreenState();
// }
//
// class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
//   var onTapRecognizer;
//
//   StreamController<ErrorAnimationType> errorController;
//
//   bool hasError = false;
//   String currentText = "";
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     getDeviceToken();
// //    print("======>>${widget.mobileP}");
// //    print("======>>${widget.otp}");
//     onTapRecognizer = TapGestureRecognizer()
//       ..onTap = () {
//         Navigator.pop(context);
//       };
//     errorController = StreamController<ErrorAnimationType>();
//     startTimer();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     errorController.close();
//     super.dispose();
//   }
//
//   Timer _timer;
//   int _start = 10;
//
//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(oneSec, (Timer timer) {
//       if (this.mounted) {
//         setState(
//           () {
//             if (_start < 1) {
//               timer.cancel();
//             } else {
//               _start = _start - 1;
//             }
//           },
//         );
//       }
//     });
//   }
//
//   Widget textWidget() {
//     if (_start > 0) {
//       return RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//             text: "Resend OTP in ",
//             style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15),
//             children: [
//               TextSpan(
//                   text: " $_start seconds",
// //                            recognizer: onTapRecognizer,
//                   style: GoogleFonts.poppins(
//                       color: WidgetColors.buttonColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16))
//             ]),
//       );
//     } else {
//       return InkWell(
//         child: RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(
//               text: "Didn't receive the code? ",
//               style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15),
//               children: [
//                 TextSpan(
//                     text: " RESEND",
//                     style: GoogleFonts.poppins(
//                         color: WidgetColors.themeColor,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16))
//               ]),
//         ),
//         onTap: () {
//           getOtp();
//         },
//       );
//     }
//   }
//
//   FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
//   var deviceToken;
//
//   getDeviceToken() {
//     firebaseMessaging.getToken().then((token) {
//       if (this.mounted) {
//         setState(() {
//           AllControllers.phoneController.clear();
//           AllControllers.emailController.clear();
//           deviceToken = token.toString();
//           // print("=========>>$deviceToken");
//         });
//       }
//     });
//   }
//
//   getOtp() async {
//     final responce = await http.post(generate_otp, body: {
//       "email": widget.mobileP.toString(),
//       "mobile_token": deviceToken.toString()
//     });
//
//     if (this.mounted) {
//       setState(() async {
//         var data = json.decode(responce.body);
//         // print("Generate OTP consumer : ${data}");
//
//         var result = data['data'];
//         // print("Generate OTP consumer : ${result["otp"]}");
//         // print("Generate OTP consumer : ${result['status']}");
//
//         if (data['status'] == 200 || data['status'] == "200") {
//           if (result['status'] == 0 ||
//               result['status'] == "0" ||
//               result['status'] == null) {
//             if (result["otp"] != null) {
//               ValidationData.customToast(
//                   "We have re-send OTP to your Email Id!",
//                   Colors.black,
//                   Colors.white,
//                   ToastGravity.BOTTOM);
//             } else {
//               ValidationData.customToast("Please enter valid email address!",
//                   Colors.red, Colors.white, ToastGravity.CENTER);
//             }
//           } else {
//             SharedPreferences preferences =
//                 await SharedPreferences.getInstance();
//             preferences.setString("user_id", result['user_id'].toString());
//             BackFunction.commonNavigator(
//                 context,
//                 BottomNavBarPage(
//                   initialIndex: 0,
//                   initialIndexJob: 0,
//                 ));
//           }
//         } else {
//           ValidationData.customToast(data['message'].toString(), Colors.red,
//               Colors.white, ToastGravity.CENTER);
//         }
//       });
//     }
//   }
//
//   Map<String, String> requestHeaders = {
//     'Accept': 'application/json',
//   };
//
//   Future verifyOtp() async {
//     scaffoldKey.currentState.showSnackBar(SnackBar(
//       backgroundColor: Colors.white,
//       content: Container(
//         child: Row(
//           children: [
//             Container(
//               width: 15,
//             ),
//             PlatformLoader(
//               radius: 15,
//               color: Colors.blue,
//             ),
//             Container(
//               width: 15,
//             ),
//             Text(
//               "Verifying",
//               style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),
//             )
//           ],
//         ),
//         height: 40,
//       ),
//       duration: Duration(seconds: 10),
//     ));
//
//     // if (widget.otp.toString() == AllControllers.otpController.text.toString()) {
//     //   // ValidationData.customToast("Verified Successfully..!!", Colors.white,
//     //   //     Colors.red, ToastGravity.CENTER);
//     //   // if (widget.user_status == 0 ||
//     //   //     widget.user_status == "0" ||
//     //   //     widget.user_status == null ||
//     //   //     widget.user_status == "null") {
//     //   //
//     //   //
//     //   // } else {
//     //   //   BackFunction.commonNavigator(
//     //   //       context,
//     //   //       BottomNavBarPage(
//     //   //         initialIndex: 0,
//     //   //         initialIndexJob: 0,
//     //   //       ));
//     //   //
//     //   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//     //   //   preferences.setString("user_id", widget.user_id.toString());
//     //   // }
//     //
//     //   Navigator.pushReplacement(
//     //       context,
//     //       MaterialPageRoute(
//     //           builder: (_) => ProfilePage(
//     //             loginMethod: "mobile",
//     //             user_id: widget.user_id,
//     //             mobile_number: widget.mobileP,
//     //           )));
//     //
//     //   AllControllers.otpController.clear();
//     //   AllControllers.phoneController.clear();
//     // } else {
//     //   ValidationData.customToast("Verification Wrong, Please enter right OTP",
//     //       Colors.red, Colors.white, ToastGravity.CENTER);
//     //   scaffoldKey.currentState.hideCurrentSnackBar();
//     // }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       key: scaffoldKey,
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(FocusNode());
//         },
//         child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//                 child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(height: 30),
//                   Image.asset(
//                     splashScreenLogo,
//                     height: height / 3.2,
//                   ),
//                   SizedBox(height: 8),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       verifyCode,
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: Colors.grey),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Text(
//                       widget.mobileP.toString(),
//                       style: GoogleFonts.poppins(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 16,
//                           color: Colors.grey),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
// //              Padding(
// //                padding:
// //                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
// //                child: RichText(
// //                  text: TextSpan(
// //                      text: "Enter the code sent to   +",
// //                      children: [
// //                        TextSpan(
// //                            text: widget.mobileP,
// //                            style: GoogleFonts.vollkorn(
// //                                color: Colors.black,
// //                                fontWeight: FontWeight.bold,
// //                                fontSize: 15)),
// //                      ],
// //                      style: GoogleFonts.vollkorn(
// //                          color: Colors.black87, fontSize: 15)),
// //                  textAlign: TextAlign.center,
// //                ),
// //              ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Form(
//                     key: formKey,
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8.0, horizontal: 30),
//                         child: PinCodeTextField(
//                           autoDisposeControllers: false,
//                           length: 6,
//                           animationType: AnimationType.fade,
//                           validator: (v) {
//                             if (v.length < 5) {
//                               return "Wrong OTP";
//                             } else {
//                               return null;
//                             }
//                           },
//                           pinTheme: PinTheme(
//                               borderWidth: 1,
//                               selectedFillColor: Colors.white,
//                               selectedColor: Colors.black,
//                               shape: PinCodeFieldShape.box,
//                               borderRadius: BorderRadius.circular(2),
//                               fieldHeight: 45,
//                               fieldWidth: 45,
//                               inactiveFillColor: Colors.white,
//                               inactiveColor: Colors.grey.shade400,
//                               activeFillColor:
//                                   hasError ? Colors.red : Colors.white,
//                               activeColor: Colors.grey.shade50),
//                           animationDuration: Duration(milliseconds: 300),
//                           backgroundColor: Colors.grey.shade50,
//                           enableActiveFill: true,
//                           errorAnimationController: errorController,
//                           controller: AllControllers.otpController,
//                           onChanged: (value) {
//                             if (this.mounted) {
//                               setState(() {
//                                 currentText = value;
//                               });
//                             }
//                           },
//                           appContext: context,
//                         )),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Text(
//                       hasError ? "*Please fill up all the cells properly" : "",
//                       style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   textWidget(),
//                   SizedBox(
//                     height: 14,
//                   ),
//                   Container(
//                     child: _start > 0
//                         ? AbsorbPointer(
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(
//                                   vertical: 16.0, horizontal: 30),
//                               child: ButtonTheme(
//                                 height: 40,
//                                 child: FlatButton(
//                                   onPressed: () {
//                                     formKey.currentState.validate();
//                                     // conditions for validating
//                                     if (currentText.length != 6) {
//                                       // ERROR SHOW
//
//                                       errorController
//                                           .add(ErrorAnimationType.shake);
//                                       if (this.mounted) {
//                                         setState(() {
//                                           hasError = true;
//                                         });
//                                       }
//                                     } else {
//                                       if (this.mounted) {
//                                         setState(() {
//                                           verifyOtp();
//
//                                           hasError = false;
//                                         });
//                                       }
//                                     }
//                                   },
//                                   child: Center(
//                                       child: Text(
//                                     continue_data,
//                                     style: GoogleFonts.poppins(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w500),
//                                   )),
//                                 ),
//                               ),
//                               decoration: BoxDecoration(
//                                 color: WidgetColors.bgColor,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                             ),
//                             absorbing: true,
//                           )
//                         : Container(
//                             margin: const EdgeInsets.symmetric(
//                                 vertical: 16.0, horizontal: 30),
//                             child: ButtonTheme(
//                               height: 40,
//                               child: FlatButton(
//                                 onPressed: () {
//                                   formKey.currentState.validate();
//                                   // conditions for validating
//                                   if (currentText.length != 6) {
//                                     // ERROR SHOW
//
//                                     errorController
//                                         .add(ErrorAnimationType.shake);
//                                     if (this.mounted) {
//                                       setState(() {
//                                         hasError = true;
//                                       });
//                                     }
//                                   } else {
//                                     if (this.mounted) {
//                                       setState(() {
//                                         verifyOtp();
//
//                                         hasError = false;
//                                       });
//                                     }
//                                   }
//                                 },
//                                 child: Center(
//                                     child: Text(
//                                   continue_data,
//                                   style: GoogleFonts.poppins(
//                                       color: WidgetColors.blackColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 )),
//                               ),
//                             ),
//                             decoration: BoxDecoration(
//                               color: WidgetColors.themeColor,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                           ),
//                   ),
//
// //              Container(
// //                child: _start > 0
// //                    ? Container(
// //                        margin: const EdgeInsets.symmetric(
// //                            vertical: 16.0, horizontal: 30),
// //                        child: ButtonTheme(
// //                          height: 50,
// //                          child: FlatButton(
// //                            onPressed: () {},
// //                            child: Center(
// //                                child: Text(
// //                              "VERIFY".toUpperCase(),
// //                              style: GoogleFonts.vollkorn(
// //                                  color: Colors.white,
// //                                  fontSize: 18,
// //                                  fontWeight: FontWeight.w500),
// //                            )),
// //                          ),
// //                        ),
// //                        decoration: BoxDecoration(
// //                          color: Colors.grey,
// //                          borderRadius: BorderRadius.circular(5),
// ////                    boxShadow: [
// ////                      BoxShadow(
// ////                          color: Colors.green.shade200,
// ////                          offset: Offset(1, -2),
// ////                          blurRadius: 5),
// ////                      BoxShadow(
// ////                          color: Colors.green.shade200,
// ////                          offset: Offset(-1, 2),
// ////                          blurRadius: 5)
// ////                    ]
// //                        ),
// //                      )
// //                    : Container(
// //                        margin: const EdgeInsets.symmetric(
// //                            vertical: 16.0, horizontal: 30),
// //                        child: ButtonTheme(
// //                          height: 50,
// //                          child: FlatButton(
// //                            onPressed: () {
// //                              formKey.currentState.validate();
// //                              // conditions for validating
// //                              if (currentText.length != 6) {
// //                                // ERROR SHOW
// //
// //                                errorController.add(ErrorAnimationType.shake);
// //                                if (this.mounted) {
// //                                  setState(() {
// //                                    hasError = true;
// //                                  });
// //                                }
// //                              } else {
// //                                if (this.mounted) {
// //                                  setState(() {
// ////                              verifyOtp();
// //                                    hasError = false;
// //                                    scaffoldKey.currentState
// //                                        .showSnackBar(SnackBar(
// //                                      backgroundColor: Colors.white,
// //                                      content: Container(
// //                                        child: Row(
// //                                          children: [
// //                                            Container(
// //                                              width: 15,
// //                                            ),
// //                                            PlatformLoader(
// //                                              radius: 15,
// //                                              color: Colors.blue,
// //                                            ),
// //                                            Container(
// //                                              width: 15,
// //                                            ),
// //                                            Text(
// //                                              "Verifying",
// //                                              style: GoogleFonts.vollkorn(
// //                                                  color: Colors.black,
// //                                                  fontSize: 16),
// //                                            )
// //                                          ],
// //                                        ),
// //                                        height: 40,
// //                                      ),
// //                                      duration: Duration(seconds: 10),
// //                                    ));
// //                                  });
// //                                }
// //                              }
// //                            },
// //                            child: Center(
// //                                child: Text(
// //                              "VERIFY".toUpperCase(),
// //                              style: GoogleFonts.vollkorn(
// //                                  color: Colors.white,
// //                                  fontSize: 18,
// //                                  fontWeight: FontWeight.w500),
// //                            )),
// //                          ),
// //                        ),
// //                        decoration: BoxDecoration(
// //                          color: Colors.blue.shade900,
// //                          borderRadius: BorderRadius.circular(5),
// //                        ),
// //                      ),
// //              ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                 ],
//               ),
//               height: height,
//             ))),
//       ),
//     );
//   }
// }

class PinCodeVerificationScreen extends StatefulWidget {
  var mobileP;
  var otp;
  var user_status;
  var user_id;
  var user_role;

  PinCodeVerificationScreen(
      {this.mobileP,
      this.otp,
      this.user_status,
      @required this.user_id,
      this.user_role});

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var otp_text;
  var user_status;

  @override
  void initState() {
    user_status = widget.user_status.toString();
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    getDeviceToken();
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
    // setOtp();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

  Timer _timer;
  int _start = 10;

  setOtp() {
    setState(() {
      otp_text = widget.otp.toString();

      // print("=====>> otp_text ${otp_text}");
    });
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (this.mounted) {
        setState(
          () {
            if (_start < 1) {
              timer.cancel();
            } else {
              _start = _start - 1;
            }
          },
        );
      }
    });
  }

  Widget textWidget() {
    if (_start > 0) {
      return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Resend OTP in ",
            style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15),
            children: [
              TextSpan(
                  text: " $_start seconds",
//                            recognizer: onTapRecognizer,
                  style: GoogleFonts.poppins(
                      color: WidgetColors.buttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16))
            ]),
      );
    } else {
      return InkWell(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Didn't receive the code? ",
              style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15),
              children: [
                TextSpan(
                    text: " RESEND",
                    style: GoogleFonts.poppins(
                        color: WidgetColors.buttonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))
              ]),
        ),
        onTap: () {
          getOtp();
          _onLoading();
        },
      );
    }
  }

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;

  getDeviceToken() {
    firebaseMessaging.getToken().then((token) {
      if (this.mounted) {
        setState(() {
          AllControllers.phoneController.clear();
          AllControllers.emailController.clear();
          deviceToken = token.toString();
          // print("=========>>$deviceToken");
        });
      }
    });
  }

  getOtp() async {
    final responce = await http.post(generate_otp, body: {
      "email": widget.mobileP.toString(),
      "mobile_token": deviceToken.toString()
    });
    var data = json.decode(responce.body);
    // print("Generate OTP consumer : ${data}");
    setState(() {});
    var result = data['data'];
    // if (data['status'] == 200 || data['status'] == "200") {
    //   if (result['role'] == "customer" || result['role'] == null) {
    //     if (result['status'] == 0 ||
    //         result['status'] == "0" ||
    //         result['status'] == null) {
    //       if (result["otp"] != null) {
    //         ValidationData.customToast(
    //             "We have sent OTP to ${mobileNumber.toString()}",
    //             Colors.black,
    //             Colors.white,
    //             ToastGravity.BOTTOM);
    //
    //         BackFunction.commonNavigator(
    //             context,
    //             PinCodeVerificationScreen(
    //               user_id: result['user_id'].toString(),
    //               otp: result['otp'].toString(),
    //               mobileP: mobileNumber.toString(),
    //               user_status: result['status'].toString(),
    //             ));
    //       } else {
    //         ValidationData.customToast("Please enter valid email address!",
    //             Colors.red, Colors.white, ToastGravity.CENTER);
    //       }
    //     } else {
    //       ValidationData.customToast(
    //           "We have sent OTP to ${mobileNumber.toString()}",
    //           Colors.black,
    //           Colors.white,
    //           ToastGravity.BOTTOM);
    //
    //       BackFunction.commonNavigator(
    //           context,
    //           PinCodeVerificationScreen(
    //             user_id: result['user_id'].toString(),
    //             otp: result['otp'].toString(),
    //             mobileP: mobileNumber.toString(),
    //             user_status: result['status'].toString(),
    //           ));
    //       // SharedPreferences preferences = await SharedPreferences.getInstance();
    //       // preferences.setString("user_id", result['user_id'].toString());
    //       // BackFunction.commonNavigator(
    //       //     context,
    //       //     BottomNavBarPage(
    //       //       initialIndex: 0,
    //       //       initialIndexJob: 0,
    //       //     ));
    //     }
    //   } else {
    //     signInscaffoldKey.currentState.hideCurrentSnackBar();
    //     ValidationData.customToast(
    //         "This Email is already registered with Technician!",
    //         Colors.red,
    //         Colors.white,
    //         ToastGravity.BOTTOM);
    //   }
    // } else {
    //   ValidationData.customToast(data['message'].toString(), Colors.red,
    //       Colors.white, ToastGravity.BOTTOM);
    // }

    if (data['status'] == 200 || data['status'] == "200") {
      ValidationData.customToast(
          "We have sent OTP to ${widget.mobileP.toString()}!",
          Colors.black,
          Colors.white,
          ToastGravity.BOTTOM);
      setState(() {
        otp_text = result["otp"].toString();
        user_status = result['status'].toString();
      });
      Navigator.pop(context);
    }
  }

  // void getOtp() {
  //   Provider.of<AddDataApiProvider>(context, listen: false)
  //       .OtpLoginApi(UserInsert(
  //       email: widget.mobileP.toString(),
  //       mobile_token: deviceToken.toString()))
  //       .then((value) {
  //     try {
  //       if (value.status == 200 || value.status == "200") {
  //         ValidationData.customToast(
  //             "We have sent OTP to ${widget.mobileP.toString()}!",
  //             Colors.black,
  //             Colors.white,
  //             ToastGravity.BOTTOM);
  //         setState(() {
  //           otp_text = value.data.otp.toString();
  //           user_status = value.data.status.toString();
  //         });
  //         Navigator.pop(context);
  //       }
  //     } catch (e) {
  //       ValidationData.customToast(
  //           e.toString(), Colors.red, Colors.white, ToastGravity.BOTTOM);
  //     }
  //   });
  // }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: new Container(
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new PlatformLoader(
                    radius: 15, color: WidgetColors.MainTitleColor),
                Container(
                  width: 20,
                ),
                new Text("Sending OTP..."),
              ],
            ),
          ),
          height: 80,
        ));
      },
    );
    // new Future.delayed(new Duration(seconds: 2), () {
    //   Navigator.pop(context); //pop dialog
    // });
  }

  Future verifyOtp() async {
    // print("verify_otp user_role: ${widget.user_role.toString()}");

    showLoader();
    final responce = await http.post(verify_otp, body: {
      "user_id": widget.user_id.toString(),
      "otp": AllControllers.otpController.text.toString(),
      "role": widget.user_role.toString()
    }).then((value) {
      final responce = json.decode(value.body);
      // print("verify_otp: ${value.body}");
      // print("verify_otp: ${AllControllers.otpController.text.toString()}");
      // print("verify_otp: ${widget.user_id.toString()}");

      if (responce['status'] == 200) {
        if (responce['data'] == 1 || responce['data'] == "1") {
          if (user_status == 1 || user_status.toString() == "1") {
            hideLoader();
            setSession(widget.user_id.toString());
            BackFunction.commonNavigator(
                context,
                BottomNavBarPage(
                  initialIndex: 0,
                  initialIndexJob: 0,
                ));
            // BackFunction.commonNavigator(context, GetQuotaionRequest());
          } else {
            hideLoader();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => ProfilePage(
                          loginMethod: "mobile",
                          user_id: widget.user_id,
                          mobile_number: widget.mobileP,
                        )));
          }
          AllControllers.otpController.clear();
          AllControllers.phoneController.clear();
        } else {
          hideLoader();
          ValidationData.customToast(
              "Verification Failed, Please enter correct OTP!",
              Colors.red,
              Colors.white,
              ToastGravity.CENTER);
        }
      } else {
        hideLoader();
        ValidationData.customToast(responce['message'].toString(), Colors.red,
            Colors.white, ToastGravity.CENTER);
      }
    });
  }

  showLoader() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      content: Container(
        child: Row(
          children: [
            Container(
              width: 15,
            ),
            PlatformLoader(
              radius: 15,
              color: Colors.blue,
            ),
            Container(
              width: 15,
            ),
            Text(
              "Verifying...",
              style: GoogleFonts.vollkorn(color: Colors.black, fontSize: 16),
            )
          ],
        ),
        height: 40,
      ),
      duration: Duration(seconds: 10),
    ));
  }

  hideLoader() {
    scaffoldKey.currentState.hideCurrentSnackBar();
  }

  setSession(var user_id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user_id", user_id.toString());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
                child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  Image.asset(
                    splashScreenLogo,
                    height: height / 3.2,
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      verifyCode,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      widget.mobileP.toString(),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
//              Padding(
//                padding:
//                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
//                child: RichText(
//                  text: TextSpan(
//                      text: "Enter the code sent to   +",
//                      children: [
//                        TextSpan(
//                            text: widget.mobileP,
//                            style: GoogleFonts.vollkorn(
//                                color: Colors.black,
//                                fontWeight: FontWeight.bold,
//                                fontSize: 15)),
//                      ],
//                      style: GoogleFonts.vollkorn(
//                          color: Colors.black87, fontSize: 15)),
//                  textAlign: TextAlign.center,
//                ),
//              ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          autoDisposeControllers: false,
                          length: 6,
                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v.length < 5) {
                              return "Wrong OTP";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                              borderWidth: 1,
                              selectedFillColor: Colors.white,
                              selectedColor: Colors.black,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(2),
                              fieldHeight: 45,
                              fieldWidth: 45,
                              inactiveFillColor: Colors.white,
                              inactiveColor: Colors.grey.shade400,
                              activeFillColor:
                                  hasError ? Colors.red : Colors.white,
                              activeColor: Colors.grey.shade50),
                          animationDuration: Duration(milliseconds: 300),
                          backgroundColor: Colors.grey.shade50,
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: AllControllers.otpController,
                          onChanged: (value) {
                            if (this.mounted) {
                              setState(() {
                                currentText = value;
                              });
                            }
                          },
                          appContext: context,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "*Please fill up all the cells properly" : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  textWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: _start > 0
                        ? AbsorbPointer(
                            absorbing: true,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 30),
                              child: ButtonTheme(
                                height: 40,
                                child: FlatButton(
                                  onPressed: () {
                                    formKey.currentState.validate();
                                    // conditions for validating
                                    if (currentText.length != 6) {
                                      // ERROR SHOW

                                      errorController
                                          .add(ErrorAnimationType.shake);
                                      if (this.mounted) {
                                        setState(() {
                                          hasError = true;
                                        });
                                      }
                                    } else {
                                      if (this.mounted) {
                                        setState(() {
                                          verifyOtp();

                                          hasError = false;
                                        });
                                      }
                                    }
                                  },
                                  child: Center(
                                      child: Text(
                                    "Continue",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: WidgetColors.bgColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 30),
                            child: ButtonTheme(
                              height: 40,
                              child: FlatButton(
                                onPressed: () {
                                  formKey.currentState.validate();
                                  // conditions for validating
                                  if (currentText.length != 6) {
                                    // ERROR SHOW

                                    errorController
                                        .add(ErrorAnimationType.shake);
                                    if (this.mounted) {
                                      setState(() {
                                        hasError = true;
                                      });
                                    }
                                  } else {
                                    if (this.mounted) {
                                      setState(() {
                                        verifyOtp();

                                        hasError = false;
                                      });
                                    }
                                  }
                                },
                                child: Center(
                                    child: Text(
                                  "Continue",
                                  style: GoogleFonts.montserrat(
                                      color: WidgetColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: WidgetColors.themeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                  ),

//              SizedBox(
//                height: 14,
//              ),
//              Container(
//                child: _start > 0
//                    ? Container(
//                        margin: const EdgeInsets.symmetric(
//                            vertical: 16.0, horizontal: 30),
//                        child: ButtonTheme(
//                          height: 50,
//                          child: FlatButton(
//                            onPressed: () {},
//                            child: Center(
//                                child: Text(
//                              "VERIFY".toUpperCase(),
//                              style: GoogleFonts.vollkorn(
//                                  color: Colors.white,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.w500),
//                            )),
//                          ),
//                        ),
//                        decoration: BoxDecoration(
//                          color: Colors.grey,
//                          borderRadius: BorderRadius.circular(5),
////                    boxShadow: [
////                      BoxShadow(
////                          color: Colors.green.shade200,
////                          offset: Offset(1, -2),
////                          blurRadius: 5),
////                      BoxShadow(
////                          color: Colors.green.shade200,
////                          offset: Offset(-1, 2),
////                          blurRadius: 5)
////                    ]
//                        ),
//                      )
//                    : Container(
//                        margin: const EdgeInsets.symmetric(
//                            vertical: 16.0, horizontal: 30),
//                        child: ButtonTheme(
//                          height: 50,
//                          child: FlatButton(
//                            onPressed: () {
//                              formKey.currentState.validate();
//                              // conditions for validating
//                              if (currentText.length != 6) {
//                                // ERROR SHOW
//
//                                errorController.add(ErrorAnimationType.shake);
//                                if (this.mounted) {
//                                  setState(() {
//                                    hasError = true;
//                                  });
//                                }
//                              } else {
//                                if (this.mounted) {
//                                  setState(() {
////                              verifyOtp();
//                                    hasError = false;
//                                    scaffoldKey.currentState
//                                        .showSnackBar(SnackBar(
//                                      backgroundColor: Colors.white,
//                                      content: Container(
//                                        child: Row(
//                                          children: [
//                                            Container(
//                                              width: 15,
//                                            ),
//                                            PlatformLoader(
//                                              radius: 15,
//                                              color: Colors.blue,
//                                            ),
//                                            Container(
//                                              width: 15,
//                                            ),
//                                            Text(
//                                              "Verifying",
//                                              style: GoogleFonts.vollkorn(
//                                                  color: Colors.black,
//                                                  fontSize: 16),
//                                            )
//                                          ],
//                                        ),
//                                        height: 40,
//                                      ),
//                                      duration: Duration(seconds: 10),
//                                    ));
//                                  });
//                                }
//                              }
//                            },
//                            child: Center(
//                                child: Text(
//                              "VERIFY".toUpperCase(),
//                              style: GoogleFonts.vollkorn(
//                                  color: Colors.white,
//                                  fontSize: 18,
//                                  fontWeight: FontWeight.w500),
//                            )),
//                          ),
//                        ),
//                        decoration: BoxDecoration(
//                          color: Colors.blue.shade900,
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                      ),
//              ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              height: height,
            ))),
      ),
    );
  }
}
