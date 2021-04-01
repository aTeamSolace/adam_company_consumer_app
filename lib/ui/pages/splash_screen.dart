import 'dart:async';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forms/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  startTimer() {
    var duration = Duration(seconds: 5);
    return Timer(duration, checkSessionValue);
  }

  List<Widget> imageSliders;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user_id = preferences.getString("user_id");
    if (user_id == null || user_id == "") {
      BackFunction.commonNavigator(context, LoginPage());
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => BottomNavBarPage(
            initialIndex: 0,
            initialIndexJob: 0,
          ),
        ),
      );
    }
  }

  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;

  void _onTap() async {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.3 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, checkSessionValue);
    });
  }

  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Stack(
      children: [
        Scaffold(
          body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(yello), fit: BoxFit.cover)),
            child: Stack(
              children: <Widget>[
                Align(
                  child: Column(
                    children: [
                      Container(
                        height: height / 8,
                      ),
                      Image.asset(
                        splashScreenLogo,
                        // height: height / 3.5,
                        width: width / 1.3,
                      ),
                      Container(
                        height: height * .02,
                      ),
                      Text(
                        'YOUR REAL SOLUTION FOR LIFE',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: MediaQuery.of(context).size.width * .05,
                        ),
                      ),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  alignment: Alignment.center,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 120,
                  child: RectGetter(
                      key: rectGetterKey,
                      child: Padding(
                        child: MaterialButton(
                          height: height * .06,
                          minWidth: width / 2,
                          onPressed: () {
                            _onTap();
                          },
                          color: WidgetColors.graph5,
                          splashColor: WidgetColors.whiteColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(05)),
                          child: Text(
                            get_started,
                            style: GoogleFonts.poppins(
                                color: WidgetColors.whiteColor,
                                fontSize: width * .04),
                          ),
                        ),
                        padding: EdgeInsets.only(left: 100, right: 100),
                      )),
                ),
                // Positioned(
                //     left: 0,
                //     right: 0,
                //     bottom: 50,
                //     child: Center(
                //       child: Text(
                //         'Version 1.0.0',
                //         style: GoogleFonts.poppins(
                //           fontWeight: FontWeight.w500,
                //           color: Colors.black,
                //           fontSize: MediaQuery.of(context).size.width * .05,
                //         ),
                //       ),
                //     )),
                Container(
                  height: height * .04,
                ),
              ],
            ),
          ),
        ),
        // Scaffold(
        //     body: RectGetter(
        //         key: rectGetterKey,
        //         child: InkWell(
        //           child: Container(
        //             height: height,
        //             width: width,
        //             decoration: BoxDecoration(
        //                 image: DecorationImage(
        //                     image: AssetImage(splash_screen_image),
        //                     fit: BoxFit.cover)),
        //             // child: Column(
        //             //   // mainAxisAlignment: MainAxisAlignment.center,
        //             //   children: <Widget>[
        //             //     Container(
        //             //       height: height / 9,
        //             //     ),
        //             //     Image.asset(
        //             //       splashScreenLogo,
        //             //       // height: height / 3.5,
        //             //       width: width / 1.3,
        //             //     ),
        //             //     Container(
        //             //       height: height * .04,
        //             //     ),
        //             //     Text(
        //             //       'YOUR REAL SOLUTION FOR LIFE',
        //             //       style: GoogleFonts.poppins(
        //             //         fontWeight: FontWeight.w500,
        //             //         color: Colors.black,
        //             //         fontSize: MediaQuery.of(context).size.width * .05,
        //             //       ),
        //             //     ),
        //             //     Container(
        //             //       height: height / 4,
        //             //     ),
        //             //     Padding(
        //             //       padding: EdgeInsets.all(35),
        //             //       child: RectGetter(
        //             //         key: rectGetterKey,
        //             //         child: MaterialButtonClassPage(
        //             //           height: height * .06,
        //             //           radius: BorderRadius.circular(05),
        //             //           buttonName: get_started,
        //             //           onPress: () {
        //             //             _onTap();
        //             //           },
        //             //           color: WidgetColors.secondButton,
        //             //           minwidth: width / 2,
        //             //           fontSize: width * .04,
        //             //         ),
        //             //       ),
        //             //     ),
        //             //     // Container(
        //             //     //   height: height * .02,
        //             //     // ),
        //             //     // Center(
        //             //     //   child: Text(
        //             //     //     'Version 1.0.0',
        //             //     //     style: GoogleFonts.poppins(
        //             //     //       fontWeight: FontWeight.w500,
        //             //     //       color: Colors.black,
        //             //     //       fontSize: MediaQuery.of(context).size.width * .05,
        //             //     //     ),
        //             //     //   ),
        //             //     // ),
        //             //     // Align(
        //             //     //   child: Column(
        //             //     //     children: [
        //             //     //       Container(
        //             //     //         height: height / 8,
        //             //     //       ),
        //             //     //       Image.asset(
        //             //     //         splashScreenLogo,
        //             //     //         // height: height / 3.5,
        //             //     //         width: width / 1.3,
        //             //     //       ),
        //             //     //       Container(
        //             //     //         height: height * .02,
        //             //     //       ),
        //             //     //       Text(
        //             //     //         'YOUR REAL SOLUTION FOR LIFE',
        //             //     //         style: GoogleFonts.poppins(
        //             //     //           fontWeight: FontWeight.w500,
        //             //     //           color: Colors.black,
        //             //     //           fontSize: MediaQuery.of(context).size.width * .05,
        //             //     //         ),
        //             //     //       ),
        //             //     //     ],
        //             //     //     // mainAxisAlignment: MainAxisAlignment.center,
        //             //     //   ),
        //             //     //   alignment: Alignment.center,
        //             //     // ),
        //             //     // Positioned(
        //             //     //   left: 0,
        //             //     //   right: 0,
        //             //     //   bottom: 120,
        //             //     //   child: RectGetter(
        //             //     //     key: rectGetterKey,
        //             //     //     child: MaterialButtonClassPage(
        //             //     //       left: 60,
        //             //     //       right: 60,
        //             //     //       height: height * .06,
        //             //     //       radius: BorderRadius.circular(05),
        //             //     //       buttonName: get_started,
        //             //     //       onPress: () {
        //             //     //         onTap();
        //             //     //       },
        //             //     //       color: WidgetColors.buttonColor,
        //             //     //       minwidth: width / 3.0,
        //             //     //       fontSize: width * .04,
        //             //     //     ),
        //             //     //   ),
        //             //     // ),
        //             //     // Positioned(
        //             //     //     left: 0,
        //             //     //     right: 0,
        //             //     //     bottom: 50,
        //             //     //     child: Center(
        //             //     //       child: Text(
        //             //     //         'Version 1.0.0',
        //             //     //         style: GoogleFonts.poppins(
        //             //     //           fontWeight: FontWeight.w500,
        //             //     //           color: Colors.black,
        //             //     //           fontSize: MediaQuery.of(context).size.width * .05,
        //             //     //         ),
        //             //     //       ),
        //             //     //     )),
        //             //     Container(
        //             //       height: height * .04,
        //             //     ),
        //             //   ],
        //             // ),
        //           ),
        //           onTap: () {
        //             _onTap();
        //           },
        //         ))),
        _ripple(),
      ],
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      top: rect.top,
      bottom: MediaQuery.of(context).size.width - rect.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // color: Colors.grey.shade400,
          gradient: LinearGradient(colors: [
            Colors.grey.shade400,
            Colors.grey,
            Colors.grey.shade600,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}
