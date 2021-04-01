import 'dart:convert';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/about_us.dart';
import 'package:adam_company_consumer_app/ui/pages/contact_us.dart';
import 'package:adam_company_consumer_app/ui/pages/forms/update_profile.dart';
import 'package:adam_company_consumer_app/ui/pages/help.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/add_credit_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<Account> {
  bool sms;
  bool push;
  bool loading;
  bool notificationLoading;

  @override
  initState() {
    sms = false;
    loading = true;
    notificationLoading = false;
    setState(() {
      checkSessionValue();
    });
    super.initState();
  }

  var user_id;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    // print("user_id:$user_id");
    getConsumerProfile(user_id.toString());
    getNotificationStatus(user_id.toString());
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

  var profileData = [];

  Future getConsumerProfile(var user_id) async {
    final response = await http
        .post(get_consumer_profile, body: {"consumer_id": user_id.toString()});
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          // print("getConsumerProfile:${responseJson}");
          // print("Consumer userid responce:${user_id.toString()}");
          profileData = responseJson['data'];
          loading = false;
        });
      }
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  Future addNotificationStatus(var data) async {
    final response = await http.post(add_notificatio, body: {
      "userid": user_id.toString(),
      "flag": data.toString(),
      "role": "customer"
    });
    // print("account add notification status:${response.body}");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          if (responseJson['status'] == 200) {
            getNotificationStatus(user_id.toString());
          }
          loading = false;
        });
      }
    } else {
      throw Exception('Failed to load profile data');
    }
  }

  Future getNotificationStatus(var userid) async {
    // print("getNotificationStatus userid:${userid}");
    final response = await http.post(
      get_notificatio,
      body: {
        "user_id": userid.toString(),
        "role": "customer"
      }, //userid.toString()
    );
    // print("getNotificationStatus responce:${response.body}");
    // print("account responce:${response.statusCode}");
    // print("account responce:${response.body}");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          var notificationStatus = responseJson['data'];
          if (notificationStatus[0]['pushNotificationFlag'] == 0 ||
              notificationStatus[0]['pushNotificationFlag'] == "0") {
            push = false;
          } else {
            push = true;
          }
          notificationLoading = true;
          // print(
          //     "account responce:${notificationStatus[0]['pushNotificationFlag']}");
        });
      }
    } else {
      throw Exception('Failed to load get notification Status');
    }
  }

  final facebookLogin = FacebookLogin();
  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  Future signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    SharedPreferences setLocation = await SharedPreferences.getInstance();
    setLocation.setString("fullAddress", "null");

    await facebookLogin.logOut();
    await googleSignIn.signOut();
  }

  signoutPopUp(context) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.grow,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: GoogleFonts.poppins(
          color: Colors.red.shade800,
        ),
        constraints: BoxConstraints.expand(width: 300));

    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.error,
      title: "Sign Out",
      desc: "Really want to sign out from application ?",
      buttons: [
        DialogButton(
          child: Text(
            "Ok",
            style: GoogleFonts.poppins(
                color: WidgetColors.blackColor, fontSize: 20),
          ),
          onPressed: () {
            signout().then((onValue) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  ModalRoute.withName('/'));
            });
          },
          color: WidgetColors.themeColor,
          radius: BorderRadius.circular(0.0),
        ),
        DialogButton(
          child: Text(
            "Cancel",
            style: GoogleFonts.poppins(
                color: WidgetColors.blackColor, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          color: WidgetColors.themeColor,
          radius: BorderRadius.circular(0.0),
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WidgetColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: WidgetColors.themeColor, // Color(0xfff2f3f7),
        centerTitle: true,
        title: customText(profile, 18, Colors.black, FontWeight.w500),
      ),
      body: SafeArea(
          child: PlatformScrollbar(
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: height * .04,
                ),
                Container(
                  child: loading
                      ? Center(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[500],
                            highlightColor: Colors.grey[100],
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 45,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white)),
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15.0),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 8.0,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: profileData.length > 0
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          "$technician_profile_img/${profileData[0]['customer_profile_pic']}"),
                                      radius: 45,
                                      child: Container(
                                        // child: Center(
                                        //   child: customText("loading..", 12,
                                        //       Colors.black, FontWeight.normal),
                                        // ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.black)),
                                      ),
                                    ),

                                    Container(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                  profileData[0]['name'],
                                                  width * .04,
                                                  Colors.black,
                                                  FontWeight.w500),
                                              IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () {
                                                    BackFunction
                                                        .fadeNavigationWithPush(
                                                            context,
                                                            UpdateProfile(
                                                              user_id:
                                                                  profileData[0]
                                                                      [
                                                                      'user_id'],
                                                              name:
                                                                  profileData[0]
                                                                      ['name'],
                                                              email:
                                                                  profileData[0]
                                                                      ['email'],
                                                              mobile: profileData[
                                                                          0]
                                                                      ['mobile']
                                                                  .toString(),
                                                              state:
                                                                  profileData[0]
                                                                      ['state'],
                                                              city:
                                                                  profileData[0]
                                                                      ['city'],
                                                              zip: profileData[
                                                                  0]['zipcode'],
                                                              photoURL:
                                                                  profileData[0]
                                                                      [
                                                                      'customer_profile_pic'],
                                                              country:
                                                                  profileData[0]
                                                                      [
                                                                      'country'],
                                                              address:
                                                                  profileData[0]
                                                                      [
                                                                      'address'],
                                                            ));
                                                  })
                                            ],
                                          ),
                                          customText(
                                              profileData[0]['mobile']
                                                  .toString(),
                                              width * .04,
                                              Colors.black,
                                              FontWeight.w400),
                                        ],
                                      ),
                                    )
                                    // Container(
                                    //   child:
                                    //   margin: EdgeInsets.only(left: 5),
                                    // )
                                  ],
                                )
                              : Container(),
                        ),
                ),
                Container(
                  height: height * .01,
                ),
                Container(
                    child: loading
                        ? AbsorbPointer(
                            child: ListTile(
                              leading: Icon(Icons.account_circle),
                              title: customText(mng_and_change, width * .04,
                                  Colors.black, FontWeight.w400),
                              onTap: () {},
                              trailing: Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18,
                              ),
                            ),
                            absorbing: true,
                          )
                        : Container(
                            child: profileData.length == 0
                                ? Container()
                                : ListTile(
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 18,
                                    ),
                                    leading: Icon(Icons.account_circle),
                                    title: customText(
                                        mng_and_change,
                                        width * .04,
                                        Colors.black,
                                        FontWeight.w400),
                                    onTap: () {
                                      BackFunction.fadeNavigationWithPush(
                                          context,
                                          UpdateProfile(
                                            user_id: profileData[0]['user_id'],
                                            name: profileData[0]['name'],
                                            email: profileData[0]['email'],
                                            mobile: profileData[0]['mobile']
                                                .toString(),
                                            state: profileData[0]['state'],
                                            city: profileData[0]['city'],
                                            zip: profileData[0]['zipcode'],
                                            photoURL: profileData[0]
                                                ['customer_profile_pic'],
                                            country: profileData[0]['country'],
                                            address: profileData[0]['address'],
                                          ));
                                    },
                                  ),
                          )),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 18,
                  ),
                  leading: Icon(Icons.payment),
                  title: customText(
                      "Payment", width * .04, Colors.black, FontWeight.w400),
                  onTap: () {
                    BackFunction.commonNavigator(context, PaymentInfoScreen());
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 18,
                  ),
                  leading: Image.asset(
                    "assets/help_icon_data.png",
                    height: 25,
                  ),
                  //Icon(Icons.help),
                  title: customText(
                      get_support, width * .04, Colors.black, FontWeight.w400),
                  onTap: () {
                    BackFunction.commonNavigator(context, Help());
                  },
                ),
                ListTile(
                  trailing: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 18,
                  ),
                  leading: Icon(Icons.info),
                  title: customText(
                      abt_adam_cmy, width * .04, Colors.black, FontWeight.w400),
                  onTap: () {
                    BackFunction.commonNavigator(context, AboutUs());
                  },
                ),
                MergeSemantics(
                    child: notificationLoading
                        ? ListTile(
                            leading: Icon(
                              Icons.notifications,
                              // color: WidgetColors.bgColor
                            ),
                            title: customText(notificaion_push, width * .04,
                                Colors.black, FontWeight.w400),
                            trailing: Platform.isIOS
                                ? CupertinoSwitch(
                                    activeColor: WidgetColors.themeColor,
                                    value: push,
                                    onChanged: (bool value) {
                                      setState(() {
                                        // print("switchValue:${value}");
                                        if (value == false) {
                                          addNotificationStatus("0");
                                        } else {
                                          addNotificationStatus("1");
                                        }
                                        push = value;
                                      });
                                    },
                                  )
                                : Switch(
                                    activeColor: WidgetColors.themeColor,
                                    value: push,
                                    onChanged: (bool value) {
                                      setState(() {
                                        if (value == false) {
                                          addNotificationStatus("0");
                                        } else {
                                          addNotificationStatus("1");
                                        }
                                        // print("switchValue:${value}");
                                        push = value;
                                      });
                                    },
                                  ),
                          )
                        : ListTile(
                            leading: Icon(
                              Icons.notifications,
                              // color: WidgetColors.bgColor
                            ),
                            title: customText(notificaion_push, 13,
                                Colors.black, FontWeight.w400),
                            trailing: Platform.isIOS
                                ? CupertinoSwitch(
                                    activeColor: WidgetColors.bgColor,
                                    value: sms,
                                    onChanged: (bool value) {
                                      setState(() {
                                        sms = value;
                                      });
                                    },
                                  )
                                : Switch(
                                    activeColor: WidgetColors.bgColor,
                                    value: sms,
                                    onChanged: (bool value) {
                                      setState(() {
                                        sms = value;
                                      });
                                    },
                                  ),
                          )),
                // ListTile(
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_sharp,
                //     size: 18,
                //   ),
                //   leading: Icon(Icons.rate_review_outlined),
                //   title: customText("Rate This App", width * .04, Colors.black,
                //       FontWeight.w400),
                //   onTap: () {
                //     // signoutPopUp(context);
                //   },
                // ),
                // ListTile(
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_sharp,
                //     size: 18,
                //   ),
                //   leading: Icon(Icons.share),
                //   title: customText("Share This App", width * .04, Colors.black,
                //       FontWeight.w400),
                //   onTap: () {
                //     // signoutPopUp(context);
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: customText(
                      logout_data, width * .04, Colors.black, FontWeight.w400),
                  onTap: () {
                    signoutPopUp(context);
                  },
                ),
                // Divider(
                //   color: Colors.black45,
                // ),
                Container(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
