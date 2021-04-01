import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';

class PlatformScaffold extends PlatformWidget<CupertinoPageScaffold, Scaffold> {
  final Widget child;
  final PreferredSizeWidget preferredSizeWidget;
  final ObstructingPreferredSizeWidget obstructingPreferredSizeWidget;

  PlatformScaffold(
      {this.child,
      this.preferredSizeWidget,
      this.obstructingPreferredSizeWidget});

  @override
  Scaffold createAndroidWidget(BuildContext context) {
    return new Scaffold(
      appBar: preferredSizeWidget,
      body: child,
    );
  }

  @override
  CupertinoPageScaffold createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return new CupertinoPageScaffold(
      navigationBar: obstructingPreferredSizeWidget,
      child: child,
    );
  }
}

class PlatformAppBar extends PlatformWidget<CupertinoNavigationBar, AppBar>
    with PreferredSizeWidget, ObstructingPreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Widget actionChild;

  PlatformAppBar(
      {@required this.title, this.backgroundColor, this.actionChild});

  @override
  AppBar createAndroidWidget(BuildContext context) {
    return new AppBar(
      title: new Text(title),
      backgroundColor: backgroundColor,
      actions: [actionChild],
    );
  }

  @override
  CupertinoNavigationBar createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return new CupertinoNavigationBar(
      middle: new Text(title),
      backgroundColor: backgroundColor,
      trailing: actionChild,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // TODO: implement shouldFullyObstruct
    return true;
  }
}

class PlatformButton extends PlatformWidget<CupertinoButton, MaterialButton> {
  final Color color;
  var title;
  Function onPress;
  double height;
  double width;
  double radius;

  PlatformButton(
      {this.color,
      this.title,
      @required this.onPress,
      this.height,
      this.width,
      this.radius});

  @override
  MaterialButton createAndroidWidget(BuildContext context) {
    // TODO: implement createAndroidWidget
    return MaterialButton(
      onPressed: () {
        onPress();
      },
      child: Text(title),
      color: color,
      height: height,
      minWidth: width,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return CupertinoButton(
      child: Text(title),
      onPressed: () {
        onPress();
      },
      color: color,
    );
  }
}

class PlatformLoader extends PlatformWidget<CupertinoActivityIndicator,
    CircularProgressIndicator> {
  double radius;
  Color color;

  PlatformLoader({@required this.radius, @required this.color});

  @override
  CircularProgressIndicator createAndroidWidget(BuildContext context) {
    // TODO: implement createAndroidWidget
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(WidgetColors.blackColor),
    );
  }

  @override
  CupertinoActivityIndicator createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return new CupertinoActivityIndicator(
      radius: radius,
    );
  }
}

class PlatformAlertBox
    extends PlatformWidget<CupertinoAlertDialog, AlertDialog> {
  Widget title;
  Widget content;
  List<Widget> list;
  double height;

  PlatformAlertBox({@required this.content,@required  this.title,@required this.list, });

  @override
  AlertDialog createAndroidWidget(BuildContext context) {
    return AlertDialog(
      title: title,
      content: Container(
        // height: height,
        child: content,
      ),
      actions: list,
    );
  }

  @override
  CupertinoAlertDialog createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return CupertinoAlertDialog(
      title: title,
      content: Container(
        // height: height,
        child: content,
      ),
      actions: list,
    );
  }
}

class PlatformActionButton
    extends PlatformWidget<CupertinoDialogAction, FlatButton> {
  var title;
  Function onPress;
  bool boolValue;

  PlatformActionButton({@required this.onPress, @required this.title, @required this.boolValue});

  @override
  FlatButton createAndroidWidget(BuildContext context) {
    // TODO: implement createAndroidWidget
    return FlatButton(
        onPressed: () {
          onPress();
        },
        child: customText(title, 14, WidgetColors.blackColor, FontWeight.normal));
  }

  @override
  CupertinoDialogAction createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return CupertinoDialogAction(
      child: customText(title, 14, WidgetColors.blackColor, FontWeight.normal),
      onPressed: () {
        onPress();
      },
      isDestructiveAction: boolValue,
    );
  }
}

class PlatformScrollbar extends PlatformWidget<CupertinoScrollbar, Scrollbar> {
  Widget child;

  PlatformScrollbar({@required this.child});

  @override
  Scrollbar createAndroidWidget(BuildContext context) {
    // TODO: implement createAndroidWidget
    return Scrollbar(child: child);
  }

  @override
  CupertinoScrollbar createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    return CupertinoScrollbar(
      child: child,
    );
  }
}

