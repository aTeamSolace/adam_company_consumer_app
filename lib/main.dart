import 'dart:io';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/api_provider/api_provider.dart';
import 'package:adam_company_consumer_app/network/api_provider/insert_data_api_provider.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


void main() {
  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(),
  //   ),
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GetApiDataProvider()),
        ChangeNotifierProvider.value(value: AddDataApiProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Adam Company Technician App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // locale: DevicePreview.of(context).locale,
        // builder: DevicePreview.appBuilder,
        home: Container(color: Colors.white, child: JumpPage()),
      ),
    );
  }
}

class JumpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<JumpPage> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    firebaseConfigureMethod();
    super.initState();
  }

  firebaseConfigureMethod() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false));

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        // print("onMessage foreground: $message");
        // Navigator.of(context)
        //     .overlay
        //     .insert(OverlayEntry(builder: (BuildContext context) {
        //   return FunkyNotification();
        // }));
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.only(left: 20.0, top: 30.0),
            actionsPadding: EdgeInsets.all(0.0),
            content: Container(
              height: 60.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['notification']['title'],
                    style: GoogleFonts.montserrat(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    message['notification']['body'],
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {
        // print("onMessage backgrond: $message");
        var data = message['data'];
        if (data['page'].toString() == "ongoing") {
          gotoOngoingPage();
        } else if (data['page'].toString() == "rejected") {
          gotoRejectedPage();
        } else if (data['page'].toString() == "completed") {
          gotoCompletedPage();
        } else if (data['page'].toString() == "requested") {
          gotoRequestedPage();
        } else if (data['page'].toString() == "payment_option") {
          gotoPaymentScreenPage(data['job_id'], data['technician_id']);
        }
      },
    );
  }

  gotoOngoingPage() {
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 1,
        ));
  }

  gotoRequestedPage() {
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 0,
        ));
  }

  gotoCompletedPage() {
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 2,
        ));
  }

  gotoRejectedPage() {
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 3,
        ));
  }

  gotoPaymentScreenPage(var serviceId, var techId) {
    BackFunction.commonNavigator(
        context,
        PaymentScreen(
          serviceId: serviceId.toString(),
          technician_id: techId.toString(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SplashScreen();
  }
}

class FunkyNotification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyNotificationState();
}

class FunkyNotificationState extends State<FunkyNotification>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> position;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    position = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut));

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: SlideTransition(
              position: position,
              child: Container(
                decoration: ShapeDecoration(
                    color: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0))),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'Notification!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Meeeeeee extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Meeeeeee> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Color Change CircularProgressIndicator"),
      ),
      body: Center(
        child: CircularProgressIndicator(
          valueColor: animationController
              .drive(ColorTween(begin: Colors.blueAccent, end: Colors.red)),
        ),
      ),
    );
  }
}
