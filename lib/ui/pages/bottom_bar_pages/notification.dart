import 'dart:convert';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/get_notification_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<NotificationClass> {
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

  var getNotification;
  var user_id;

  @override
  initState() {
    super.initState();
    checkSessionValue();
  }

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    getNotification = getNotificationApiCall(user_id);
  }

  Future getNotificationApiCall(var user_id) async {
    final response = await http
        .post(get_notification, body: {"user_id": user_id.toString()});
    if (response.statusCode == 200) {
      List<GetNotificationResult> getotificationResult;
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          // print("Get Notification: ${responseJson}");
          getotificationResult =
              GetNotificationModel.fromJson(responseJson).data;
        });
      }
      return getotificationResult;
    } else {
      throw Exception('Failed to load notification');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: WidgetColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: WidgetColors.themeColor,
        centerTitle: true,
        title: customText(notification_data, 18, WidgetColors.blackColor, FontWeight.w400),
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: getNotification,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return Container(
                child: PlatformScrollbar(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Card(
                            elevation: 8,
                            child: ListTile(
                              leading:
                                  Image.asset("assets/notification_icon.png"),
                              title: Text(
                                snapshot.data[index].notificationType
                                    .toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.black),
                              ),
                              subtitle: Text(
                                snapshot.data[index].notification.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ),
                          ));
                    },
                  ),
                ),
              );
            } else {
              return Center(
                child: customText(
                    no_notification_yet, 18, Colors.black, FontWeight.w500),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.hasError.toString()),
            );
          }
          return Center(
            child: PlatformLoader(
              color: WidgetColors.buttonColor,
              radius: 15,
            ),
          );
        },
      )),
    );
  }
}
