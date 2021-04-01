import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/api_url.dart';
import 'package:adam_company_consumer_app/common/back_function.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'bottom_bar_pages/bottom_bar_page.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<AboutUs> {
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
    getHelp();
    getData();
  }

  var helpData;

  Future getHelp() async {
    final response = await http.get("http://socialenginespecialist.com/PuneDC/adamcompanies/api/auth/aboutus");
    // print("=======>>${response.body}");
    if (this.mounted) {
      setState(() {
        // loading = true;
        var helpDataResult = json.decode(response.body);
        helpData = helpDataResult['data'];
      });
    }
  }



  var data;

  getData() async {
    data = await getFileData("assets/data2.txt");
    // print("===========>>${data}");
    loading = true;
    setState(() {});
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  // Widget customText(
  //     var title, double height, Color color, FontWeight fontWeight) {
  //   return Text(
  //     title.toString(),
  //     style: GoogleFonts.montserrat(
  //       fontSize: height,
  //       color: color,
  //       fontWeight: fontWeight,
  //     ),
  //   );
  // }

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
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        return onWillPop();
      },
      child: Scaffold(
        backgroundColor: WidgetColors.whiteColor,
        appBar: AppBar(
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
                onWillPop();
              }),
          iconTheme: IconThemeData(color: WidgetColors.blackColor),
          backgroundColor: WidgetColors.themeColor,
          centerTitle: true,
          title: customText(abt_adam_cmy, 18, WidgetColors.blackColor, FontWeight.w400),
        ),
        body: Container(
            child: loading
                ? SingleChildScrollView(
              child: Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10),child: customText(
                  data, 16, WidgetColors.blackColor, FontWeight.w400),)
              // text(data,
              //     fontSize: medium_height_text,
              //     fontWeight: FontWeight.normal,
              //     textColor: WidgetColors.blackColor,
              //     maxLine: 1000),
            )
                : Center(
              child: PlatformLoader(
                radius: 15,
                color: WidgetColors.buttonColor,
              ),
            ))
        // Container(
        //     margin: EdgeInsets.only(top: 20),
        //     child: loading
        //         ? SingleChildScrollView(
        //       child: Html(
        //         data: """
        //             $helpData
        //             """,
        //       ),
        //     )
        //         : Center(
        //       child: PlatformLoader(
        //         radius: 15,
        //         color: WidgetColors.buttonColor,
        //       ),
        //     )),
      ),
    );
  }
}
