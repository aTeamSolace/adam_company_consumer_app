import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialButtonClassPage extends StatelessWidget {
  double minwidth;
  Function onPress;
  var buttonName;
  Color color;
  BorderRadiusGeometry radius;
  double height;
  double fontSize;

  MaterialButtonClassPage(
      {@required this.buttonName,
      this.minwidth,
      @required this.onPress,
      this.color,
      this.radius,
      this.height,
      @required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
          height: height,
          minWidth: minwidth,
          onPressed: () {
            onPress();
          },
          color: WidgetColors.themeColor,
          //color,
          splashColor: WidgetColors.whiteColor,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: radius),
          child: Text(
            buttonName,
            style: GoogleFonts.poppins(
                color: WidgetColors.blackColor, fontSize: fontSize),
          ),
        ));
    // TODO: implement build
    // if (Platform.isAndroid) {
    //
    // } else {
    //   return Center(
    //       child: SizedBox(
    //     child: CupertinoButton(
    //         onPressed: () {
    //           onPress();
    //         },
    //         color: color,
    //         borderRadius: radius,
    //         child: Center(
    //           child: Text(
    //             buttonName,
    //             textAlign: TextAlign.center,
    //             style: GoogleFonts.poppins(
    //                 color: Colors.white, fontSize: fontSize),
    //           ),
    //         )),
    //     width: minwidth,
    //     height: height,
    //   ));
    // }
  }
}
