import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:adam_company_consumer_app/common/text_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobInProgressCard extends StatelessWidget {
  var userName;
  var userId;
  var userImage;

  JobInProgressCard({@required this.userId, this.userImage, this.userName});

  // Widget customText(
  //     var title, double height, Color color, FontWeight fontWeight) {
  //   return Text(
  //     title.toString(),
  //     style: GoogleFonts.montserrat(
  //       fontSize: height,
  //       color: color,
  //       fontWeight: fontWeight,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: height * .001,
            ),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(technician_profile_img + "/" + userImage),
            ),
            customText(userName, 14, Colors.black, FontWeight.normal),
            Container(
              width: width / 4,
              height: height * .03,
              decoration: BoxDecoration(
                  color: WidgetColors.buttonColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child:
                    customText(contect_data, 12, Colors.white, FontWeight.normal),
              ),
            ),
            Container(
              height: height * .001,
            )
          ],
        ),
      ),
    );
  }
}
