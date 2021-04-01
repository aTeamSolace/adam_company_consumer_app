import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/get_location.dart';

import 'package:flutter/material.dart';

import 'constant.dart';

class RouterD {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case pinCodeRoute:
        var mobile_number = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => PinCodeVerificationScreen(
                  mobileP: mobile_number[0].toString(),
                  otp: mobile_number[1].toString(),
                  user_status: mobile_number[2].toString(),
                  user_id: mobile_number[3].toString(),
                ));
      case profileRoute:
        var login_method = settings.arguments as List;
        return MaterialPageRoute(
            builder: (_) => ProfilePage(
                  loginMethod: login_method[0],
                  mobile_number: login_method[1],
                  user_id: login_method[2],
                ));
//      case availabilityRoute:
//        return MaterialPageRoute(builder: (_) => AvailabilityClass());
      case locationRoute:
        return MaterialPageRoute(builder: (_) => GetLocation());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
