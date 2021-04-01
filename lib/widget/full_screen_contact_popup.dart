import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:adam_company_consumer_app/ui/pages/get_location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPopup extends ModalRoute<void> {
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
                child: Text(
                  "Cancel Job is in Progress?",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Center(
                child: Text(
                  "Are you sure you want to cancel ",
                  style: GoogleFonts.vollkorn(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17),
                ),
              ),
              Container(
                height: 1,
              ),
              Center(
                child: Text(
                  "job in progress",
                  style: GoogleFonts.vollkorn(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 17),
                ),
              ),
              Container(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                ),
                child: MaterialButtonClassPage(
                  height: MediaQuery.of(context).size.height * .06,
                  radius: BorderRadius.circular(05),
                  buttonName: "Yes, Cancel",
                  onPress: () {
                    BackFunction.scaleNavigator(
                        context,
                        BottomNavBarPage(
                          initialIndex: 0,
                          initialIndexJob: 0,
                        ));
                  },
                  color: WidgetColors.buttonColor,
                  minwidth: MediaQuery.of(context).size.width / 2,
                  fontSize: 14,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .02,
              ),
              InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(05),
                        border: Border.all(color: WidgetColors.buttonColor)),
                    child: Center(
                      child: Center(
                        child: Text(
                          "Do Not Cancel",
                          style: GoogleFonts.vollkorn(
                              color: WidgetColors.buttonColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
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
