import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<LoginPage> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  var deviceToken;

  @override
  initState() {
    getDeviceToken();
    getCurrentLocation();
    getData();
    super.initState();
  }

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

  getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  bool isLoggedIn = false;
  final facebookLogin = FacebookLogin();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  bool signinautoValidate = false;
  final GlobalKey<FormState> signinformKeyValidate = GlobalKey<FormState>();
  final signInscaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          body: Form(
            child: Container(
                color: Colors.grey.shade100,
                height: height,
                width: width,
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height / 1.1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            splashScreenLogo,
                            height: height / 3.2,
                          ),
                          Padding(
                            child: CustomTextInputData(
                              maxline: 1,
                              onChanged: () {
                                setState(() {
                                  buttonWithText(height, width);
                                });
                              },
                              title: "",
                              hintText: email,
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
                              error_text_color: Colors.black54,
                              content_padding: 15,
                              borderColor: Colors.black,
                              blurRadius: 2,
                              spreadRadius: 2,
                              right: 25,
                              left: 25,
                              dy: 2,
                              dx: 2,
                            ),
                            padding: EdgeInsets.only(left: 7, right: 7),
                          ),
                          Container(
                            height: height * .03,
                          ),
                          buttonWithText(height, width)
                        ],
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        activeColor: WidgetColors.themeColor,
                        checkColor: WidgetColors.blackColor,
                        value: value2,
                        onChanged: _value2Changed,
                      ),
                      title: InkWell(
                        child: RichText(
                          text: TextSpan(
                            text: "By Click Here, you are agree to our ",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: "terms and condition",
                                style: GoogleFonts.poppins(
                                    color: Colors.blue, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          showAlertDialog(context);
                        },
                      ),
                      onTap: () => this.setState(() {
                        this.selected = !this.selected;
                      }),
                    ),
                  ],
                ))),
            autovalidate: signinautoValidate,
            key: signinformKeyValidate,
          ),
          key: signInscaffoldKey,
        ),
        onWillPop: () {
          return BackFunction.exitThApp();
        });
  }

  var data;

  bool value2 = true;
  bool selected = true;

  void _value2Changed(bool value) {
    setState(() {
      value2 = value;
    });
  }

  getData() async {
    data = await getFileData("assets/data.txt");
    // print("===========>>${data}");
    setState(() {});
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: Text(
        "Term & Condition:",
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      content: Text(data.toString(), style: GoogleFonts.poppins()),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Image Button For FB and Google
  Widget buttonWithText(double height, double width) {
    if (AllControllers.emailController.text == null ||
        AllControllers.emailController.text == "") {
      return Column(
        children: [
          Text(
            orSignWith,
            style: GoogleFonts.poppins(),
          ),
          Container(
            height: height * .03,
          ),
          // Container(
          //   margin: EdgeInsets.only(left: 30, right: 30),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //           child: value2
          //               ? InkWell(
          //                   child: Image.asset(
          //                     fb_button,
          //                     width: width / 2.5,
          //                     height: height * .06,
          //                   ),
          //                   onTap: () {
          //                     fbLogin();
          //                   },
          //                 )
          //               : InkWell(
          //                   child: Image.asset(
          //                     fb_button,
          //                     width: width / 2.5,
          //                     height: height * .06,
          //                   ),
          //                   onTap: () {
          //                     ValidationData.customToast(
          //                         "Please read Terms and Conditions!",
          //                         WidgetColors.MainTitleColor,
          //                         WidgetColors.whiteColor,
          //                         ToastGravity.CENTER);
          //                   },
          //                 )),
          //       Container(
          //         child: value2
          //             ? InkWell(
          //                 child: Image.asset(
          //                   google_button,
          //                   width: width / 2.5,
          //                   height: height * .06,
          //                 ),
          //                 onTap: () {
          //                   googleLogin();
          //                 },
          //               )
          //             : InkWell(
          //                 child: Image.asset(
          //                   google_button,
          //                   width: width / 2.5,
          //                   height: height * .06,
          //                 ),
          //                 onTap: () {
          //                   ValidationData.customToast(
          //                       "Please read Terms and Conditions!",
          //                       WidgetColors.MainTitleColor,
          //                       WidgetColors.whiteColor,
          //                       ToastGravity.CENTER);
          //                 },
          //               ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: Platform.isAndroid
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: value2
                                ? InkWell(
                                    child: Image.asset(
                                      fb_button_android,
                                      width: width / 2.5,
                                      height: height * .06,
                                    ),
                                    onTap: () {
                                      fbLogin();
                                    },
                                  )
                                : InkWell(
                                    child: Image.asset(
                                      fb_button_android,
                                      width: width / 2.5,
                                      height: height * .06,
                                    ),
                                    onTap: () {
                                      ValidationData.customToast(
                                          "Please read Terms and Conditions!",
                                          WidgetColors.MainTitleColor,
                                          WidgetColors.whiteColor,
                                          ToastGravity.CENTER);
                                    },
                                  )),
                        Container(
                          width: width * .02,
                        ),
                        Container(
                          child: value2
                              ? InkWell(
                                  child: Image.asset(
                                    google_button_android,
                                    width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    googleLogin();
                                  },
                                )
                              : InkWell(
                                  child: Image.asset(
                                    google_button_android,
                                    width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    ValidationData.customToast(
                                        "Please read Terms and Conditions!",
                                        WidgetColors.MainTitleColor,
                                        WidgetColors.whiteColor,
                                        ToastGravity.CENTER);
                                  },
                                ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: value2
                                ? InkWell(
                                    child: Image.asset(
                                      fb_button,
                                      // width: width / 2.5,
                                      height: height * .06,
                                    ),
                                    onTap: () {
                                      fbLogin();
                                    },
                                  )
                                : InkWell(
                                    child: Image.asset(
                                      fb_button,
                                      // width: width / 2.5,
                                      height: height * .06,
                                    ),
                                    onTap: () {
                                      ValidationData.customToast(
                                          "Please read Terms and Conditions!",
                                          WidgetColors.MainTitleColor,
                                          WidgetColors.whiteColor,
                                          ToastGravity.CENTER);
                                    },
                                  )),
                        Container(
                          width: width * .07,
                        ),
                        Container(
                          child: value2
                              ? InkWell(
                                  child: Image.asset(
                                    google_button,
                                    // width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    googleLogin();
                                  },
                                )
                              : InkWell(
                                  child: Image.asset(
                                    google_button,
                                    // width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    ValidationData.customToast(
                                        "Please read Terms and Conditions!",
                                        WidgetColors.MainTitleColor,
                                        WidgetColors.whiteColor,
                                        ToastGravity.CENTER);
                                  },
                                ),
                        ),
                        Container(
                          width: width * .07,
                        ),
                        Container(
                          child: value2
                              ? InkWell(
                                  child: Image.asset(
                                    apple_button,
                                    // width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    appleLoginMethod();
                                  },
                                )
                              : InkWell(
                                  child: Image.asset(
                                    apple_button,
                                    // width: width / 2.5,
                                    height: height * .06,
                                  ),
                                  onTap: () {
                                    ValidationData.customToast(
                                        "Please read Terms and Conditions!",
                                        WidgetColors.MainTitleColor,
                                        WidgetColors.whiteColor,
                                        ToastGravity.CENTER);
                                  },
                                ),
                        ),
                      ],
                    )),
        ],
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          left: 32,
          right: 32,
        ),
        child: MaterialButtonClassPage(
          height: height * .06,
          radius: BorderRadius.circular(05),
          buttonName: loginAndSignUp,
          onPress: () {
            validateInputs();
          },
          color: WidgetColors.buttonColor,
          minwidth: width,
          fontSize: 14,
        ),
      );
    }
  }

  Future<void> appleLoginMethod() async {
    if (await AppleSignIn.isAvailable()) {
      final AuthorizationResult result = await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          // print("appleLoginMethod : ${result.credential.email}");
          // print("appleLoginMethod familyName: ${result.credential.fullName.familyName}");
          // print("appleLoginMethod givenName: ${result.credential.fullName.givenName}");
          var apple_name = result.credential.fullName.familyName.toString() +
              " " +
              result.credential.fullName.givenName.toString();
          socialMediaDataInsert(
              apple_name.toString(),
              result.credential.email.toString(),
              deviceToken.toString(),
              "apple_login",
              "https://static.thenounproject.com/png/146720-200.png");
          // print("appleLoginMethod namePrefix : ${result.credential.fullName.namePrefix}");
          // print("appleLoginMethod middleName: ${result.credential.fullName.middleName}");
          // print("appleLoginMethod nameSuffix: ${result.credential.fullName.nameSuffix}");
          // print("appleLoginMethod nickname: ${result.credential.fullName.nickname}");
          break;
        case AuthorizationStatus.error:
          ValidationData.customToast(
              result.error.localizedDescription.toString(),
              Colors.red,
              Colors.white,
              ToastGravity.BOTTOM);
          // print("Sign in failed: ${result.error.localizedDescription}");
          break;
        case AuthorizationStatus.cancelled:
          ValidationData.customToast("Cancelled by user!", Colors.red,
              Colors.white, ToastGravity.BOTTOM);
          // print('User cancelled');
          break;
      }
    } else {
      ValidationData.customToast(
          "Apple login is not supported for your device!",
          Colors.red,
          Colors.white,
          ToastGravity.BOTTOM);
    }
  }

  // Facebook Login
  fbLogin() async {
    facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;
    final FacebookLoginResult result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${result.accessToken.token}');
        final profile = JSON.jsonDecode(graphResponse.body);

        if (this.mounted) {
          setState(() {
            var idfb = profile['id'];
            var name = profile['first_name'];
            var email = profile['email'];
            var urlfb = profile['picture']['data']['url'];

            // print("=============>>Login1 ${name}");
            // print("=============>>Login1 ${email}");
            // print("=============>>Login1 ${urlfb}");

            socialMediaDataInsert(name, email, deviceToken, "facebook", urlfb);
          });
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        setState(() => isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => isLoggedIn = false);
        break;
    }
  }

//  name,email,mobile_token,login_method
  Future socialMediaDataInsert(
      var name, email, mobile_token, login_method, photo_url) async {
    signInscaffoldKey.currentState.showSnackBar(new SnackBar(
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
              "Validate Data...",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        )));
    // print("=============>>Login${name}");
    // print("=============>>Login${email}");
    // print("=============>>Login${mobile_token}");
    // print("=============>>Login${login_method}");
    // print("=============>>Login${photo_url}");
    try {
      final response = await http.post(social_media_insert, body: {
        "name": name,
        "email": email,
        "mobile_token": mobile_token,
        "login_method": login_method,
        "profile_pic": photo_url
      });
      // print("=============>>Login${response}");
      var status;
      var jsonData;
      if (this.mounted) {
        setState(() {
          jsonData = json.decode(response.body);
          // print("=============>>Login${jsonData}");
          status = jsonData['status'];
        });
      }
      if (status == 200 || status == "200") {
        var resultData = jsonData['data'];
        if (resultData['role'] == "customer" || resultData['role'] == null) {
          if (resultData['status'] == null ||
              resultData['status'] == "null" ||
              resultData['status'] == "0" ||
              resultData['status'] == 0) {
            BackFunction.commonNavigator(
                context,
                ProfilePage(
                  loginMethod: "fborgoogle",
                  user_id: resultData['customer_id'].toString(),
                  user_photo_url: photo_url,
                  user_name: name,
                  user_email: email,
                ));
          } else {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setString(
                "user_id", resultData['customer_id'].toString());
            BackFunction.commonNavigator(
                context,
                BottomNavBarPage(
                  initialIndex: 0,
                  initialIndexJob: 0,
                ));
          }
        } else {
          signInscaffoldKey.currentState.hideCurrentSnackBar();
          ValidationData.customToast(
              "This Email is already registered with Technician!",
              Colors.red,
              Colors.white,
              ToastGravity.BOTTOM);
          signout();
        }
      } else {
        ValidationData.customToast(
            "Error", Colors.red, Colors.white, ToastGravity.BOTTOM);
        signInscaffoldKey.currentState.hideCurrentSnackBar();
      }
    } catch (e) {
      ValidationData.customToast(
          e.toString(), Colors.red, Colors.white, ToastGravity.CENTER);
      signInscaffoldKey.currentState.hideCurrentSnackBar();
    }
  }

  Future signout() async {
    await facebookLogin.logOut();
    await googleSignIn.signOut();
  }

  // Google Login
  googleLogin() async {
    try {
      await googleSignIn.signIn().whenComplete(() {
        if (this.mounted) {
          setState(() {
            googleSignIn.currentUser.displayName != null ||
                    googleSignIn.currentUser.displayName != ""
                ? socialMediaDataInsert(
                    googleSignIn.currentUser.displayName,
                    googleSignIn.currentUser.email,
                    deviceToken,
                    "google",
                    googleSignIn.currentUser.photoUrl)
                : Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ),
                  );
            isLoggedIn = true;
          });
        }
      });
    } catch (err) {
      Fluttertoast.showToast(
        textColor: Colors.white,
        backgroundColor: Colors.red,
        msg: err.toString(),
        //"Cancelled By User",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  // Check Validation of input fiels
  void validateInputs() {
    if (signinformKeyValidate.currentState.validate()) {
      setState(() {
        signinformKeyValidate.currentState.save();
        getOtp(AllControllers.emailController.text.toString());
        signInscaffoldKey.currentState.showSnackBar(new SnackBar(
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
        signinautoValidate = true;
        Fluttertoast.showToast(msg: "Error");
        signInscaffoldKey.currentState.hideCurrentSnackBar();
      });
    }
  }

  // API call Of Get OTP
  getOtp(var mobileNumber) async {
    final responce = await http.post(generate_otp, body: {
      "email": mobileNumber.toString(),
      "mobile_token": deviceToken.toString(),
      "role": "customer"
    });

    // if (this.mounted) {
    //   setState(() async {
    var data = JSON.jsonDecode(responce.body);
    // print("Generate OTP consumer : ${data}");
    setState(() {});
    var result = data['data'];
    // print("Generate OTP consumer : ${result["otp"]}");
    // print("Generate OTP consumer role : ${result['role']}");

    if (data['status'] == 200 || data['status'] == "200") {
      if (result['role'] == "customer" || result['role'] == null) {
        if (result['status'] == 0 ||
            result['status'] == "0" ||
            result['status'] == null) {
          if (result["otp"] != null) {
            // print("Generate OTP consumer role 1: ${result['role']}");

            ValidationData.customToast(
                "We have sent OTP to ${mobileNumber.toString()}",
                Colors.black,
                Colors.white,
                ToastGravity.BOTTOM);

            BackFunction.commonNavigator(
                context,
                PinCodeVerificationScreen(
                  user_id: result['user_id'].toString(),
                  otp: result['otp'].toString(),
                  mobileP: mobileNumber.toString(),
                  user_status: result['status'].toString(),
                  user_role: result['role'].toString(),
                ));
          } else {
            ValidationData.customToast("Please enter valid email address!",
                Colors.red, Colors.white, ToastGravity.CENTER);
          }
        } else {
          ValidationData.customToast(
              "We have sent OTP to ${mobileNumber.toString()}",
              Colors.black,
              Colors.white,
              ToastGravity.BOTTOM);

          BackFunction.commonNavigator(
              context,
              PinCodeVerificationScreen(
                user_id: result['user_id'].toString(),
                otp: result['otp'].toString(),
                mobileP: mobileNumber.toString(),
                user_status: result['status'].toString(),
                user_role: result['role'].toString(),
              ));
          // SharedPreferences preferences = await SharedPreferences.getInstance();
          // preferences.setString("user_id", result['user_id'].toString());
          // BackFunction.commonNavigator(
          //     context,
          //     BottomNavBarPage(
          //       initialIndex: 0,
          //       initialIndexJob: 0,
          //     ));
        }
      } else {
        signInscaffoldKey.currentState.hideCurrentSnackBar();
        ValidationData.customToast(
            "This Email is already registered with Technician!",
            Colors.red,
            Colors.white,
            ToastGravity.BOTTOM);
      }
    } else {
      ValidationData.customToast(data['message'].toString(), Colors.red,
          Colors.white, ToastGravity.BOTTOM);
    }
    //   });
    // }
  }
}
