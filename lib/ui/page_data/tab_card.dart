import 'package:adam_company_consumer_app/common/color_helper.dart';
import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/ui/pages/select_technician.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabCard extends StatelessWidget {
  var serviceTitle;
  var serviceDescription;
  var serviceDate;
  var serviceImage;
  Function viewDetails;
  var service_id;
  var index;
  TabCard(
      {@required this.serviceTitle,
      @required this.serviceDate,
      @required this.serviceDescription,
      @required this.serviceImage,@required this.viewDetails,
      @required this.index, @required this.service_id});


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Hero(
      tag: index,
      child: Center(
        child: Container(
          width: width,
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
                // alignment: Alignment.centerLeft,
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
                      loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(WidgetColors.blackColor),
                            value: loadingProgress.expectedTotalBytes != null ?
                            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
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
                  width: width / 1.8,
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
                            children: <TextSpan>[
                              TextSpan(
                                text: pending,
                                style: GoogleFonts.poppins(
                                    color: WidgetColors.buttonColor,
                                    fontSize: width * .03),
                              ),
                            ],
                          ),
                        ),
                        // Text(
                        //   serviceDescription,
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        //     style :GoogleFonts.poppins()(
                        //         color: WidgetColors.blackColor,
                        //          )
                        // ),
                        // Text(
                        //   "Date: $serviceDate",
                        //     style :GoogleFonts.poppins()(
                        //       color: WidgetColors.blackColor,
                        //       fontWeight: FontWeight.w500
                        //     )
                        // ),

                        RichText(
                          text: TextSpan(
                            text: date_,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: width * .04,
                                fontWeight: FontWeight.w500),
                            children: <TextSpan>[
                              TextSpan(
                                text:  serviceDate,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey.shade700,
                                    fontSize: width * .04,
                                     ),
                              ),
                            ],
                          ),
                        ),

                        // RichText(
                        //   text: TextSpan(
                        //     text: "Rejected at: ",
                        //     style: GoogleFonts.poppins(
                        //         color: Colors.black,
                        //         fontSize: 15,
                        //         fontWeight: FontWeight.w500),
                        //     children: <TextSpan>[
                        //       TextSpan(
                        //         text: serviceDate,
                        //         style: GoogleFonts.poppins(
                        //             color: WidgetColors.blackColor, fontSize: 14),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Row(
                          children: [

                            Container(
                              width: 12,
                            ),
                            Expanded(
                              child: MaterialButtonClassPage(
                                height: height * .04,
                                radius: BorderRadius.circular(05),
                                buttonName: view_details,
                                onPress: () {
                                  viewDetails();
                                },
                                color: WidgetColors.buttonColor,
                                minwidth: 50,
                                fontSize: 10,
                              ),
                            ),
                            Container(
                              width: 12,
                            ),
                            // Expanded(
                            //   child: MaterialButtonClassPage(
                            //     height: height * .04,
                            //     radius: BorderRadius.circular(05),
                            //     buttonName: tech_name,
                            //     onPress: () {
                            //       BackFunction.fadeNavigation(context, SelectTechnician(serviceId: service_id.toString(),));
                            //     },
                            //     color: WidgetColors.buttonColor,
                            //     minwidth: 100,
                            //     fontSize: 10,
                            //   ),
                            // )
                          ],
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
    );
  }
}
