import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_option.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatefulWidget {
  var serviceId;
  var technician_id;

  PaymentScreen({this.serviceId, this.technician_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}

class _selectionScreen extends State<PaymentScreen> {
  @override
  initState() {
    getPaymentInfo();

    super.initState();
  }

  onWillPopMethod(BuildContext context) {
    // return BackFunction.fadeNavigationWithPush(
    //     context,
    //     SelectTechnician(
    //       serviceId: widget.serviceId.toString(),
    //     ));

    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 1,
        ));
  }

  var paymentInfo = [];
  bool loading = false;

  // widget.serviceId.toString()
  Future getPaymentInfo() async {
    final response = await http.post(get_payment_details, body: {
      "job_id": widget.serviceId.toString(),
      "technician_id": widget.technician_id.toString()
    });
    final responseJson = json.decode(response.body);
    paymentInfo = responseJson['data'];
    setState(() {
      loading = true;
    });

    // print("getPaymentInfo:- ${paymentInfo}");
    // print("getPaymentInfo:- ${paymentInfo[0]['total_amount_paid']}");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          backgroundColor: WidgetColors.bgColor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: WidgetColors.blackColor),
            leading: IconButton(
                icon: Platform.isIOS
                    ? Icon(
                        Icons.arrow_back_ios,
                        color: WidgetColors.blackColor,
                      )
                    : Icon(
                        Icons.arrow_back,
                        color: WidgetColors.blackColor,
                      ),
                onPressed: () {
                  onWillPopMethod(context);
                }),
            backgroundColor: WidgetColors.themeColor,
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(
              payment_data,
              style: GoogleFonts.poppins(fontSize: 18,color: WidgetColors.blackColor),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              child: loading
                  ? Container(
                      child: paymentInfo.length == 0 ||
                              paymentInfo.toString() == "0"
                          ? Container(
                              child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Center(
                                child: customText(
                                    no_payment_data_avail,
                                    width * .05,
                                    WidgetColors.blackColor,
                                    FontWeight.w500),
                              ),
                            ))
                          : PlatformScrollbar(
                              child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Padding(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: height / 7.7,
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ListTile(
                                                title: customText(
                                                    "Total",
                                                    width * .05,
                                                    Colors.black,
                                                    FontWeight.w600),
                                                trailing: customText(
                                                    "\$${paymentInfo[0]['total_amount_paid'].toString()}",
                                                    width * .05,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                              // ListTile(
                                              //   title: customText("Item total", 15,
                                              //       Colors.grey.shade600, FontWeight.w600),
                                              //   trailing: customText(
                                              //       "\$${56.87.toString()}",
                                              //       16,
                                              //       Colors.grey.shade600,
                                              //       FontWeight.w600),
                                              // ),
                                              // Divider(
                                              //   color: Colors.grey,
                                              // ),
                                              // ListTile(
                                              //   title: customText("Total", 16, Colors.black,
                                              //       FontWeight.w600),
                                              //   trailing: customText("\$${120.toString()}",
                                              //       16, Colors.black, FontWeight.w600),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        // Container(
                                        //   height: height * .02,
                                        // ),
                                        // Container(
                                        //     height: height / 7.7,
                                        //     padding: EdgeInsets.only(
                                        //         left: 10, right: 04),
                                        //     color: Colors.white,
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceAround,
                                        //       children: [
                                        //         Image.asset(
                                        //           "assets/discount.png",
                                        //           color: Colors.black,
                                        //           height: 40,
                                        //           width: 40,
                                        //         ),
                                        //         Column(
                                        //           mainAxisAlignment:
                                        //               MainAxisAlignment.center,
                                        //           crossAxisAlignment:
                                        //               CrossAxisAlignment.start,
                                        //           children: [
                                        //             customText(
                                        //                 "Offers, Promo code And Gift Card",
                                        //                 width * .04,
                                        //                 Colors.black,
                                        //                 FontWeight.w400),
                                        //             Container(
                                        //               height: height * .01,
                                        //             ),
                                        //             customText(
                                        //                 "2 offers available",
                                        //                 width * .03,
                                        //                 Colors.black,
                                        //                 FontWeight.w400),
                                        //           ],
                                        //         ),
                                        //         Icon(
                                        //           Icons
                                        //               .arrow_forward_ios_outlined,
                                        //           size: 20,
                                        //         )
                                        //       ],
                                        //     )),

                                        Container(
                                          height: height * .02,
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: customText(
                                                    payment_otn_mode,
                                                    width * .05,
                                                    Colors.black,
                                                    FontWeight.bold),
                                              ),
                                              ListTile(
                                                title: customText(
                                                    payment_total,
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                                trailing: customText(
                                                    "\$${paymentInfo[0]['app_price'].toString()}",
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                              ),
                                              ListTile(
                                                title: customText(
                                                    "Amount to Pay(${paymentInfo[0]['payment_structure'].toString()}%)",
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                                trailing: customText(
                                                    "\$${paymentInfo[0]['total_amount_paid'].toString()}",
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                              ),
                                              ListTile(
                                                title: customText(
                                                    payment_remaining,
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                                trailing: customText(
                                                    "\$${paymentInfo[0]['pending_amount'].toString()}",
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                              ),
                                              ListTile(
                                                title: customText(
                                                    payment_remaing_date,
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                                trailing: customText(
                                                    paymentInfo[0][
                                                      'last_payment_date']
                                                        .toString(),
                                                    width * .04,
                                                    Colors.grey.shade700,
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: height * .03,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 32,
                                            right: 32,
                                          ),
                                          child: MaterialButtonClassPage(
                                            height: height * .06,
                                            radius: BorderRadius.circular(05),
                                            buttonName: continue_data,
                                            onPress: () {
                                              BackFunction.slideRightNavigator(
                                                  context,
                                                  PaymentOption(
                                                    technician_id: widget
                                                        .technician_id
                                                        .toString(),
                                                    service_id: widget.serviceId
                                                        .toString(),
                                                    pending_amount: paymentInfo[
                                                            0]['pending_amount']
                                                        .toString(),
                                                    app_price: paymentInfo[0]
                                                            ['app_price']
                                                        .toString(),
                                                    last_payment_date: paymentInfo[
                                                                0][
                                                            'last_payment_date']
                                                        .toString(),
                                                    next_payment_date: paymentInfo[
                                                                0][
                                                            'next_payment_date']
                                                        .toString(),
                                                    payment_percent: paymentInfo[
                                                                0]
                                                            ['payment_percent']
                                                        .toString(),
                                                    payment_structure: paymentInfo[
                                                                0][
                                                            'payment_structure']
                                                        .toString(),
                                                    total_amount_paid: paymentInfo[
                                                                0][
                                                            'total_amount_paid']
                                                        .toString(),
                                                  ));
                                            },
                                            color: WidgetColors.buttonColor,
                                            minwidth: width,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Container(
                                          height: height * .03,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                  )),
                            ),
                    )
                  : Center(
                      child: PlatformLoader(
                        color: WidgetColors.buttonColor,
                        radius: 15,
                      ),
                    )),
        ),
        onWillPop: () {
          return onWillPopMethod(context);
        });
  }
}
