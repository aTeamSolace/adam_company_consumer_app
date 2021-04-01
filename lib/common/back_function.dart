import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackFunction {
  static exitThApp() {
    return SystemNavigator.pop();
  }

  static commonNavigator(BuildContext context, Widget child) {
    if (Platform.isIOS) {
      return Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => child));
    } else {
      return Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => child));
    }
  }

  static fadeNavigation(BuildContext context, Widget child) {
    return Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static fadeNavigationWithPush(BuildContext context, Widget child) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return child;
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return Align(
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  static sizeNavigator(BuildContext context, Widget child) {
    return Navigator.pushReplacement(context, SizeRoute(page: child));
  }

  static scaleNavigator(BuildContext context, Widget child) {
    return Navigator.pushReplacement(context, ScaleRoute(page: child));
  }

  static slideRightNavigator(BuildContext context, Widget child) {
    return Navigator.pushReplacement(context, SlideRightRoute(page: child));
  }

  static slideLeftNavigator(BuildContext context, Widget child) {
    return Navigator.pushReplacement(context, SlideLeftRoute(page: child));
  }

  static threeDNavigator(
      BuildContext context, Widget enterPage, Widget exitPage) {
    return Navigator.pushReplacement(
        context, Pseudo3dRouteBuilder(enterPage, exitPage));
  }
}

class SizeRoute extends PageRouteBuilder {
  final Widget page;

  SizeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          ),
        );
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.fastOutSlowIn,
              ),
            ),
            child: child,
          ),
        );
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget page;

  SlideLeftRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class Pseudo3dRouteBuilder extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;

  Pseudo3dRouteBuilder(this.exitPage, this.enterPage)
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => enterPage,
          transitionsBuilder: _transitionsBuilder(exitPage, enterPage),
        );

  static _transitionsBuilder(exitPage, enterPage) =>
      (context, animation, secondaryAnimation, child) {
        return Stack(
          children: <Widget>[
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: Offset(-1.0, 0.0),
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateY(pi / 2 * animation.value),
                  alignment: FractionalOffset.centerRight,
                  child: exitPage,
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: Container(
                color: Colors.white,
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.003)
                    ..rotateY(pi / 2 * (animation.value - 1)),
                  alignment: FractionalOffset.centerLeft,
                  child: enterPage,
                ),
              ),
            )
          ],
        );
      };
}
