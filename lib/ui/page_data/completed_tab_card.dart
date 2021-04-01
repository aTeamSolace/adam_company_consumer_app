import 'package:adam_company_consumer_app/common/color_helper.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedTabCard extends StatelessWidget {
  var serviceTitle;
  var serviceDescription;
  var serviceDate;
  var serviceImage;
  var serviceAmount;
  Function viewDetails;
  var index;

  CompletedTabCard(
      {@required this.serviceTitle,
      @required this.serviceDate,
      @required this.serviceDescription,
      @required this.serviceImage,
      @required this.serviceAmount,
      @required this.viewDetails,
      @required this.index});

  // Widget customText(
  //   var title,
  //   double height,
  //   Color color,
  //   FontWeight fontWeight,
  // ) {
  //   return Text(title,
  //       style: GoogleFonts.poppins(
  //         fontSize: height,
  //         color: color,
  //         fontWeight: fontWeight,
  //       ),
  //       overflow: TextOverflow.ellipsis,
  //       textAlign: TextAlign.left);
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Hero(
      child: Center(
        child: Container(
          width: width  ,
          height: height * .2,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(2, 2), spreadRadius: 0.5)
              ]),
          child: Row(
            children: [
              Expanded(

                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Image.network(
                      serviceImage,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(WidgetColors.blackColor),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),
                    width: width / 3,
                    height: height * .2,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              new Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),

                  padding: const EdgeInsets.all(0.0),
                  width: width / 1.7,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(
                            text: serviceTitle.toString().toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: width * .05,
                                fontWeight: FontWeight.w500),
                            // children: <TextSpan>[
                            //   TextSpan(
                            //     text: ' (completed)',
                            //     style: GoogleFonts.poppins(
                            //         color: WidgetColors.buttonColor,
                            //         fontSize: 11),
                            //   ),
                            // ],
                          ),
                        ),
                        // Text(serviceDescription,
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: GoogleFonts.poppins()(
                        //       color: WidgetColors.blackColor,
                        //     )),

                        RichText(
                          text: TextSpan(
                            text: completed_at,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: width * .04,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text: serviceDate,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey.shade700,
                                    fontSize: width * .04),
                              ),
                            ],
                          ),
                        ),

                        // Text("Completed at: $serviceDate",
                        //     style: GoogleFonts.poppins()(
                        //       color: WidgetColors.blackColor,
                        //     )),
                        // Text("Amount Paid: \$$serviceAmount",
                        //     style: GoogleFonts.poppins()(
                        //       color: WidgetColors.blackColor,
                        //     )),
                        MaterialButtonClassPage(
                          height: height * .04,
                          radius: BorderRadius.circular(05),
                          buttonName: view_details,
                          onPress: () {
                            viewDetails();
                          },
                          color: WidgetColors.buttonColor,
                          minwidth: 50,
                          fontSize: width * .03,
                        ),
                        Container(
                          height: height * .001,
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      tag: index,
    );
  }
}
