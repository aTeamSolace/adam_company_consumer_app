import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BottomNavBarPage extends StatefulWidget {
  int initialIndex;
  int initialIndexJob;
  var location;

  BottomNavBarPage(
      {@required this.initialIndex, this.location, this.initialIndexJob});

  @override
  _BottomNavBarPageState createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  PersistentTabController _controller;
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
//    print("==================location:${widget.location}");
    pageController = PageController(
      initialPage: widget.initialIndex,
      keepPage: true,
    );
    firebaseConfigureMethod();
    super.initState();
//    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  firebaseConfigureMethod() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: ${message}");
        print("onMessage: ${message['data']}");
        var data = message['data'];
        print("onMessage: ${data['screen']}");
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                contentPadding: EdgeInsets.only(left: 20.0, top: 30.0),
                actionsPadding: EdgeInsets.all(0.0),
                content: Container(
                  height: 60.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message['notification']['title']),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        message['notification']['body'],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
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
      onLaunch: (Map<String, dynamic> message) async {
        // print("onLaunch: ${message}");
        // var data = message['data'];
        // if (data['screen'].toString() == "OPEN_PAGE1") {
        //   gotoNotificationPage();
        // }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: ${message}");
        var data = message['data'];
        if (data['screen'].toString() == "OPEN_PAGE1") {
          gotoNotificationPage();
        }
      },
    );
  }

  gotoNotificationPage() {
    BackFunction.commonNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 0,
        ));
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            home,
            style: GoogleFonts.poppins(),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.assignment_outlined),
          title: Text(
            my_job,
            style: GoogleFonts.poppins(),
          )),
      BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none),
          title: Text(
            notification_data,
            style: GoogleFonts.poppins(),
          )),
      // BottomNavigationBarItem(
      //     icon: Icon(Icons.card_giftcard_sharp),
      //     title: Text(
      //       reward,
      //       style: GoogleFonts.poppins(),
      //     )),
      BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text(
            account_data,
            style: GoogleFonts.poppins(),
          )),
    ];
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (context) =>
            PlatformAlertBox(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App?'),
              list: [
                PlatformActionButton(
                  title: 'No',
                  onPress: () => Navigator.of(context).pop(false),
                  boolValue: false,
                ),
                PlatformActionButton(
                  title: 'Yes',
                  onPress: () => Navigator.of(context).pop(true),
                  boolValue: true,
                )
              ],
            ))) ??
        false;
  }

  void bottomTapped(int index) {
    setState(() {
      widget.initialIndex = index;
      pageController.animateToPage(widget.initialIndex,
          duration: Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  PageController pageController;

  final GlobalKey<FormFieldState<String>> orderFormKey = GlobalKey();

  void pageChanged(int index) {
    setState(() {
      widget.initialIndex = index;
    });
  }

  Widget buildPageView() {
    return PageView(
      key: orderFormKey,
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        MainPage(
          location: widget.location.toString(),
        ),
        MyJob(
          initialIndex: widget.initialIndexJob,
        ),
        NotificationClass(),
        // Rewards(),
        Account()
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  internateConnect(context) {
    var alertStyle = AlertStyle(
        animationType: AnimationType.shrink,
        isCloseButton: false,
        isOverlayTapDismiss: false,
        descStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        animationDuration: Duration(milliseconds: 400),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
        titleStyle: GoogleFonts.poppins(
          color: Colors.red,
        ),
        constraints: BoxConstraints.expand(width: 300));
    Alert(
      context: context,
      style: alertStyle,
      type: AlertType.info,
      title: "Oops..! ",
      desc: "Check Internet Connection",
      buttons: [
        DialogButton(
          child: Text(
            "Retry",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen())),
          color: Color.fromRGBO(0, 179, 134, 1.0),
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected}");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected}");
      return true;
    }
    print("not Connected}");
    return internateConnect(context);
  }

  bool isCollapsed = true;

  backPressed() {
    if (isCollapsed) {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              backgroundColor: Colors.white,
              actionsPadding: EdgeInsets.symmetric(horizontal: 12.0),
              title: Text(
                'Are you sure you want to close this App?',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              actions: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text('Exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      print("Return True");
                      return true;
                    }),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text('Dismiss'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      print("Return False");
                      return false;
                    }),
              ],
            ),
      );
    } else {
      RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Text('Dismiss'),
          onPressed: () {
            Navigator.of(context).pop(false);
            print("Return False");
            return false;
          });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // check();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return WillPopScope(
      child: Scaffold(
        // appBar: AppBar(),
        // drawer: Container(color: Colors.black,),
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            children: [
              buildPageView(),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.yellow.shade600,
                        type: BottomNavigationBarType.fixed,
                        showUnselectedLabels: true,
                        elevation: 0,
                        selectedItemColor: WidgetColors.blackColor,
                        unselectedItemColor: Colors.grey,
                        unselectedFontSize: 12,
                        selectedIconTheme: IconThemeData(
                            color: WidgetColors.blackColor, size: 25),
                        unselectedIconTheme:
                        IconThemeData(color: Colors.grey, size: 20),
                        currentIndex: widget.initialIndex,
                        onTap: (index) {
                          bottomTapped(index);
                        },
                        items: buildBottomNavBarItems(),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
      onWillPop: () {
        // return backPressed();
      },
    );
  }
}

//  List<Widget> _buildScreens(PersistentTabController controller) {
//    return [
//      MainPage(
//        persistentTabController: _controller,
//      ),
//      MyJob(
//        initialIndex: widget.initialIndexJob,
//      ),
//      NotificationClass(),
//      Rewards(),
//      Account()
//    ];
//  }

//  List<PersistentBottomNavBarItem> _navBarsItems() {
//    return [
//      PersistentBottomNavBarItem(
//        contentPadding: 0,
//        icon: Icon(Icons.home),
//        title: "Home",
//        activeColor: WidgetColors.buttonColor,
//        inactiveColor: Colors.white,
//      ),
//      PersistentBottomNavBarItem(
//        contentPadding: 0,
//        icon: Icon(Icons.assignment_outlined),
//        title: ("My Job"),
//        activeColor: WidgetColors.buttonColor,
//        inactiveColor: Colors.white,
//      ),
//      PersistentBottomNavBarItem(
//        icon: Icon(Icons.notifications_none),
//        contentPadding: 0,
//        title: ("Notification"),
//        activeColor: WidgetColors.buttonColor,
//        inactiveColor: Colors.white,
//      ),
//      PersistentBottomNavBarItem(
//        icon: Icon(Icons.card_giftcard_sharp),
//        contentPadding: 0,
//        title: ("Reward"),
//        activeColor: WidgetColors.buttonColor,
//        inactiveColor: Colors.white,
//      ),
//      PersistentBottomNavBarItem(
//        icon: Icon(Icons.print),
//        title: ("Account"),
//        contentPadding: 0,
//        activeColor: WidgetColors.buttonColor,
//        inactiveColor: Colors.white,
//      ),
//    ];
//  }

//        pushNewScreen(context, screen: MyJob());
//        widget.persistentTabController.jumpToTab(2);

//    return WillPopScope(
//      child: Scaffold(
//          body: SafeArea(
//              child: Container(
//        child: PersistentTabView(
//          backgroundColor: Colors.black,
//          items: _navBarsItems(),
//          navBarHeight: 60,
//          controller: _controller,
//          screens: _buildScreens(_controller),
////        confineInSafeArea: true,
////        itemCount: 5,
////        backgroundColor: Colors.white,
////        handleAndroidBackButtonPress: true,
//          resizeToAvoidBottomInset: true,
//          stateManagement: false,
//          decoration: NavBarDecoration(
//              colorBehindNavBar: Colors.white,
//              borderRadius: BorderRadius.only(
//                topLeft: Radius.circular(20),
//                topRight: Radius.circular(20),
//              )),
//          popAllScreensOnTapOfSelectedTab: true,
//          itemAnimationProperties: ItemAnimationProperties(
//            duration: Duration(milliseconds: 100),
//            curve: Curves.ease,
//          ),
//          screenTransitionAnimation: ScreenTransitionAnimation(
//            animateTabTransition: true,
//            curve: Curves.ease,
//            duration: Duration(milliseconds: 100),
//          ),
//          customWidget: CustomNavBarWidget(
//            items: _navBarsItems(),
//            onItemSelected: (index) {
//              setState(() {
//                _controller.index = index;
//              });
//            },
//            selectedIndex: _controller.index,
//          ),
//          navBarStyle: NavBarStyle.style14,
//        ),
//      ))),
//      onWillPop: _onWillPop,
//    );
