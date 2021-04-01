import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Rewards extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<Rewards> {
  var application_url;

  @override
  initState() {
    appSetUrl();
    super.initState();
  }

  appSetUrl() {
    if (Platform.isAndroid) {
      setState(() {
        application_url =
            "https://play.google.com/store/apps/details?id=com.worshapp.events&hl=en_IN";
      });
    } else {
      setState(() {
        application_url = "https://apps.apple.com/us/app/worshapp/id1499607116";
      });
    }
  }

  // Widget customText(
  //   var title,
  //   double height,
  //   Color color,
  //   FontWeight fontWeight,
  // ) {
  //   return Text(
  //     title,
  //     style: GoogleFonts.montserrat(
  //       fontSize: height,
  //       color: color,
  //       fontWeight: fontWeight,
  //     ),
  //   );
  // }

  launchUrl() async {
    if (await canLaunch(application_url)) {
      await launch(application_url);
    } else {
      throw 'Could not launch $application_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WidgetColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: customText(refer_and_earn, 18, Colors.white, FontWeight.w400),
      ),
      body: SafeArea(
          child: Container(
              width: width,
              // color: WidgetColors.bgColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 8,
                      child: Container(
                        width: width,
                        height: height / 3.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ListTile(
                            //   title: customText("Refer and get FREE service",
                            //       18, WidgetColors.blackColor, FontWeight.bold),
                            // ),
                            ListTile(
                              title: customText(
                                  invite_frinds,
                                  // "They get instant \$12 off. You win upto \$200 in rewards",
                                  18,
                                  WidgetColors.lightTextColor,
                                  FontWeight.w500),
                              trailing: Image.asset(
                                reward_gift,
                                height: 50,
                              ),
                            ),
                            Container(
                              height: height * 0.03,
                            ),
                            Center(
                              child: customText(refer_via, 16,
                                  WidgetColors.lightTextColor, FontWeight.w500),
                            ),
                            Container(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  child: Image.asset(
                                    reward_whtsap,
                                    height: height * 0.09,
                                  ),
                                  onTap: () {
                                    // Share.share(
                                    //     'Check out my application $application_url');
                                  },
                                ),
                                InkWell(
                                  child: Image.asset(
                                    reward_fb,
                                    height: height * 0.09,
                                  ),
                                  onTap: () {
                                    // Share.share(
                                    //     'Check out my application $application_url');
                                  },
                                ),
                                InkWell(
                                  child: Image.asset(
                                    reward_more,
                                    height: height * 0.09,
                                  ),
                                  onTap: () {
                                    // Share.share(
                                    //     'Check out my application $application_url');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: WidgetColors.rewardScreenBg,
                    ),
                    Container(
                      height: height * 0.02,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          ListTile(
                            title: customText(
                                rate_us,
                                // "They get instant \$12 off. You win upto \$200 in rewards",
                                18,
                                WidgetColors.lightTextColor,
                                FontWeight.w500),
                            trailing: Icon(
                              Icons.star,
                              color: WidgetColors.rewardScreenBg,
                              size: 50,
                            ),
                          ),

                          Visibility(
                            visible: true,
                            child: Image.asset(
                              reward_rate_us,
                              height: 150,
                            ),
                          ),
                          MaterialButtonClassPage(
                              color: WidgetColors.buttonColor,
                              radius: BorderRadius.circular(0),
                              buttonName: rate_us_btn,
                              onPress: () {
                                // launchUrl();
                              },
                              fontSize: 14)

                          // ListTile(
                          //   title: customText(
                          //       "Refer everyone-the most generous referral program",
                          //       18,
                          //       WidgetColors.blackColor,
                          //       FontWeight.bold),
                          // ),
                          // Container(
                          //   height: height * 0.01,
                          // ),
                          // ListTile(
                          //   title: customText(
                          //       "Invite all friends even if they have tried us. You will get rewarded everytime",
                          //       14,
                          //       WidgetColors.lightTextColor,
                          //       FontWeight.w500),
                          //   leading: Image.asset(reward_one),
                          // ),
                          // Container(
                          //   height: height * 0.01,
                          // ),
                          // ListTile(
                          //   title: customText(
                          //       "Upon inviting , we'll give them rewards for the services they haven't tried yet",
                          //       14,
                          //       WidgetColors.lightTextColor,
                          //       FontWeight.w500),
                          //   leading: Image.asset(reward_two),
                          // ),
                          // Container(
                          //   height: height * 0.01,
                          // ),
                          // ListTile(
                          //   title: customText(
                          //       "For every successful signup, you can win upto \$100 , and Minimun \$10",
                          //       14,
                          //       WidgetColors.lightTextColor,
                          //       FontWeight.w500),
                          //   leading: Image.asset(reward_three),
                          // ),
                          // Container(
                          //   height: height * 0.03,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 25, right: 15),
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //         child: Padding(
                          //             padding:
                          //                 EdgeInsets.only(left: 0, right: 0),
                          //             child: Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.circle,
                          //                   color: WidgetColors.buttonColor,
                          //                   size: 10,
                          //                 ),
                          //                 Container(
                          //                   width: 10,
                          //                 ),
                          //                 customText(
                          //                     "Terms and condition",
                          //                     14,
                          //                     WidgetColors.buttonColor,
                          //                     FontWeight.w500)
                          //               ],
                          //             )),
                          //       ),
                          //       Padding(
                          //           padding:
                          //               EdgeInsets.only(left: 0, right: 70),
                          //           child: Row(
                          //             children: [
                          //               Icon(
                          //                 Icons.circle,
                          //                 color: WidgetColors.buttonColor,
                          //                 size: 10,
                          //               ),
                          //               Container(
                          //                 width: 10,
                          //               ),
                          //               customText(
                          //                   "FAQs",
                          //                   14,
                          //                   WidgetColors.buttonColor,
                          //                   FontWeight.w500)
                          //             ],
                          //           )),
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   height: height * 0.03,
                          // ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: height * 0.02,
                    // ),
                    // Container(
                    //   color: Colors.white,
                    //   child: Column(
                    //     children: [
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: ListTile(
                    //     title: customText(
                    //         "You are yet to earn and scratch card",
                    //         16,
                    //         Colors.black,
                    //         FontWeight.bold),
                    //     subtitle: customText(
                    //         "Start referring to get surprises",
                    //         14,
                    //         Colors.black,
                    //         FontWeight.normal),
                    //   ),
                    // ),
                    // Center(
                    //   child: Text(
                    //       "---------------------------------------------------"),
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10, right: 10),
                    //   child: ListTile(
                    //     title: customText(
                    //         "Earn Min. \$100 off on every scratch card",
                    //         14,
                    //         Colors.black,
                    //         FontWeight.normal),
                    //     leading: Image.asset(reward_gift_box),
                    //   ),
                    // ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   height: 60,
                    // )
                  ],
                ),
              ))),
    );
  }
}
