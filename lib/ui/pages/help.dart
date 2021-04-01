import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/api_url.dart';
import 'package:adam_company_consumer_app/common/back_function.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'bottom_bar_pages/bottom_bar_page.dart';

// class Help extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _selectionScreen();
//   }
// }
//
// class _selectionScreen extends State<Help> {
//   bool loading;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loading = false;
//     getHelp();
//   }
//
//   var helpData;
//
//   Future getHelp() async {
//     final response = await http.get(help);
//     if (this.mounted) {
//       setState(() {
//         loading = true;
//         helpData = json.decode(response.body);
//       });
//     }
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
//   onWillPop() {
//     return BackFunction.slideLeftNavigator(
//         context,
//         BottomNavBarPage(
//           initialIndex: 3,
//           initialIndexJob: 0,
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return WillPopScope(
//       onWillPop: () {
//         return onWillPop();
//       },
//       child: Scaffold(
//         backgroundColor: Color(0xffE2E2E2),
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Platform.isIOS
//                   ? Icon(
//                       Icons.arrow_back_ios,
//                       color: Colors.white,
//                     )
//                   : Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     ),
//               onPressed: () {
//                 onWillPop();
//               }),
//           iconTheme: IconThemeData(color: Colors.white),
//           backgroundColor: Colors.black,
//           centerTitle: true,
//           title: customText(help_data, 18, Colors.white, FontWeight.w400),
//         ),
//         body: Container(
//             margin: EdgeInsets.only(top: 20),
//             child: loading
//                 ? SingleChildScrollView(
//                     child: Html(
//                       data: """
//                     $helpData
//                     """,
//                     ),
//                   )
//                 : Center(
//                     child: PlatformLoader(
//                       radius: 15,
//                       color: WidgetColors.buttonColor,
//                     ),
//                   )),
//       ),
//     );
//   }
// }

class Help extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<Help> {
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
    // getHelp();
  }

  var helpData;

  // Future getHelp() async {
  //   final response = await http.get(help_api);
  //   if (this.mounted) {
  //     setState(() {
  //       loading = true;
  //       helpData = json.decode(response.body);
  //     });
  //   }
  // }
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'technician@adamcompanies.co.uk',
      queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

  onWillPop() {
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 3,
          initialIndexJob: 0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
          // drawer: DrawerScreen(),
          backgroundColor: WidgetColors.whiteColor,
          appBar: AppBar(
            leading: IconButton(
              icon: Platform.isIOS
                  ? Icon(
                      Icons.arrow_back_ios,
                      color: WidgetColors.blackColor,
                    )
                  : Icon(Icons.arrow_back, color: WidgetColors.blackColor),
              onPressed: () {
                onWillPop();
                // BackFunction.commonNavigator(context, Settings());
              },
            ),
            iconTheme: IconThemeData(color: WidgetColors.blackColor),
            backgroundColor: WidgetColors.themeColor,
            centerTitle: true,
            title: customText(
                "Get Support", 18, WidgetColors.blackColor, FontWeight.w400),
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Container(
                //   height: height * .03,
                // ),
                customText("Support", 18, Colors.white, FontWeight.w400),
                // text("Support",
                //     fontSize: large_title_height_text, fontWeight: FontWeight.w500,textColor: Colors.black),
                Container(
                  height: height * .02,
                ),
                Image.asset(help_1),
                Container(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * .03,
                    ),
                    // InkWell(
                    //   child: Image.asset(help_2),
                    //   onTap: (){
                    //     launch("tel://01617592140");
                    //   },
                    // live:.cid.c591e93b00d620d3
                    // ),
                    InkWell(
                      child: Image.asset(
                        skype,
                        height: 40,
                      ),
                      onTap: () {
                        launch("skype:live:.cid.c591e93b00d620d3");
                        // launch("tel://01617592140");
                      },
                    ),
                    Container(
                      width: width * .07,
                    ),
                    InkWell(
                      child: Image.asset(help_3),
                      onTap: () {
                        launch(_emailLaunchUri.toString());
                      },
                    ),
                    Container(
                      width: width * .03,
                    ),
                    InkWell(
                      child: Image.asset(help_4),
                      onTap: () {
                        launch("https://www.adamcompanies.com/");
                      },
                    ),
                  ],
                ),
                Container(
                  height: height * .09,
                ),
                customText(contact_to_person, 18, WidgetColors.blackColor,
                    FontWeight.w400),
                // text(contact_to_person,
                //     fontSize: medium_height_text, fontWeight: FontWeight.normal,textColor: Colors.blue),
              ],
            ),
          )),
      onWillPop: () {
        return onWillPop();
      },
    );
  }
}
