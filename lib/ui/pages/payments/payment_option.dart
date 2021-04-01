import 'dart:convert';
import 'dart:io';

import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/network/model/get_card_details.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/add_credit_card.dart';
import 'package:adam_company_consumer_app/ui/pages/payments/payment_popup.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class PaymentOption extends StatefulWidget {
  var pending_amount;

  // var promo_code;
  var service_id;
  var technician_id;
  var app_price,
      payment_structure,
      total_amount_paid,
      payment_percent,
      last_payment_date,
      next_payment_date;

  PaymentOption(
      {this.pending_amount,
      // this.promo_code,
      this.service_id,
      this.technician_id,
      this.app_price,
      this.last_payment_date,
      this.next_payment_date,
      this.payment_percent,
      this.payment_structure,
      this.total_amount_paid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _selectionScreen();
  }
}
// 'payment_type'      => 'required',
// 'overall_payment_status' => 'required',
// 'job_cost_currency'    => 'required',

class _selectionScreen extends State<PaymentOption> {
  Future<GetCardDetails> getCardDetails;
  bool loading;

  @override
  initState() {
    loading = true;
    checkSessionValue();
    super.initState();
  }

  var user_id;

  checkSessionValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id = preferences.getString("user_id");
    getCardDetails = checkToekn();
  }

  var jsonResponce = [];

  Future<GetCardDetails> checkToekn() async {
    final response = await http.post(check_stripe_token, body: {
      "user_id": user_id.toString(),
    }).then((value) {
      setState(() {
        var jsonResult = json.decode(value.body);
        // print("Check Stripe token: ${jsonResult}");
        // print("Check Stripe token length: ${jsonResult['data'].length}");
        loading = false;
        if (jsonResult['data'].length == 0) {
          jsonResponce = [];
        } else {
          jsonResponce = jsonResult['data'][0]['data'];
        }
      });
    }).catchError((onError) {
      // print("Check Stripe token: ${onError}");
      ValidationData.customToast(onError.toString(), Colors.red, WidgetColors.whiteColor, ToastGravity.CENTER);
    });
  }

  Future saveCardDetails() async {
    final response = await http.post(save_stripe_details, body: {
      "user_id": user_id.toString(),
      "number": AllControllers.cardNumber.text.toString(),
      "exp_month": AllControllers.monthExp.text.toString(),
      "exp_year": AllControllers.yearExp.text.toString(),
      "cvc": AllControllers.cvc.text.toString()
    });
    final jsonResponce = json.decode(response.body);
    print("save_stripe_details : $jsonResponce");
    if (jsonResponce['status'] == 200) {
      Navigator.pop(context);
      getCardDetails = checkToekn();
      hideToken();
      ValidationData.customToast("Card Saved successfully!", Colors.black,
          WidgetColors.whiteColor, ToastGravity.BOTTOM);
    } else {
      ValidationData.customToast(jsonResponce['message'].toString(), Colors.red,
          WidgetColors.whiteColor, ToastGravity.CENTER);
      hideToken();
    }
  }

  Future removeCardDetails(var cardId, var custId) async {
    final response = await http.post(delete_stripe_details, body: {
      "card_id": cardId.toString(),
      "stripe_cust_id": custId.toString()
    });
    final jsonResponce = json.decode(response.body);
    if (jsonResponce['status'] == 200) {
      Navigator.pop(context);
      hideToken();
      ValidationData.customToast("Card Removed successfully!", Colors.black,
          WidgetColors.whiteColor, ToastGravity.BOTTOM);
      getCardDetails = checkToekn();
    } else {
      hideToken();
      ValidationData.customToast(jsonResponce['message'].toString(), Colors.red,
          WidgetColors.whiteColor, ToastGravity.CENTER);
    }
  }

  removeCardDetailsDialog(BuildContext context, var custId, var cardId) {
    Widget cancelButton = FlatButton(
      child: customText(cancel, 14, WidgetColors.buttonColor, FontWeight.w500),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: customText(
          continue_data, 14, WidgetColors.buttonColor, FontWeight.w500),
      onPressed: () {
        removeCardDetails(cardId, custId);
        creatingToken();
      },
    );

    AlertDialog alert = AlertDialog(
      title:
          customText("Warning", 14, WidgetColors.buttonColor, FontWeight.w500),
      content: customText("Do you really want to remoce this card?", 14,
          WidgetColors.buttonColor, FontWeight.w500),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  onWillPopMethod(BuildContext context) {
    // return BackFunction.fadeNavigationWithPush(
    //     context,
    //     SelectTechnician(
    //       serviceId: widget.service_id.toString(),
    //     ));
    return BackFunction.slideLeftNavigator(
        context,
        BottomNavBarPage(
          initialIndex: 1,
          initialIndexJob: 1,
        ));
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: customText(cancel, 14, WidgetColors.buttonColor, FontWeight.w500),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: customText(
          continue_data, 14, WidgetColors.buttonColor, FontWeight.w500),
      onPressed: () {
        setState(() {
          if (AllControllers.cardNumber.text.toString() != "" ||
              AllControllers.monthExp.text.toString() != "" ||
              AllControllers.yearExp.text.toString() != "" ||
              AllControllers.cvc.text.toString() != "") {
            saveCardDetails();
            creatingToken();
          } else {
            ValidationData.customToast("Please Fill All valid details!",
                Colors.red, WidgetColors.whiteColor, ToastGravity.CENTER);
          }
        });
      },
    );

    AlertDialog alert = AlertDialog(
      scrollable: true,
      title: customText(
          add_card_details, 14, WidgetColors.buttonColor, FontWeight.w500),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInputData(
            maxlength: 16,
            onChanged: () {},
            title: "",
            hintText: card_number,
            textEditingController: AllControllers.cardNumber,
            formFieldValidator: null,
            textInputType: TextInputType.number,
            textCapitalization: TextCapitalization.none,
            obsecureText: false,
            filledColor: WidgetColors.whiteColor,
            fill: true,
            enabledborderColor: Colors.black12,
            input_text_color: Colors.black,
            titleColor: Colors.black,
            hint_text_color: Colors.black45,
            error_text_color: Colors.black54,
            content_padding: 15,
            borderColor: Colors.black,
            blurRadius: 0,
            spreadRadius: 0,
            right: 0,
            left: 0,
            dy: 2,
            dx: 2,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextInputData(
                  maxlength: 2,
                  onChanged: () {},
                  title: "",
                  hintText: exp_month,
                  textEditingController: AllControllers.monthExp,
                  formFieldValidator: null,
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  obsecureText: false,
                  filledColor: WidgetColors.whiteColor,
                  fill: true,
                  enabledborderColor: Colors.black12,
                  input_text_color: Colors.black,
                  titleColor: Colors.black,
                  hint_text_color: Colors.black45,
                  error_text_color: Colors.black54,
                  content_padding: 15,
                  borderColor: Colors.black,
                  blurRadius: 0,
                  spreadRadius: 0,
                  right: 0,
                  left: 0,
                  dy: 2,
                  dx: 2,
                ),
              ),
              Expanded(
                child: CustomTextInputData(
                  maxlength: 2,
                  onChanged: () {},
                  title: "",
                  hintText: exp_year,
                  textEditingController: AllControllers.yearExp,
                  formFieldValidator: null,
                  textInputType: TextInputType.number,
                  textCapitalization: TextCapitalization.none,
                  obsecureText: false,
                  filledColor: WidgetColors.whiteColor,
                  fill: true,
                  enabledborderColor: Colors.black12,
                  input_text_color: Colors.black,
                  titleColor: Colors.black,
                  hint_text_color: Colors.black45,
                  error_text_color: Colors.black54,
                  content_padding: 15,
                  borderColor: Colors.black,
                  blurRadius: 0,
                  spreadRadius: 0,
                  right: 0,
                  left: 5,
                  dy: 2,
                  dx: 2,
                ),
              )
            ],
          ),
          CustomTextInputData(
            maxlength: 3,
            onChanged: () {},
            title: "",
            hintText: cvc,
            textEditingController: AllControllers.cvc,
            formFieldValidator: null,
            textInputType: TextInputType.number,
            textCapitalization: TextCapitalization.none,
            obsecureText: false,
            filledColor: WidgetColors.whiteColor,
            fill: true,
            enabledborderColor: Colors.black12,
            input_text_color: Colors.black,
            titleColor: Colors.black,
            hint_text_color: Colors.black45,
            error_text_color: Colors.black54,
            content_padding: 15,
            borderColor: Colors.black,
            blurRadius: 0,
            spreadRadius: 0,
            right: 0,
            left: 0,
            dy: 2,
            dx: 2,
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final signInscaffoldKey = GlobalKey<ScaffoldState>();

  creatingToken() {
    signInscaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: Colors.black26,
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
              backgroundColor: Colors.black87,
            ),
            SizedBox(
              height: 0,
              width: 20,
            ),
            Text(
              "Validate Data...",
              style: GoogleFonts.poppins(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ],
        )));
  }

  hideToken() {
    signInscaffoldKey.currentState.hideCurrentSnackBar();
  }

  BuildContext dialogContext;

  showCustomDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return Dialog(
            child: Container(
          child: Center(
            child: SpinKitHourGlass(
              color: WidgetColors.buttonColor,
            ),
          ),
          height: 100,
          width: 100,
        ));
      },
    );
  }

  hideCustomDialog() {
    Navigator.pop(dialogContext);
  }

  confirmPaymentDialog(BuildContext context, var cardId, var custId) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PlatformAlertBox(
          title: customText(
              "Payment", 14, WidgetColors.blackColor, FontWeight.w500),
          content: customText("Do you really want to procced with this card?",
              14, WidgetColors.blackColor, FontWeight.w500),
          list: [
            PlatformActionButton(
              title: cancel,
              onPress: () {
                Navigator.pop(context);
              },
              boolValue: false,
            ),
            PlatformActionButton(
              title: continue_data,
              onPress: () {
                getCardTokenDetails(cardId, custId);
                // creatingToken();
              },
              boolValue: true,
            )
          ],
        );
      },
    );
  }

  Future getCardTokenDetails(var cardId, var custId) async {
    Navigator.pop(context);
    showCustomDialog();
    final response = await http.post(get_stripe_details, body: {
      "card_id": cardId.toString(),
      "customer_id": custId.toString(),
      "user_id": user_id.toString()
    });
    final jsonResponce = json.decode(response.body);

    if (jsonResponce['status'] == 200) {
      var data = jsonResponce['data'];
      // print("getCardTokenDetails: ${data[0]["card_id"]}");
      // print("getCardTokenDetails: ${data}");
      makePayment(data[0]["card_id"], data[0]["stripe_cust_id"]);
    } else {
      hideCustomDialog();
      ValidationData.customToast(jsonResponce['message'].toString(), Colors.red,
          WidgetColors.whiteColor, ToastGravity.CENTER);
    }
  }

  Future makePayment(var paymentToken, var custId) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    // print(formattedDate);

    final response = await http.post(make_payment, body: {
      "job_id": widget.service_id.toString(),
      // 1 widget.service_id.toString()
      "technician_id": widget.technician_id.toString(),
      // widget.technician_id.toString()
      "total_amount": widget.pending_amount.toString(),
      "tax_amt": "10",
      "stripeToken": paymentToken.toString(),
      "customer_id": custId.toString()
    });
    // print("Stripe token with card :${paymentToken.tokenId.toString()}");
    // print("Make payment Responce :${response.body}");
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          final responseJson = json.decode(response.body);
          if (responseJson['status'] == 200) {
            var data = responseJson['data'];
            // print("===========>>${data['id']}");
            // print("===========>>${data['balance_transaction']}");
            // print("===========>>${data['payment_method']}");
            // print("===========>>${data['status']}");
            savePaymentInfo(
                data['id'].toString(),
                data['status'].toString(),
                data['balance_transaction'].toString(),
                data['payment_method'].toString(),
                formattedDate.toString());
          } else {
            hideCustomDialog();
            // Navigator.pop(dialogContext);
            // Navigator.of(this.context).push(PaymentPopup());
            ValidationData.customToast(responseJson['message'].toString(),
                Colors.black, Colors.white, ToastGravity.CENTER);
          }
        });
      }
    } else {
      hideToken();
      throw Exception('Failed to load profile data');
    }
  }

  Future savePaymentInfo(var jobpayment_id, var payment_status, var traction_id,
      var payment_method, var paymentDate) async {
    showCustomDialog();
    final responce = await http.post(save_payment_details, body: {
      "job_id": widget.service_id.toString(), // 11 widget.service_id.toString()
      "total_paid_amt": widget.pending_amount.toString(),
      "jobpayment_id": jobpayment_id.toString(),
      "payment_status": payment_status.toString(),
      "traction_id": traction_id.toString(),
      "payment_method": payment_method.toString(),
      "tax_amt": "34",
      "traction_details": "test",
      "payment_date": paymentDate.toString()
    });
    // print("savePaymentInfo :${responce.body}");
    final jsonData = json.decode(responce.body);
    if (jsonData['status'] == 200) {
      // Navigator.pop(dialogContext);
      if (this.mounted) {
        setState(() {
          hideCustomDialog();
          updatePaymentInfo();
          // Navigator.of(this.context).push(PaymentPopup());
        });
      }
    } else {
      hideCustomDialog();
      // Navigator.pop(dialogContext);
      ValidationData.customToast(jsonData['message'].toString(), Colors.black,
          Colors.white, ToastGravity.CENTER);
    }
  }

  Future updatePaymentInfo() async {
    final responce = await http.post(update_payment, body: {
      'job_id': widget.service_id.toString(),
      'technician_id': widget.technician_id.toString(),
      'app_price': widget.app_price.toString(),
      'payment_structure': widget.payment_structure.toString(),
      'total_amount_paid': widget.total_amount_paid.toString(),
      'payment_percent': widget.payment_percent.toString(),
      'pending_amount': widget.payment_percent.toString() == "100%"
          ? "0"
          : widget.pending_amount.toString(),
      'last_payment_date': widget.last_payment_date.toString(),
      'next_payment_date': widget.next_payment_date.toString(),
      'payment_type': widget.payment_structure.toString(),
      'overall_payment_status': 'success'
      // 'job_cost_currency': 'required',
    });
    // print("update_payment :${responce.body}");
    final jsonData = json.decode(responce.body);
    // print("update_payment :${jsonData}");
    if (jsonData['data'] == 1 || jsonData['data'] == "1") {
      // hideCustomDialog();
      Navigator.of(this.context).pushReplacement(PaymentPopup());
    } else {
      ValidationData.customToast(jsonData['message'].toString(), Colors.black,
          Colors.white, ToastGravity.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          key: signInscaffoldKey,
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
              payment_otn,
              style: TextStyle(fontSize: 18,color: WidgetColors.blackColor),
            ),
          ),
          body: Container(
              height: height,
              width: width,
              child: PlatformScrollbar(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      child: Column(
                        children: [
                          Container(
                            height: height * .03,
                          ),
                          Container(
//                            height: height / 4.7,
                            margin: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(2, 2))
                                ],
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  title: customText(itm_total, width * .04,
                                      Colors.grey.shade600, FontWeight.w600),
                                  trailing: customText(
                                      "\$${widget.pending_amount.toString()}",
                                      width * .04,
                                      Colors.grey.shade600,
                                      FontWeight.w600),
                                ),
                                // ListTile(
                                //   title: customText("10% Fees",  width * .04,
                                //       Colors.grey.shade600, FontWeight.w600),
                                //   trailing: customText(
                                //       "\$${4.6.toString()}",
                                //       width * .04,
                                //       Colors.grey.shade600,
                                //       FontWeight.w600),
                                // ),
                                // ListTile(
                                //   title: customText("Promo",  width * .04,
                                //       Colors.grey.shade600, FontWeight.w600),
                                //   trailing: customText(
                                //       "\$${34.00.toString()}",
                                //       width * .04,
                                //       Colors.grey.shade600,
                                //       FontWeight.w600),
                                // ),
                                Divider(
                                  color: Colors.black,
                                ),
                                ListTile(
                                  title: customText(total_data, width * .04,
                                      Colors.black, FontWeight.w600),
                                  trailing: customText(
                                      "\$${widget.pending_amount.toString()}",
                                      16,
                                      Colors.black,
                                      FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: height * .02,
                          ),
                          Container(
                            child: loading
                                ? Center(
                                    child: PlatformLoader(
                                      color: WidgetColors.buttonColor,
                                      radius: 15,
                                    ),
                                  )
                                : Container(
                                    height: 150,
                                    child: jsonResponce.length > 0
                                        ? PlatformScrollbar(
                                            child: PageView.builder(
                                            scrollDirection: Axis.vertical,
                                            // shrinkWrap: true,
                                            itemCount: jsonResponce.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Center(
                                                  child: InkWell(
                                                onTap: () {
                                                  confirmPaymentDialog(
                                                      context,
                                                      jsonResponce[index]['id']
                                                          .toString(),
                                                      jsonResponce[index]
                                                              ['customer']
                                                          .toString());
                                                },
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .shade400,
                                                              spreadRadius: 2,
                                                              blurRadius: 2,
                                                              offset:
                                                                  Offset(2, 2))
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Column(
                                                      children: [
                                                        ListTile(
                                                          title: customText(
                                                              "Card",
                                                              18,
                                                              Colors.black,
                                                              FontWeight.bold),
                                                        ),
                                                        ListTile(
                                                            leading: Image.asset(
                                                                "assets/credit_card.png"),
                                                            title: customText(
                                                                "**** **** **** ${jsonResponce[index]['last4'].toString()}",
                                                                16,
                                                                Colors.grey
                                                                    .shade700,
                                                                FontWeight
                                                                    .w400),
                                                            subtitle: customText(
                                                                "Expires ${jsonResponce[index]['exp_month'].toString()}/${jsonResponce[index]['exp_year'].toString()}",
                                                                14,
                                                                Colors.grey
                                                                    .shade700,
                                                                FontWeight
                                                                    .w400),
                                                            trailing:
                                                                IconButton(
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              onPressed: () {
                                                                removeCardDetailsDialog(
                                                                    context,
                                                                    jsonResponce[
                                                                            index]
                                                                        [
                                                                        'customer'],
                                                                    jsonResponce[
                                                                            index]
                                                                        ['id']);
                                                              },
                                                            ))
                                                      ],
                                                    )),
                                              ));
                                            },
                                          ))
                                        : Container(),
                                  ),
                          ),
                          Container(
                            height: height * .03,
                          ),
                          InkWell(
                            child: Container(
                              height: height * .06,
                              width: width,
                              margin: EdgeInsets.only(
                                left: 32,
                                right: 32,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: WidgetColors.buttonColor),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(05),
                              ),
                              child: Center(
                                child: customText(
                                    add_payment_method,
                                    width * .04,
                                    WidgetColors.buttonColor,
                                    FontWeight.w400),
                              ),
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            },
                          ),
                          Container(
                            height: height * .03,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(
                          //     left: 32,
                          //     right: 32,
                          //   ),
                          //   child: MaterialButtonClassPage(
                          //     height: height * .06,
                          //     radius: BorderRadius.circular(05),
                          //     buttonName: pay_nw,
                          //     onPress: () {
                          //       BackFunction.commonNavigator(
                          //           context,
                          //           AddCreditCard(
                          //             technician_id:
                          //                 widget.technician_id.toString(),
                          //             pending_amount: widget.pending_amount.toString(),
                          //             service_id: widget.service_id.toString(),
                          //           ));
                          //     },
                          //     color: WidgetColors.buttonColor,
                          //     minwidth: width,
                          //     fontSize: width * .04,
                          //   ),
                          // ),
                          Container(
                            height: height * .03,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 0, right: 0),
                    )),
              )),
        ),
        onWillPop: () {
          return onWillPopMethod(context);
        });
  }
}
