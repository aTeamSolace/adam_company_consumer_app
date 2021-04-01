import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:adam_company_consumer_app/ui/pages/get_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenPopup extends ModalRoute<void> {
  var text_line;
  var text_line_second;
  var from_page;

  HomeScreenPopup(
      {@required this.text_line,
      @required this.text_line_second,
      @required this.from_page});

  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => false;

  @override
  // TODO: implement barrierLabel
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
//      color: Colors.white,
      child: Center(
          child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Center(
                child: Image.asset(pop_up),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Text(
                  text_line,
                  style: GoogleFonts.vollkorn(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              )),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Text(
                  text_line_second,
                  style: GoogleFonts.vollkorn(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              )),
              Container(
                height: 5,
              ),
              Container(
                child: MaterialButtonClassPage(
                  height: 40,
                  radius: BorderRadius.circular(05),
                  buttonName: "Ok",
                  onPress: () {
                    Navigator.pop(context);
                    if (from_page == "profile_page") {
                      BackFunction.sizeNavigator(context, GetLocation());
                    } else {
                      BackFunction.scaleNavigator(
                          context,
                          BottomNavBarPage(
                            initialIndex: 1,
                            initialIndexJob: 0,
                          ));
                    }
                  },
                  color: WidgetColors.buttonColor,
                  minwidth: 60,
                  fontSize: 14,
                ),
              ),
              Container(
                height: 10,
              ),
            ],
          ),
        ),
      )),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }

  @override
  // TODO: implement maintainState
  bool get maintainState => true;

  @override
  // TODO: implement opaque
  bool get opaque => false;

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => Duration(milliseconds: 500);
}
