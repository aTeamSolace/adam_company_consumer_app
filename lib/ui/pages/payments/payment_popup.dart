import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/bottom_bar_page.dart';
import 'package:adam_company_consumer_app/ui/pages/get_location.dart';
import 'package:adam_company_consumer_app/ui/pages/job_in_progress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPopup extends ModalRoute<void> {
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
                child: Image.asset(like),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Center(
                  child: Padding(
                padding: EdgeInsets.only(left: 0, right: 0),
                child: Text(
                  payment_success,
                  style: GoogleFonts.poppins(
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
                  buttonName: goto_details,
                  onPress: () {
                    Navigator.pop(context);
                    BackFunction.commonNavigator(
                        context,
                        BottomNavBarPage(
                          initialIndex: 0,
                          initialIndexJob: 0,
                        ));
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
