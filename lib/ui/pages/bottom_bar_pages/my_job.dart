import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/tab_bar_pages/completed_services.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/tab_bar_pages/ongoing_service.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/tab_bar_pages/rejected_jobs.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/tab_bar_pages/requested_jobs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyJob extends StatefulWidget {
  int initialIndex;

  MyJob({this.initialIndex});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<MyJob>
    with SingleTickerProviderStateMixin {
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

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(
        vsync: this, length: 4, initialIndex: widget.initialIndex);
    // print("===========>>${widget.initialIndex}");
  }

  @override
  void dispose() {
    tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: WidgetColors.themeColor,
            centerTitle: true,
            title:
                customText(service_request, 18, WidgetColors.blackColor, FontWeight.w400),
            bottom: TabBar(
              labelColor: WidgetColors.blackColor,
              isScrollable: true,
              controller: tabController,
              indicatorColor: WidgetColors.blackColor,
              indicator: UnderlineTabIndicator(insets: EdgeInsets.symmetric(horizontal: 40.0)),
              tabs: [
                Tab(
                  text: s_requested,
                ),
                Tab(
                  text: s_ongoing,
                ),
                Tab(
                  text: s_completed,
                ),
                Tab(
                  text: s_rejected,
                ),
              ],
              labelStyle: GoogleFonts.poppins(fontSize: 15,color: WidgetColors.blackColor),
              unselectedLabelColor: Colors.black38,
            ),
          ),
          body: SafeArea(
              child: Container(
            color: WidgetColors.bgColor,
            child: TabBarView(
              controller: tabController,
              children: [
                RequestedJob(),
                OngoingServices(),
                CompletedService(),
                RejectedJobs()
              ],
            ),
          )),
        ));
  }
}
