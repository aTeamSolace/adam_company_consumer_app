import 'package:adam_company_consumer_app/common/color_helper.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/bottom_bar_pages/description/technician_description.dart';
import 'package:adam_company_consumer_app/widget/button_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnisianCard extends StatelessWidget {
  var tag;
  var name;
  var location;
  var distance;
  var rating;
  var profile_pic;
  var id;
  var type;
  var phone;
  var job_details;
  var serviceId;

  TechnisianCard(
      {@required this.tag,
      @required this.name,
      @required this.location,
      @required this.distance,
      @required this.rating,
      @required this.profile_pic,
      @required this.id,
      @required this.type,
      @required this.job_details,
      @required this.phone,
      this.serviceId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Hero(
        tag: tag,
        child: Card(
          elevation: 7,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(05)),
                  height: height / 4.7,
                  width: width,
                  child: Row(
                    children: [
                      Container(
                        width: width / 3,
                        height: height / 4.7,
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          placeholder: AssetImage(tech),
                          image: NetworkImage(
                            profile_pic,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey, offset: Offset(2, 2))
                            ],
                            borderRadius: BorderRadius.circular(05)),
                      ),
                      Container(
                        width: 8,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: "",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: name,
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * .04),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                              ),
                            ),
                            customText(location, width * .04, Colors.black,
                                FontWeight.w300),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_sharp,
                                        color: WidgetColors.buttonColor,
                                        size: width * .04,
                                      ),
                                      customText(
                                          "${distance} km to city",
                                          width * .04,
                                          Colors.black,
                                          FontWeight.w300),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            RatingBar(
                              itemSize: height * .02,
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: WidgetColors.buttonColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButtonClassPage(
                                height: height * .04,
                                radius: BorderRadius.circular(05),
                                buttonName: view_details,
                                onPress: () {},
                                color: WidgetColors.buttonColor,
                                minwidth: width / 3,
                                fontSize: height * .02,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Positioned(
                left: 0.0,
                top: 0.0,
                bottom: 0.0,
                right: 0.0,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 200));
                      // BackFunction.slideLeftNavigator(
                      //     context,
                      //     TechnisianDetails(
                      //       serviceId: serviceId.toString(),
                      //       tag: tag,
                      //       phone: phone,
                      //       location: location,
                      //       id: id,
                      //       name: name,
                      //       job_details: job_details,
                      //       type: type,
                      //       profile_pic: profile_pic,
                      //     ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class TechnisianCardSelect extends StatelessWidget {
  var tag;
  var name;
  var location;
  var distance;
  var rating;
  var profile_pic;
  var technician_id;
  var type;
  var phone;
  var job_details;
  var serviceId;
  var service_name;
  var service_price;
  var service_date;

  TechnisianCardSelect(
      {@required this.tag,
      @required this.name,
      this.location,
      @required this.profile_pic,
      @required this.technician_id,
      @required this.service_price,
      @required this.service_date,
      this.type,
      this.job_details,
      this.phone,
      @required this.serviceId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Hero(
        tag: tag,
        child: Card(
          elevation: 7,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.transparent,
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(05)),
                  height: height / 4.7,
                  width: width,
                  child: Row(
                    children: [
                      Container(
                        width: width / 3,
                        height: height / 4.7,
                        child: FadeInImage(
                          fit: BoxFit.fill,
                          placeholder: AssetImage(tech),
                          image: NetworkImage(
                            profile_pic,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey, offset: Offset(2, 2))
                            ],
                            borderRadius: BorderRadius.circular(05)),
                      ),
                      Container(
                        width: 8,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: name,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: width * .05,
                                      fontWeight: FontWeight.w500),
                                  // children: <TextSpan>[
                                  //   TextSpan(
                                  //     text: name,
                                  //     style: GoogleFonts.poppins(
                                  //         color: Colors.black,
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: width * .05),
                                  //   ),
                                  // ],
                                ),
                                maxLines: 2,
                              ),
                            ),
                            customText(location, width * .04, Colors.black,
                                FontWeight.w300),

                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  text: "Price : ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: width * .05,
                                      fontWeight: FontWeight.normal),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: service_price.toString(),
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: width * .04),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                              ),
                            ),

                            // customText(location, width * .04, Colors.black,
                            //     FontWeight.w300),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Container(
                            //       child: Row(
                            //         children: [
                            //           Icon(
                            //             Icons.location_on_sharp,
                            //             color: WidgetColors.buttonColor,
                            //             size: width * .04,
                            //           ),
                            //           customText(
                            //               "${distance} km to city",
                            //               width * .04,
                            //               Colors.black,
                            //               FontWeight.w300),
                            //         ],
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // RatingBar(
                            //   itemSize: height * .02,
                            //   initialRating: rating,
                            //   minRating: 1,
                            //   direction: Axis.horizontal,
                            //   allowHalfRating: true,
                            //   itemCount: 5,
                            //   itemPadding:
                            //   EdgeInsets.symmetric(horizontal: 2.0),
                            //   itemBuilder: (context, _) => Icon(
                            //     Icons.star,
                            //     color: WidgetColors.buttonColor,
                            //   ),
                            //   onRatingUpdate: (rating) {
                            //     print(rating);
                            //   },
                            // ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: MaterialButtonClassPage(
                                height: height * .04,
                                radius: BorderRadius.circular(05),
                                buttonName: view_details,
                                onPress: () {},
                                color: WidgetColors.buttonColor,
                                minwidth: width / 3,
                                fontSize: height * .02,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Positioned(
                left: 0.0,
                top: 0.0,
                bottom: 0.0,
                right: 0.0,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 200));
                      BackFunction.slideLeftNavigator(
                          context,
                          TechnisianDetails(
                            serviceId: serviceId.toString(),
                            tag: tag,
                            phone: phone,
                            location: location,
                            id: technician_id,
                            name: name,
                            job_details: job_details,
                            type: type,
                            profile_pic: profile_pic, tech_cost: service_price.toString(), tech_date: service_date.toString(),
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
